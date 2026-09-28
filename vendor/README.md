# Excel export dependency

ExcelJS 4.4.0, distributed under the MIT license in `exceljs-LICENSE.txt`.

- Project: https://github.com/exceljs/exceljs/tree/v4.4.0
- Browser bundle: https://cdn.jsdelivr.net/npm/exceljs@4.4.0/dist/exceljs.min.js

The pinned browser bundle is served with the application and loaded only when a key sheet is exported. The service worker caches it for offline exports. No key data is sent to an external conversion service.

The export regression check uses Playwright and Chrome:

`node scripts/test-key-excel-export.cjs`

`PLAYWRIGHT_MODULE` and `CHROME_PATH` can select an existing Playwright installation and browser. The generated test workbook is written to `output/export-signatures-test/`.

On Windows with Excel installed, `scripts/test-key-excel-native.ps1` opens this fixture read-only and checks that all signatures fit within the correct movement cells. The export uses two-cell bounds with `editAs="oneCell"` for compatibility with Excel 2007; ExcelJS 4.4.0's one-cell anchor serializer emits an invalid attribute rejected by that version.

# Realtime notification dependency

Supabase JS 2.110.8, distributed under the MIT license in `supabase-LICENSE.txt`.

- Project: https://github.com/supabase/supabase-js/tree/v2.110.8
- Browser bundle: https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2.110.8/dist/umd/supabase.js

The pinned browser bundle is served locally and loaded after the initial cloud state. It listens only for the small app-state heartbeat; actual key data is still read through the existing REST client and its conflict checks. Polling remains the fallback when Realtime is unavailable.
