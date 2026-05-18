# 123230159_latres_D

Proyek ini adalah aplikasi Toko Online "Toko Wakaka People" yang dibuat untuk memenuhi tugas Latihan Responsi Mata Kuliah Praktikum Pemrograman Aplikasi Mobile (IF-D). Aplikasi ini mengintegrasikan API eksternal untuk menampilkan produk, menggunakan Shared Preferences untuk manajemen sesi login, dan Hive untuk penyimpanan keranjang belanja (database lokal) berdasarkan user yang sedang aktif.

## Anggota / Identitas
* **Nama:** dhila (sesuai yg login)
* **NIM:** 123230159
* **Kelas:** Plug IF-D

---

## Struktur Folder Proyek

Penjelasan mengenai arsitektur dan pembagian folder di dalam direktori `lib/` pada proyek Flutter ini adalah sebagai berikut:

```text
lib/
├── models/
│   ├── cart_item.dart       # Model data untuk item di keranjang belanja (Hive Object)
│   ├── cart_item.g.dart     # File generator TypeAdapter untuk Hive (Auto-generated)
│   └── product.dart         # Model data untuk konversi JSON dari API DummyJSON
├── pages/
│   ├── cart_page.dart       # Tampilan halaman keranjang belanja (Filter spesifik per User)
│   ├── detail_page.dart     # Tampilan halaman detail produk dengan fitur kuantitas (Qty)
│   ├── home_page.dart       # Halaman utama dengan Bottom Navigation Bar (Home & Profile)
│   ├── login_page.dart      # Tampilan autentikasi awal (Validasi Password wajib NIM)
│   └── profile_page.dart    # Tampilan informasi pengguna aktif dan fitur logout
├── services/
│   ├── api_service.dart     # Service HTTP Request untuk mengambil data dari dummyjson.com
│   └── storage_service.dart # Service lokal untuk enkapsulasi logika SharedPreferences & Hive
├── main.dart                # Entry point aplikasi, inisialisasi Hive, dan pengecekan Sesi (Auto-Login)
└── shared.dart              # Penyusunan konfigurasi visual global (AppTheme & Card Decoration)