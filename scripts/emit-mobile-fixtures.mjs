// Can live in the website's scripts/ directory, or accept a website checkout.
// node scripts/emit-mobile-fixtures.mjs /path/to/Viikkonro > fixture.json
import { createHash } from 'node:crypto';
import { readFileSync } from 'node:fs';
import { resolve } from 'node:path';
import { pathToFileURL } from 'node:url';
import { execFileSync } from 'node:child_process';

const root = resolve(process.argv[2] ?? '.');
const modulePath = resolve(root, 'src/components/dateUtils.js');
const { isoWeek, isoYear, mondayOf, weeksInIsoYear, fmtFullFi, fmtRangeFi,
  M_GENITIVE, M_PARTITIVE, WD } = await import(pathToFileURL(modulePath));
const revision = process.env.SOURCE_REVISION ??
  execFileSync('git', ['-C', root, 'rev-parse', 'HEAD'], { encoding: 'utf8' }).trim();
const pad = (n) => String(n).padStart(2, '0');
const fmt = (d) => `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())}`;
const dates = [];
const years = [];
for (let year = 2020; year <= 2035; year++) {
  for (let month = 0; month < 12; month++) {
    for (let day = 1; day <= new Date(year, month + 1, 0).getDate(); day++) {
      const date = new Date(year, month, day);
      dates.push({ date: fmt(date), week: isoWeek(date), isoYear: isoYear(date),
        finnishLong: fmtFullFi(date) });
    }
  }
  const weeks = [];
  for (let week = 1; week <= weeksInIsoYear(year); week++) {
    const monday = mondayOf(week, year);
    const sunday = new Date(monday);
    sunday.setDate(monday.getDate() + 6);
    weeks.push({ week, monday: fmt(monday), sunday: fmt(sunday),
      finnishRange: fmtRangeFi(monday, sunday) });
  }
  years.push({ year, weeksInYear: weeksInIsoYear(year), weeks });
}
process.stdout.write(JSON.stringify({
  schema: 1,
  source: 'https://github.com/link2dawood/weekdays',
  revision,
  sourceFile: 'src/components/dateUtils.js',
  sourceSha256: createHash('sha256').update(readFileSync(modulePath)).digest('hex'),
  range: [2020, 2035],
  finnish: { monthGenitive: M_GENITIVE, monthPartitive: M_PARTITIVE, weekdays: WD },
  dates,
  years,
}, null, 2) + '\n');
