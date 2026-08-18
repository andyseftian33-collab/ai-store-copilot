CREATE TABLE IF NOT EXISTS accounts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  threads_user_id TEXT NOT NULL UNIQUE,
  username TEXT,
  token_ciphertext TEXT NOT NULL,
  token_iv TEXT NOT NULL,
  token_expires_at INTEGER,
  connected_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS oauth_states (
  state TEXT PRIMARY KEY,
  expires_at INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS snapshots (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  threads_user_id TEXT NOT NULL,
  captured_at TEXT NOT NULL,
  followers_count INTEGER DEFAULT 0,
  views INTEGER DEFAULT 0,
  likes INTEGER DEFAULT 0,
  replies INTEGER DEFAULT 0,
  reposts INTEGER DEFAULT 0,
  quotes INTEGER DEFAULT 0
);

CREATE INDEX IF NOT EXISTS idx_snapshots_user_time
ON snapshots(threads_user_id, captured_at DESC);

CREATE TABLE IF NOT EXISTS posts (
  thread_id TEXT PRIMARY KEY,
  threads_user_id TEXT NOT NULL,
  username TEXT,
  text TEXT,
  permalink TEXT,
  media_type TEXT,
  published_at TEXT,
  views INTEGER DEFAULT 0,
  likes INTEGER DEFAULT 0,
  replies INTEGER DEFAULT 0,
  reposts INTEGER DEFAULT 0,
  quotes INTEGER DEFAULT 0,
  shares INTEGER DEFAULT 0,
  synced_at TEXT NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_posts_user_time
ON posts(threads_user_id, published_at DESC);

CREATE TABLE IF NOT EXISTS experiment_config (
  id INTEGER PRIMARY KEY CHECK (id = 1),
  start_date TEXT,
  baseline_followers INTEGER DEFAULT 0,
  target_followers INTEGER DEFAULT 1000,
  duration_days INTEGER DEFAULT 30,
  updated_at TEXT NOT NULL
);

INSERT OR IGNORE INTO experiment_config
(id, start_date, baseline_followers, target_followers, duration_days, updated_at)
VALUES (1, date('now'), 0, 1000, 30, datetime('now'));

CREATE TABLE IF NOT EXISTS post_notes (
  thread_id TEXT PRIMARY KEY,
  hook_type TEXT,
  objective TEXT,
  content_format TEXT,
  hypothesis TEXT,
  notes TEXT,
  updated_at TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS journal (
  journal_date TEXT PRIMARY KEY,
  hypothesis TEXT,
  worked TEXT,
  failed TEXT,
  next_test TEXT,
  updated_at TEXT NOT NULL
);
