# Deploying, testing and rolling back

## Two Workers, two databases

| | Live | Test |
|---|---|---|
| Worker | `nairatrack` (https://lissafiapp.pages.dev) | `lissafi-test` (https://lissafi-test.sunusizainab640.workers.dev) |
| Database (D1) | `5f2f9b71-7a0a-4e9e-ab96-e27555e621f3` | `lissafi-test-db` `8fa1336a-fec0-4a6e-9994-eecc3c2074e9` (demo shops only) |
| Settings store (KV, binding `TK`) | `aefbc3d0a2194ac8bf66460ffaaeebf5` | same (shared) |
| AI binding | `AI` | `AI` |
| Daily cron jobs | `3 18 * * *`, `3 7 * * *`, `7 23 * * *` (8am and 7pm Lagos pushes) | none |

The test database is a copy of the schema plus the 20 demo shops. Real shops are never copied to it.

## Rules

1. All new work goes to `lissafi-test` first and is checked there.
2. `nairatrack` is only changed after an explicit "Go live" from the owner.
3. Any database change (new column or table) is applied to BOTH databases and added to `db/schema.sql`.
4. Cron triggers live on the Worker and survive code uploads. Check them after a deploy.

## How a change is made

The current build is stored in the KV namespace `77913ed9bc92460ba4b1833c185efb8f` under the key
`nairatrack-build-2026-11-15`. A change is an exact-text replacement on that file (each replacement asserts
it matches exactly the expected number of places), then the result is written back to KV and uploaded to the
Worker as a single ES module (`worker.js`, `main_module`), with the bindings `AI`, `DB`, `TK` and
compatibility date `2026-11-01`. For live, reuse the bindings from `/workers/scripts/nairatrack/settings`.

Before every change, copy the current build to a rollback key, for example
`nairatrack-rollback-2026-11-16-preoffline`.

## Rolling back

Read the rollback key from KV and upload it to the Worker the same way. Existing rollback keys:
`nairatrack-rollback-2026-11-16-prefix`, `-prefix2`, `-prefix3`, `-prefix4`, `-prelive-assistant`, `-preoffline`,
plus the earlier `-branches` and `-pretools`. Database columns that were added are additive and do not need rolling back.

## Checking after a deploy

- `/sw.js` on the site shows the new service worker.
- Open `/demo`, take a Quick sale, then delete the test sale from the invoice page.
- Real businesses: names must not be touched when testing admin commands. Use demo shops on the test site.
