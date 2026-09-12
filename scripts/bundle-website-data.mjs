// Run with an authorized website checkout; never copies credentials/name days.
// TZ=Europe/Helsinki node scripts/bundle-website-data.mjs /path/to/weekdays
import { resolve } from 'node:path';
import { pathToFileURL } from 'node:url';
import { createRequire } from 'node:module';
import { execFileSync } from 'node:child_process';
import { mkdirSync, writeFileSync } from 'node:fs';
const root = resolve(process.argv[2]);
const load = (path) => import(pathToFileURL(resolve(root, path)));
const revision = execFileSync('git', ['-C', root, 'rev-parse', 'HEAD'], { encoding: 'utf8' }).trim();
const calendar = JSON.parse(execFileSync(process.execPath,
  ['scripts/emit-calendar-fixtures.mjs', root], { encoding: 'utf8', maxBuffer: 10e6 }));
const { HOLIDAY_DEFINITIONS } = await load('src/data/holidayPages.js');
const { faqCategories } = await load('src/data/faqs.js');
const { englishFaqs } = await load('src/data/englishContent.js');
const { whatWeekFaqs, weekStartsMondayFaqs } = await load('src/data/isoWeekContent.js');
const { finlandVsUsaFaqs } = await load('src/data/finlandVsUsaContent.js');
const { dataSourcesFaqs, methodologyFaqs, editorialPolicyFaqs } = await load('src/data/trustPages.js');
const { weeksInYearFaqs } = await load('src/data/weeksInYearContent.js');
const source = { repository: 'link2dawood/weekdays', revision };
mkdirSync('assets/data', { recursive: true });
const write = (name, data) => writeFileSync(`assets/data/${name}.json`, JSON.stringify(data) + '\n');
write('calendar', { version: 1, source, range: calendar.range, years: calendar.years,
  schoolHolidays: calendar.schoolHolidays, schoolHolidaySources: calendar.schoolHolidaySources,
  holidayDefinitions: HOLIDAY_DEFINITIONS });
write('information', { source, faqCategories, englishFaqs,
  articles: {
    'mika-on-viikkonumero': whatWeekFaqs,
    'viikko-alkaa-maanantaista': weekStartsMondayFaqs,
    'kuinka-monta-viikkoa-vuodessa': weeksInYearFaqs(2026),
    'suomi-vs-usa-viikkonumerot': finlandVsUsaFaqs(),
    'tietolahteet': dataSourcesFaqs(),
    'menetelma': methodologyFaqs(),
    'toimitusperiaatteet': editorialPolicyFaqs(),
  }});
// Use the exact installed website solar engine; store Helsinki civil times.
const require = createRequire(resolve(root, 'package.json'));
const sun = await import(pathToFileURL(require.resolve('suncalc')));
const { getTimes, getPosition } = sun.default ?? sun;
const fmt = (date) => `${date.getFullYear()}-${String(date.getMonth()+1).padStart(2,'0')}-${String(date.getDate()).padStart(2,'0')}`;
const time = (date) => Number.isNaN(date.valueOf()) ? null : new Intl.DateTimeFormat('fi-FI', {
  timeZone:'Europe/Helsinki',hour:'2-digit',minute:'2-digit',hourCycle:'h23',
}).format(date);
const days = {};
for (let y = 2020; y <= 2035; y++) {
  for (let d = new Date(y,0,1,12); d.getFullYear() === y; d.setDate(d.getDate()+1)) {
    const t = getTimes(d,60.1699,24.9384);
    const polar = Number.isNaN(t.sunrise.valueOf());
    const polarDay = polar && getPosition(d,60.1699,24.9384).altitude > 0;
    days[fmt(d)] = { sunrise:time(t.sunrise),sunset:time(t.sunset),polarDay,
      polarNight:polar&&!polarDay,daylightMinutes:polar?(polarDay?1440:0):Math.round((t.sunset-t.sunrise)/60000)};
  }
}
write('sun', { source, location: 'Helsinki', timeZone:'Europe/Helsinki', days });
console.log(`Bundled 16 calendar years, ${Object.keys(days).length} Helsinki solar dates, and website information.`);
