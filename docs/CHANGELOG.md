# Changelog

## 2026-11-16

- **Separate test database.** `lissafi-test` now runs on `lissafi-test-db` (schema plus the 20 demo shops, no real shops).
- **Offline Quick sale (live).** Quick sale can be opened without signal. Sales taken offline are kept on the phone
  and sent when the signal returns (any app page triggers the send, plus a "Send now" button). Each sale carries a
  one-time id (`invoices.idem`) so a repeat send cannot double-record. The sale keeps its own date (up to 14 days back)
  and the note "Recorded offline". Failed sales go to a red list on Quick sale. Not available for restaurant shops.
  Service worker keeps the `/app/pos` page in the `nt-pos` cache and clears it on `/logout`.
  Database: `ALTER TABLE invoices ADD COLUMN idem TEXT DEFAULT ''`.
- **Admin assistant and commands (live).** The admin Assistant tab and the Setup box both run commands
  (turn features on or off, extend, rename, mark) with a confirm card. Part of a shop name is enough; if two shops
  match, it lists them and asks which one. Polite openings ("please", "can you") are accepted.
- **Client assistant (live).** Opens pages (including Hausa page names and verbs) and records an expense with a
  yes/no confirmation, in English and Hausa. Pending confirmation is kept in KV `aipend:<businessId>:<userId>` for 5 minutes.
- Checked: the daily owner summary exists as push notifications (8am and 7pm Lagos) and a shareable Daily summary page.
  Automatic WhatsApp sending does not exist (needs the WhatsApp Business API).

## Earlier

- Branches add-on (optional, paid), per-trade tools and the new tools batch. See the rollback keys `-branches` and `-pretools`.

## To do / ideas

- Debt statement link for customers ("you owe X, pay to this account").
- Show the branches add-on and its price on the page owners see.
- Hausa voice notes for the assistant (8 separate recordings still needed).
- Put the application source (`worker.js`) in this repo.
