// Run against the website checkout. The page model carries the actual
// confidence tiers; the legacy schoolHolidays.js has incomplete metadata.
import { createHash } from 'node:crypto';
import { readFileSync } from 'node:fs';
import { resolve } from 'node:path';
import { pathToFileURL } from 'node:url';
import { execFileSync } from 'node:child_process';

const root = resolve(process.argv[2] ?? '.');
const load = (path) => import(pathToFileURL(resolve(root, path)));
const { holidaysInYear } = await load('src/data/holidays.js');
const { getLiputuspaivat } = await load('src/data/juhlapaivat.js');
const { schoolHolidayYears, schoolHolidayPage, SCHOOL_HOLIDAY_SOURCES,
  pageConfidenceTier } = await load('src/data/schoolHolidayPages.js');
const revision = process.env.SOURCE_REVISION ??
  execFileSync('git', ['-C', root, 'rev-parse', 'HEAD'], { encoding: 'utf8' }).trim();
const fmt = (d) => `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')}`;

// Date.toJSON uses UTC, which changes Finnish midnight to the previous date.
// Walk Dates before JSON.stringify can invoke their toJSON method.
function civilDates(value) {
  if (value instanceof Date) return fmt(value);
  if (Array.isArray(value)) return value.map(civilDates);
  if (value !== null && typeof value === 'object') {
    return Object.fromEntries(Object.entries(value).map(([k, v]) => [k, civilDates(v)]));
  }
  return value;
}

const years = [];
for (let year = 2020; year <= 2035; year++) {
  years.push({
    year,
    holidays: civilDates(holidaysInYear(year)),
    flagDays: [...getLiputuspaivat(year)].sort(([a], [b]) => a.localeCompare(b))
      .map(([date, names]) => ({ date: `${year}-${date}`, names })),
  });
}
const schoolHolidays = schoolHolidayYears.map((year) => {
  const page = civilDates(schoolHolidayPage(year));
  for (const period of [...page.winter, ...page.autumn]) {
    if (!['confirmed', 'estimated', 'unknown'].includes(period.confidence)) {
      throw new Error(`Missing school-holiday confidence: ${year}`);
    }
  }
  return { ...page, confidence: pageConfidenceTier(year) };
});
const sourceFiles = ['src/components/dateUtils.js', 'src/data/holidays.js',
  'src/data/juhlapaivat.js', 'src/data/schoolHolidayPages.js'];
process.stdout.write(JSON.stringify({
  schema: 1,
  source: 'https://github.com/link2dawood/weekdays',
  revision,
  sourceSha256: Object.fromEntries(sourceFiles.map((path) => [path,
    createHash('sha256').update(readFileSync(resolve(root, path))).digest('hex')])),
  range: [2020, 2035],
  years,
  schoolHolidaySources: SCHOOL_HOLIDAY_SOURCES,
  schoolHolidays,
}, null, 2) + '\n');
