# MHRJR STORE

Struktur GitHub Pages untuk MHRJR STORE.

## Struktur

- `index.html` — halaman utama
- `koleksi.html` — katalog produk
- `login.html` — login Supabase
- `daftar.html` — pendaftaran akun Supabase
- `admin.html` — dashboard admin
- `css/style.css` — gaya website
- `js/` — tempat JavaScript tambahan
- `images/` — semua foto produk
- `SUPABASE_SETUP.sql` — SQL database/RLS

## Upload ke GitHub

1. Buat repository baru, misalnya `mhrjr-store`.
2. Upload semua isi folder ini ke repository.
3. Buka **Settings → Pages**.
4. Pada Source pilih **Deploy from a branch**.
5. Pilih branch `main` dan folder `/ (root)`.
6. Simpan.
7. Setelah aktif, alamatnya biasanya:
   `https://USERNAME.github.io/mhrjr-store/`

## Supabase

Setelah alamat GitHub Pages aktif, masukkan alamat tersebut ke:
**Supabase → Authentication → URL Configuration → Site URL**

Tambahkan juga URL tersebut ke **Redirect URLs** bila diperlukan.

Jangan upload `service_role` atau Secret key ke GitHub.
