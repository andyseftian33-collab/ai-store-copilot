# THREADS 1K — Dashboard V2

Dashboard eksperimen 30 hari yang terhubung ke Threads API resmi.

## Fitur V2
- Login/passcode dashboard
- OAuth Threads
- Permission minimum: `threads_basic`, `threads_manage_insights`
- Token Threads dienkripsi AES-GCM sebelum disimpan ke D1
- Auto-sync account insights (rolling 24 jam untuk activity metrics)
- Auto-sync 30 post terbaru + post insights
- Snapshot history (followers total + activity rolling 24 jam)
- Progress ke target 1.000 followers
- Pace aktual, pace yang dibutuhkan, projection
- Experiment journal
- Cron sync tiap 6 jam

## Yang dibutuhkan
- Akun Cloudflare
- Node.js 20+
- Meta Developer App dengan use case Threads
- Akun Threads yang akan dijadikan tester saat fase eksperimen

## 1. Install
```bash
npm install
npx wrangler login
```

## 2. D1 Database
Setelah Worker dibuat, jalankan migration ke database yang terprovision:
```bash
npm run db:migrate:remote
```

## 3. Isi Threads App ID
Set `THREADS_APP_ID` pada konfigurasi Cloudflare.

## 4. Buat tiga secret
```bash
npx wrangler secret put THREADS_APP_SECRET
npx wrangler secret put DASHBOARD_SECRET
node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"
npx wrangler secret put TOKEN_ENCRYPTION_KEY
```

## 5. Deploy
```bash
npm run deploy
```

## 6. Konfigurasi Meta Threads
Tambahkan use case/product Threads, akun tester, dan OAuth Redirect URI:
`https://<worker-url>/auth/threads/callback`

Permission:
- `threads_basic`
- `threads_manage_insights`

## Keamanan
- App Secret tidak pernah dikirim ke browser.
- Access token Threads dienkripsi AES-GCM sebelum masuk D1.
- Secret disimpan sebagai Cloudflare Worker Secrets.

## Catatan
- `followers_count` adalah total followers saat snapshot.
- Dashboard tidak mengklaim follower attribution per post.
- Untuk versi publik/multi-user nanti diperlukan App Review, privacy policy, data deletion flow, user isolation, dan rate-limit handling.
