-- Lissafi database layout (Cloudflare D1, SQLite). Rebuild from scratch with:
--   wrangler d1 execute <db> --file=db/schema.sql
-- Last exported: 2026-11-16. Apply every future change to BOTH databases
-- (live: nairatrack's DB, test: lissafi-test-db) and add it here.

CREATE TABLE ai_msgs (id TEXT PRIMARY KEY, business_id TEXT NOT NULL, user_id TEXT NOT NULL, role TEXT NOT NULL, content TEXT NOT NULL, day TEXT NOT NULL, created_at TEXT NOT NULL);
CREATE TABLE assets (id TEXT PRIMARY KEY, business_id TEXT, name TEXT, kind TEXT DEFAULT '', last_service TEXT DEFAULT '', next_service TEXT DEFAULT '', every_days INTEGER DEFAULT 90, cost REAL DEFAULT 0, status TEXT DEFAULT 'ok', note TEXT DEFAULT '', created_at TEXT);
CREATE TABLE attendance (id TEXT PRIMARY KEY, business_id TEXT, pupil_id TEXT, name TEXT, klass TEXT DEFAULT '', at TEXT, status TEXT DEFAULT 'present', note TEXT DEFAULT '', created_at TEXT);
CREATE TABLE bank_alerts (id TEXT PRIMARY KEY, business_id TEXT NOT NULL, received_at TEXT NOT NULL, sender TEXT DEFAULT '', bank TEXT DEFAULT '', subject TEXT DEFAULT '', body TEXT DEFAULT '', kind TEXT DEFAULT 'other', amount REAL DEFAULT 0, method TEXT DEFAULT '', narration TEXT DEFAULT '', status TEXT DEFAULT '', payment_id TEXT, expense_id TEXT, invoice_id TEXT, dedupe TEXT NOT NULL);
CREATE TABLE batches (id TEXT PRIMARY KEY, business_id TEXT NOT NULL, made_on TEXT NOT NULL, inputs TEXT DEFAULT '', output_name TEXT DEFAULT '', output_qty REAL DEFAULT 0, cost REAL DEFAULT 0, note TEXT DEFAULT '', created_at TEXT NOT NULL);
CREATE TABLE billing (ref TEXT PRIMARY KEY, business_id TEXT NOT NULL, kind TEXT NOT NULL, months INTEGER DEFAULT 0, amount REAL NOT NULL, test INTEGER DEFAULT 0, applied INTEGER DEFAULT 0, paid_at TEXT NOT NULL);
CREATE TABLE bookings (id TEXT PRIMARY KEY, business_id TEXT NOT NULL, customer_id TEXT, customer_name TEXT DEFAULT '', customer_phone TEXT DEFAULT '', title TEXT NOT NULL, resource TEXT DEFAULT '', date TEXT NOT NULL, end_date TEXT DEFAULT '', start_time TEXT DEFAULT '', end_time TEXT DEFAULT '', guests INTEGER DEFAULT 0, price REAL DEFAULT 0, status TEXT DEFAULT 'booked', note TEXT DEFAULT '', invoice_id TEXT, created_by TEXT DEFAULT '', created_at TEXT NOT NULL);
CREATE TABLE branch_moves (id TEXT PRIMARY KEY, business_id TEXT NOT NULL, item_id TEXT NOT NULL, from_id TEXT DEFAULT '', to_id TEXT DEFAULT '', qty REAL DEFAULT 0, date TEXT DEFAULT '', note TEXT DEFAULT '', user_name TEXT DEFAULT '', created_at TEXT DEFAULT '');
CREATE TABLE branch_stock (id TEXT PRIMARY KEY, business_id TEXT NOT NULL, branch_id TEXT NOT NULL, item_id TEXT NOT NULL, qty REAL DEFAULT 0, updated_at TEXT DEFAULT '');
CREATE TABLE branches (id TEXT PRIMARY KEY, business_id TEXT NOT NULL, name TEXT NOT NULL, address TEXT DEFAULT '', phone TEXT DEFAULT '', is_main INTEGER DEFAULT 0, active INTEGER DEFAULT 1, created_at TEXT NOT NULL);
CREATE TABLE businesses (
  id TEXT PRIMARY KEY, name TEXT NOT NULL, phone TEXT DEFAULT '', email TEXT DEFAULT '', address TEXT DEFAULT '',
  vat_rate REAL DEFAULT 0, approval_limit REAL DEFAULT 500000, inv_seq INTEGER DEFAULT 0,
  plan TEXT DEFAULT 'Starter', monthly_fee REAL DEFAULT 15000, setup_fee REAL DEFAULT 75000, setup_paid INTEGER DEFAULT 0,
  paid_until TEXT DEFAULT '', status TEXT DEFAULT 'active', feed_token TEXT NOT NULL, is_demo INTEGER DEFAULT 0,
  bank_details TEXT DEFAULT '', created_at TEXT NOT NULL
, alert_token TEXT DEFAULT '', msg_lang TEXT DEFAULT 'en', ref_code TEXT, referred_by TEXT, ref_reward_paid INTEGER DEFAULT 0, trusted_senders TEXT DEFAULT '', setup_dismissed INTEGER DEFAULT 0, pricelist_token TEXT, pricelist_stock INTEGER DEFAULT 0, restaurant INTEGER DEFAULT 0, biz_type TEXT, features TEXT, renew_until TEXT, monthly_costs REAL DEFAULT 0, dva_status TEXT DEFAULT '', dva_no TEXT DEFAULT '', dva_bank TEXT DEFAULT '', dva_name TEXT DEFAULT '', dva_id TEXT DEFAULT '', ps_customer TEXT DEFAULT '', ps_subaccount TEXT DEFAULT '', ps_split TEXT DEFAULT '', settle_code TEXT DEFAULT '', settle_no TEXT DEFAULT '', settle_bank TEXT DEFAULT '', settle_name TEXT DEFAULT '', old_bank_details TEXT DEFAULT '', logo_url TEXT DEFAULT '', brand_color TEXT DEFAULT '', display_msg TEXT DEFAULT '', brand_style TEXT DEFAULT '', exp_types TEXT DEFAULT '', staff_see TEXT DEFAULT '', tier_labels TEXT DEFAULT '', commission_pct REAL DEFAULT 0);
CREATE TABLE cash_closes (id TEXT PRIMARY KEY, business_id TEXT NOT NULL, date TEXT NOT NULL, opening REAL DEFAULT 0, cash_in REAL DEFAULT 0, cash_out REAL DEFAULT 0, expected REAL DEFAULT 0, counted REAL DEFAULT 0, diff REAL DEFAULT 0, kept REAL DEFAULT 0, note TEXT DEFAULT '', user_id TEXT, user_name TEXT DEFAULT '', created_at TEXT NOT NULL, branch_id TEXT DEFAULT '');
CREATE TABLE contracts (id TEXT PRIMARY KEY, business_id TEXT, person TEXT, phone TEXT DEFAULT '', what TEXT DEFAULT '', amount REAL DEFAULT 0, every TEXT DEFAULT 'month', next_due TEXT DEFAULT '', status TEXT DEFAULT 'live', note TEXT DEFAULT '', created_at TEXT);
CREATE TABLE customers (
  id TEXT PRIMARY KEY, business_id TEXT NOT NULL, name TEXT NOT NULL, phone TEXT DEFAULT '', email TEXT DEFAULT '', address TEXT DEFAULT '', note TEXT DEFAULT '', created_at TEXT NOT NULL
, credit_limit REAL DEFAULT 0);
CREATE TABLE deliveries (id TEXT PRIMARY KEY, business_id TEXT, person TEXT, phone TEXT DEFAULT '', address TEXT DEFAULT '', what TEXT DEFAULT '', fee REAL DEFAULT 0, rider TEXT DEFAULT '', status TEXT DEFAULT 'waiting', due_at TEXT DEFAULT '', note TEXT DEFAULT '', created_at TEXT);
CREATE TABLE empties (id TEXT PRIMARY KEY, business_id TEXT NOT NULL, person TEXT NOT NULL, phone TEXT DEFAULT '', kind TEXT DEFAULT '', qty_out REAL DEFAULT 0, qty_back REAL DEFAULT 0, deposit REAL DEFAULT 0, status TEXT DEFAULT 'open', out_at TEXT NOT NULL, created_at TEXT NOT NULL);
CREATE TABLE expenses (
  id TEXT PRIMARY KEY, business_id TEXT NOT NULL, date TEXT NOT NULL, payee TEXT DEFAULT '', category TEXT DEFAULT 'Other', amount REAL NOT NULL, method TEXT DEFAULT 'Transfer', note TEXT DEFAULT '', flags TEXT DEFAULT '', created_at TEXT NOT NULL
, source TEXT DEFAULT '', truck_id TEXT, created_by TEXT DEFAULT '', branch_id TEXT DEFAULT '', trip_id TEXT DEFAULT '');
CREATE TABLE fraud_cases (id TEXT PRIMARY KEY, business_id TEXT NOT NULL, kind TEXT DEFAULT 'other', amount REAL DEFAULT 0, happened_at TEXT NOT NULL, bank TEXT DEFAULT '', account_name TEXT DEFAULT '', account_no TEXT DEFAULT '', session_id TEXT DEFAULT '', description TEXT DEFAULT '', steps TEXT DEFAULT '{}', notes TEXT DEFAULT '', status TEXT DEFAULT 'open', created_by TEXT DEFAULT '', created_at TEXT NOT NULL);
CREATE TABLE fuel (id TEXT PRIMARY KEY, business_id TEXT, what TEXT, litres REAL DEFAULT 0, cost REAL DEFAULT 0, at TEXT DEFAULT '', odo REAL DEFAULT 0, note TEXT DEFAULT '', created_at TEXT, exp_id TEXT DEFAULT '');
CREATE TABLE goods_out (id TEXT PRIMARY KEY, business_id TEXT NOT NULL, person TEXT NOT NULL, phone TEXT DEFAULT '', out_at TEXT NOT NULL, due_at TEXT DEFAULT '', status TEXT DEFAULT 'open', note TEXT DEFAULT '', created_at TEXT NOT NULL);
CREATE TABLE goods_out_lines (id TEXT PRIMARY KEY, out_id TEXT NOT NULL, business_id TEXT NOT NULL, item_id TEXT DEFAULT '', name TEXT NOT NULL, qty_out REAL DEFAULT 0, qty_back REAL DEFAULT 0, price REAL DEFAULT 0);
CREATE TABLE invoice_lines (id TEXT PRIMARY KEY, invoice_id TEXT NOT NULL, item_id TEXT, name TEXT NOT NULL, qty REAL NOT NULL, price REAL NOT NULL, cost REAL DEFAULT 0, amount REAL NOT NULL);
CREATE TABLE invoices (
  id TEXT PRIMARY KEY, business_id TEXT NOT NULL, no TEXT NOT NULL, customer_id TEXT, customer_name TEXT DEFAULT '', customer_phone TEXT DEFAULT '',
  date TEXT NOT NULL, due TEXT DEFAULT '', subtotal REAL DEFAULT 0, discount REAL DEFAULT 0, vat REAL DEFAULT 0, total REAL DEFAULT 0, paid REAL DEFAULT 0,
  note TEXT DEFAULT '', share_token TEXT NOT NULL, last_reminder TEXT DEFAULT '', reminders INTEGER DEFAULT 0, created_at TEXT NOT NULL
, created_by TEXT DEFAULT '', branch_id TEXT DEFAULT '', staff_id TEXT DEFAULT '', idem TEXT DEFAULT '');
CREATE TABLE items (
  id TEXT PRIMARY KEY, business_id TEXT NOT NULL, name TEXT NOT NULL, sku TEXT DEFAULT '', unit TEXT DEFAULT 'pcs',
  cost REAL DEFAULT 0, price REAL DEFAULT 0, qty REAL DEFAULT 0, low_at REAL DEFAULT 0, active INTEGER DEFAULT 1, created_at TEXT NOT NULL
, kind TEXT DEFAULT 'product', category TEXT DEFAULT '', attrs TEXT DEFAULT '', expires_at TEXT DEFAULT '', price2 REAL DEFAULT 0, price3 REAL DEFAULT 0, expires TEXT DEFAULT '', batch_no TEXT DEFAULT '', supplier TEXT DEFAULT '', last_cost REAL DEFAULT 0, cost_at TEXT DEFAULT '');
CREATE TABLE jobs (id TEXT PRIMARY KEY, business_id TEXT NOT NULL, tag TEXT DEFAULT '', customer_name TEXT NOT NULL, phone TEXT DEFAULT '', item TEXT DEFAULT '', fault TEXT DEFAULT '', status TEXT DEFAULT 'received', price REAL DEFAULT 0, paid REAL DEFAULT 0, due TEXT DEFAULT '', note TEXT DEFAULT '', created_at TEXT NOT NULL, updated_at TEXT NOT NULL);
CREATE TABLE login_attempts (ip TEXT NOT NULL, ts INTEGER NOT NULL);
CREATE TABLE measures (id TEXT PRIMARY KEY, business_id TEXT NOT NULL, customer_id TEXT DEFAULT '', name TEXT NOT NULL, phone TEXT DEFAULT '', data TEXT DEFAULT '', note TEXT DEFAULT '', due TEXT DEFAULT '', created_at TEXT NOT NULL, updated_at TEXT NOT NULL);
CREATE TABLE memberships (user_id TEXT NOT NULL, business_id TEXT NOT NULL, role TEXT DEFAULT 'owner', created_at TEXT NOT NULL, PRIMARY KEY (user_id, business_id));
CREATE TABLE notif_seen (user_id TEXT NOT NULL, business_id TEXT NOT NULL, at TEXT NOT NULL, PRIMARY KEY (user_id, business_id));
CREATE TABLE notifications (id TEXT PRIMARY KEY, business_id TEXT NOT NULL, kind TEXT, title TEXT, body TEXT DEFAULT '', who TEXT DEFAULT '', link TEXT DEFAULT '', amount REAL DEFAULT 0, actor TEXT DEFAULT '', audience TEXT DEFAULT 'all', created_at TEXT NOT NULL);
CREATE TABLE orders (id TEXT PRIMARY KEY, business_id TEXT NOT NULL, label TEXT DEFAULT '', status TEXT DEFAULT 'open', kitchen TEXT DEFAULT 'new', lines TEXT DEFAULT '[]', total REAL DEFAULT 0, note TEXT DEFAULT '', created_by TEXT DEFAULT '', invoice_id TEXT, created_at TEXT NOT NULL, updated_at TEXT NOT NULL);
CREATE TABLE papers (id TEXT PRIMARY KEY, business_id TEXT, vehicle TEXT, kind TEXT DEFAULT '', ref TEXT DEFAULT '', expires TEXT DEFAULT '', cost REAL DEFAULT 0, note TEXT DEFAULT '', created_at TEXT);
CREATE TABLE payments (
  id TEXT PRIMARY KEY, business_id TEXT NOT NULL, invoice_id TEXT, customer_id TEXT, date TEXT NOT NULL, amount REAL NOT NULL, method TEXT DEFAULT 'Transfer', note TEXT DEFAULT '', created_at TEXT NOT NULL
, source TEXT DEFAULT '', created_by TEXT DEFAULT '', branch_id TEXT DEFAULT '');
CREATE TABLE plans (id TEXT PRIMARY KEY, business_id TEXT, person TEXT, phone TEXT, what TEXT DEFAULT '', total REAL DEFAULT 0, paid REAL DEFAULT 0, due TEXT DEFAULT '', status TEXT DEFAULT 'open', log TEXT DEFAULT '[]', note TEXT DEFAULT '', created_at TEXT);
CREATE TABLE pupils (id TEXT PRIMARY KEY, business_id TEXT NOT NULL, name TEXT NOT NULL, klass TEXT DEFAULT '', guardian TEXT DEFAULT '', phone TEXT DEFAULT '', fee REAL DEFAULT 0, paid REAL DEFAULT 0, term TEXT DEFAULT '', active INTEGER DEFAULT 1, created_at TEXT NOT NULL, updated_at TEXT NOT NULL);
CREATE TABLE push_subs (id TEXT PRIMARY KEY, business_id TEXT NOT NULL, user_id TEXT NOT NULL, role TEXT DEFAULT 'owner', endpoint TEXT NOT NULL, p256dh TEXT DEFAULT '', auth TEXT DEFAULT '', created_at TEXT NOT NULL);
CREATE TABLE quotes (id TEXT PRIMARY KEY, business_id TEXT, person TEXT, phone TEXT, title TEXT DEFAULT '', lines TEXT DEFAULT '[]', total REAL DEFAULT 0, valid_until TEXT DEFAULT '', status TEXT DEFAULT 'open', note TEXT DEFAULT '', created_at TEXT);
CREATE TABLE recipes (id TEXT PRIMARY KEY, business_id TEXT NOT NULL, item_id TEXT NOT NULL, ingredient_id TEXT NOT NULL, qty REAL NOT NULL DEFAULT 1);
CREATE TABLE regulars (id TEXT PRIMARY KEY, business_id TEXT, person TEXT, phone TEXT DEFAULT '', visits INTEGER DEFAULT 0, spend REAL DEFAULT 0, reward_every INTEGER DEFAULT 10, rewarded INTEGER DEFAULT 0, last_at TEXT DEFAULT '', note TEXT DEFAULT '', created_at TEXT);
CREATE TABLE repacks (id TEXT PRIMARY KEY, business_id TEXT, from_id TEXT, from_name TEXT, to_id TEXT, to_name TEXT, from_qty REAL DEFAULT 0, to_qty REAL DEFAULT 0, at TEXT DEFAULT '', created_at TEXT);
CREATE TABLE rooms (id TEXT PRIMARY KEY, business_id TEXT NOT NULL, name TEXT NOT NULL, kind TEXT DEFAULT '', rate REAL DEFAULT 0, status TEXT DEFAULT 'free', guest TEXT DEFAULT '', phone TEXT DEFAULT '', since TEXT DEFAULT '', until TEXT DEFAULT '', active INTEGER DEFAULT 1, created_at TEXT NOT NULL);
CREATE TABLE sale_edits (id TEXT PRIMARY KEY, business_id TEXT NOT NULL, invoice_id TEXT, user_name TEXT DEFAULT '', role TEXT DEFAULT '', at TEXT NOT NULL, summary TEXT DEFAULT '');
CREATE TABLE sessions (token_hash TEXT PRIMARY KEY, user_id TEXT NOT NULL, expires INTEGER NOT NULL, support INTEGER DEFAULT 0);
CREATE TABLE signups (id TEXT PRIMARY KEY, name TEXT NOT NULL, owner TEXT DEFAULT '', phone TEXT DEFAULT '', email TEXT NOT NULL, ref_code TEXT DEFAULT '', amount REAL NOT NULL, status TEXT DEFAULT 'started', business_id TEXT, token TEXT, created_at TEXT NOT NULL, biz_type TEXT);
CREATE TABLE staffbook (id TEXT PRIMARY KEY, business_id TEXT, name TEXT, role TEXT DEFAULT '', phone TEXT DEFAULT '', pay REAL DEFAULT 0, cycle TEXT DEFAULT 'month', started TEXT DEFAULT '', owing REAL DEFAULT 0, log TEXT DEFAULT '[]', active INTEGER DEFAULT 1, note TEXT DEFAULT '', created_at TEXT);
CREATE TABLE stock_moves (id TEXT PRIMARY KEY, business_id TEXT NOT NULL, item_id TEXT NOT NULL, date TEXT NOT NULL, change REAL NOT NULL, reason TEXT DEFAULT '', created_at TEXT NOT NULL, created_by TEXT DEFAULT '', branch_id TEXT DEFAULT '');
CREATE TABLE stocktakes (id TEXT PRIMARY KEY, business_id TEXT, at TEXT DEFAULT '', counted INTEGER DEFAULT 0, short INTEGER DEFAULT 0, over INTEGER DEFAULT 0, value REAL DEFAULT 0, lines TEXT DEFAULT '[]', note TEXT DEFAULT '', created_at TEXT);
CREATE TABLE suppliers (id TEXT PRIMARY KEY, business_id TEXT, name TEXT, phone TEXT, supplies TEXT DEFAULT '', terms TEXT DEFAULT '', last_at TEXT DEFAULT '', note TEXT DEFAULT '', created_at TEXT);
CREATE TABLE support_msgs (id TEXT PRIMARY KEY, ticket_id TEXT NOT NULL, from_admin INTEGER DEFAULT 0, author TEXT DEFAULT '', body TEXT NOT NULL, created_at TEXT NOT NULL);
CREATE TABLE support_notes (id TEXT PRIMARY KEY, business_id TEXT NOT NULL, body TEXT NOT NULL, created_at TEXT NOT NULL);
CREATE TABLE support_tickets (id TEXT PRIMARY KEY, business_id TEXT NOT NULL, user_id TEXT, user_name TEXT DEFAULT '', topic TEXT DEFAULT '', status TEXT DEFAULT 'open', created_at TEXT NOT NULL, updated_at TEXT NOT NULL);
CREATE TABLE trips (id TEXT PRIMARY KEY, business_id TEXT NOT NULL, truck_id TEXT NOT NULL, kind TEXT DEFAULT 'haulage', customer_id TEXT, customer_name TEXT DEFAULT '', customer_phone TEXT DEFAULT '', origin TEXT DEFAULT '', destination TEXT DEFAULT '', cargo TEXT DEFAULT '', date TEXT NOT NULL, end_date TEXT DEFAULT '', driver TEXT DEFAULT '', amount REAL DEFAULT 0, status TEXT DEFAULT 'planned', note TEXT DEFAULT '', invoice_id TEXT, created_by TEXT DEFAULT '', created_at TEXT NOT NULL);
CREATE TABLE trucks (id TEXT PRIMARY KEY, business_id TEXT NOT NULL, name TEXT NOT NULL, plate TEXT DEFAULT '', model TEXT DEFAULT '', status TEXT DEFAULT 'active', driver_name TEXT DEFAULT '', driver_phone TEXT DEFAULT '', insurance_exp TEXT DEFAULT '', roadworthy_exp TEXT DEFAULT '', licence_exp TEXT DEFAULT '', permit_exp TEXT DEFAULT '', note TEXT DEFAULT '', created_at TEXT NOT NULL);
CREATE TABLE users (
  id TEXT PRIMARY KEY, business_id TEXT NOT NULL, email TEXT NOT NULL UNIQUE, name TEXT DEFAULT '', role TEXT DEFAULT 'owner',
  pass_hash TEXT NOT NULL, pass_salt TEXT NOT NULL, must_change INTEGER DEFAULT 0, created_at TEXT NOT NULL
, invite_hash TEXT, invite_expires INTEGER DEFAULT 0, lang TEXT DEFAULT 'en', gender TEXT DEFAULT 'm', last_seen TEXT, branch_id TEXT DEFAULT '');
CREATE TABLE visits (id TEXT PRIMARY KEY, business_id TEXT, person TEXT, phone TEXT DEFAULT '', what TEXT DEFAULT '', at TEXT DEFAULT '', next_at TEXT DEFAULT '', fee REAL DEFAULT 0, note TEXT DEFAULT '', created_at TEXT);
CREATE TABLE warranties (id TEXT PRIMARY KEY, business_id TEXT, item TEXT, serial TEXT DEFAULT '', person TEXT DEFAULT '', phone TEXT DEFAULT '', sold_on TEXT DEFAULT '', months INTEGER DEFAULT 0, until TEXT DEFAULT '', status TEXT DEFAULT 'live', note TEXT DEFAULT '', created_at TEXT);
CREATE TABLE waste (id TEXT PRIMARY KEY, business_id TEXT, item TEXT, qty REAL DEFAULT 0, unit TEXT DEFAULT '', cost REAL DEFAULT 0, reason TEXT DEFAULT '', at TEXT DEFAULT '', note TEXT DEFAULT '', created_at TEXT);

CREATE INDEX idx_assets_biz ON assets(business_id);
CREATE INDEX idx_attend_biz ON attendance(business_id, at);
CREATE INDEX idx_batches_biz ON batches(business_id, made_on);
CREATE UNIQUE INDEX idx_biz_ref ON businesses(ref_code);
CREATE INDEX idx_bmv ON branch_moves(business_id, date);
CREATE INDEX idx_branches_biz ON branches(business_id, active);
CREATE INDEX idx_bst ON branch_stock(business_id, item_id);
CREATE INDEX idx_bst_br ON branch_stock(business_id, branch_id);
CREATE INDEX idx_contracts_biz ON contracts(business_id);
CREATE INDEX idx_deliv_biz ON deliveries(business_id);
CREATE INDEX idx_empties_biz ON empties(business_id, status);
CREATE INDEX idx_exp_trip ON expenses(business_id, trip_id);
CREATE INDEX idx_fuel_biz ON fuel(business_id);
CREATE INDEX idx_goods_biz ON goods_out(business_id, status, out_at);
CREATE INDEX idx_goods_lines ON goods_out_lines(out_id);
CREATE INDEX idx_inv_branch ON invoices(business_id, branch_id, date);
CREATE INDEX idx_items_expires ON items(business_id, expires_at);
CREATE INDEX idx_jobs_biz ON jobs(business_id, status, updated_at);
CREATE INDEX idx_measures_biz ON measures(business_id, updated_at);
CREATE INDEX idx_papers_biz ON papers(business_id);
CREATE INDEX idx_plans_biz ON plans(business_id);
CREATE INDEX idx_pupils_biz ON pupils(business_id, active, klass);
CREATE INDEX idx_quotes_biz ON quotes(business_id);
CREATE INDEX idx_recipes_biz ON recipes(business_id);
CREATE INDEX idx_reg_biz ON regulars(business_id);
CREATE INDEX idx_repacks_biz ON repacks(business_id);
CREATE INDEX idx_rooms_biz ON rooms(business_id, active);
CREATE INDEX idx_staffbook_biz ON staffbook(business_id);
CREATE INDEX idx_stocktakes_biz ON stocktakes(business_id);
CREATE INDEX idx_suppliers_biz ON suppliers(business_id);
CREATE INDEX idx_visits_biz ON visits(business_id);
CREATE INDEX idx_warr_biz ON warranties(business_id);
CREATE INDEX idx_waste_biz ON waste(business_id);
CREATE INDEX ix_ai_biz ON ai_msgs(business_id, day);
CREATE INDEX ix_alerts_biz ON bank_alerts(business_id, received_at);
CREATE INDEX ix_biz_alert ON businesses(alert_token);
CREATE INDEX ix_biz_pscust ON businesses(ps_customer);
CREATE INDEX ix_book_biz ON bookings(business_id, date);
CREATE INDEX ix_close_biz ON cash_closes(business_id, date);
CREATE INDEX ix_cust_biz ON customers(business_id);
CREATE INDEX ix_edits_biz ON sale_edits(business_id, at);
CREATE INDEX ix_edits_inv ON sale_edits(invoice_id, at);
CREATE INDEX ix_exp_biz ON expenses(business_id, date);
CREATE INDEX ix_exp_truck ON expenses(truck_id, date);
CREATE INDEX ix_inv_biz ON invoices(business_id, date);
CREATE INDEX ix_items_biz ON items(business_id);
CREATE INDEX ix_lines_inv ON invoice_lines(invoice_id);
CREATE INDEX ix_notif_biz ON notifications(business_id, created_at);
CREATE INDEX ix_orders_biz ON orders(business_id, status);
CREATE INDEX ix_pay_biz ON payments(business_id, date);
CREATE INDEX ix_push_biz ON push_subs(business_id);
CREATE INDEX ix_recipe_item ON recipes(business_id, item_id);
CREATE INDEX ix_tk_biz ON support_tickets(business_id, updated_at);
CREATE INDEX ix_tkm ON support_msgs(ticket_id, created_at);
CREATE INDEX ix_trips_biz ON trips(business_id, date);
CREATE INDEX ix_trips_truck ON trips(truck_id, date);
CREATE INDEX ix_users_biz ON users(business_id);
CREATE UNIQUE INDEX ux_alerts_dedupe ON bank_alerts(business_id, dedupe);
