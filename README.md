# Lissafi

Business-management software for small Nigerian businesses (an operating system for a shop, not just an app).
Live at https://lissafiapp.pages.dev. Private repository: keep it private.

## What is (and is not) in this repo

- `db/schema.sql`: the full database layout, so the database can be rebuilt from scratch.
- `docs/DEPLOY.md`: how the app is deployed, tested and rolled back.
- `docs/CHANGELOG.md`: every change made to the app, newest first.
- `docs/Lissafi-new-tools-runbook.pdf`: customer/admin runbook for the newer tools.
- **Not here: the application code.** It is a single bundled Cloudflare Worker file (about 1.1 MB)
  that lives in Cloudflare (Worker `nairatrack`), with a rolling copy and numbered rollback copies in
  the Cloudflare KV namespace `77913ed9bc92460ba4b1833c185efb8f`. To put the code here, open the Worker in the
  Cloudflare dashboard (Workers, nairatrack, Edit code), copy it, and add it as `worker.js`.

## Secrets

The admin PIN is written inside the code. It is never stored in this repo and must not be added.
Never commit API keys, tokens or passwords.
