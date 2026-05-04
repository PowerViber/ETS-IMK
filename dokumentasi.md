# Dokumentasi Perubahan UI dan Navigasi

Tanggal: 04 Mei 2026  
Proyek: ETS-IMK

## 1. Ringkasan
Dokumen ini merangkum perubahan yang telah dilakukan pada sisi antarmuka dan navigasi aplikasi, mencakup:
- Penambahan halaman Home sebagai halaman awal aplikasi.
- Pembaruan halaman Target sesuai desain referensi.
- Normalisasi gaya UI pada halaman Home, Dashboard, Latihan, dan Al-Quran.
- Penyesuaian akses Dashboard melalui ikon profile.
- Perbaikan test widget agar sesuai struktur app terbaru.

## 2. Tujuan Perubahan
1. Meningkatkan konsistensi desain antar halaman.
2. Memperjelas alur navigasi utama aplikasi.
3. Mengubah halaman placeholder menjadi halaman fungsional.
4. Menyiapkan basis UI yang siap untuk iterasi fitur berikutnya.

## 3. Ruang Lingkup
Perubahan difokuskan pada:
- Routing dan struktur navigasi global.
- Halaman utama fitur pengguna.
- Komponen UI prioritas (top bar, section title, kartu, tombol aksi).
- Validasi statis melalui Dart analyzer.

## 4. Daftar Berkas yang Diubah
1. lib/core/router/app_router.dart
2. lib/shared/widgets/main_scaffold.dart
3. lib/features/home/home.dart
4. lib/features/dashboard/dashboard.dart
5. lib/features/target/target.dart
6. lib/features/latihan/latihan.dart
7. lib/features/alquran/alquran.dart
8. test/widget_test.dart

## 5. Rincian Perubahan per Modul

### 5.1 Routing Aplikasi
Berkas: lib/core/router/app_router.dart

Perubahan:
- Menambahkan route halaman Home di path /home.
- Menambahkan route halaman Dashboard di path /dashboard.
- Mengubah initialLocation menjadi /home.
- Mempertahankan StatefulShellRoute untuk modul:
  - /alquran
  - /latihan
  - /target

Dampak:
- Aplikasi masuk ke Home saat pertama dibuka.
- Dashboard dapat diakses sebagai route mandiri.

---

### 5.2 Navigasi Global (Shell)
Berkas: lib/shared/widgets/main_scaffold.dart

Perubahan:
- Menyeragamkan top bar lintas halaman shell:
  - Warna latar mint.
  - Ukuran dan bobot teks tab yang konsisten.
- Menambahkan akses Home:
  - Klik logo IQRA' -> /home
  - Ikon home -> /home
- Mengubah fungsi ikon profile:
  - Ikon profile -> /dashboard
- Menjaga tab utama shell tetap fokus pada:
  - Home
  - Al-Quran
  - Latihan
  - Target

Dampak:
- Navigasi antar halaman menjadi lebih intuitif.
- Akses Dashboard tersedia dari ikon profile seperti requirement terbaru.

---

### 5.3 Halaman Home
Berkas: lib/features/home/home.dart

Perubahan:
- Membangun halaman Home dengan struktur:
  - Top bar
  - Greeting
  - Search bar
  - Kartu streak
  - Section Target Hari Ini
  - Section Progress
- Menyesuaikan style agar seragam:
  - Radius kartu
  - Shadow
  - Spacing vertikal
  - Hierarki tipografi
- Navigasi cepat:
  - Tombol Mulai Target Baru -> /target
  - Ikon profile -> /dashboard

Dampak:
- Home tampil sebagai landing page fungsional, bukan placeholder.

---

### 5.4 Halaman Dashboard
Berkas: lib/features/dashboard/dashboard.dart

Perubahan:
- Menyusun ulang layout Dashboard agar sesuai desain acuan:
  - App bar (back, title, search)
  - Greeting area
  - Banner streak
  - Weekly streak cards
  - Target Hari Ini
  - Progress
- Integrasi data target harian dari targetProvider.
- Tombol back diarahkan ke /home.

Dampak:
- Dashboard kembali dapat dibuka dan menampilkan struktur informasi utama dengan benar.

---

### 5.5 Halaman Target
Berkas: lib/features/target/target.dart

Perubahan:
- Redesign halaman sesuai referensi:
  - Tombol besar MULAI TARGET BARU
  - Section Target Hari Ini
  - Section Target Mendatang
  - Section Diarsipkan
- Menambahkan modal input target:
  - Judul target
  - Deskripsi target
  - Tanggal target
- Menambahkan aksi per target:
  - Edit
  - Tandai selesai
  - Hapus
- Menambahkan state kosong per section (Tidak Ada).

Dampak:
- Manajemen target menjadi operasional untuk skenario harian.

Catatan:
- Alur edit saat ini membuka sheet dengan nilai terisi, namun penyimpanan tetap menggunakan mekanisme tambah item baru sesuai implementasi provider saat ini.

---

### 5.6 Halaman Latihan
Berkas: lib/features/latihan/latihan.dart

Perubahan:
- Mengganti halaman placeholder dengan tampilan konten:
  - Card Tebak Surah
  - Card Sambung Ayat
  - Section Riwayat Latihan
- Menyesuaikan style visual agar konsisten dengan modul lain.

Dampak:
- Modul Latihan kini memiliki tampilan siap lanjut ke integrasi fitur.

---

### 5.7 Halaman Al-Quran
Berkas: lib/features/alquran/alquran.dart

Perubahan:
- Mengganti placeholder menjadi daftar Juz dan Surah.
- Menampilkan data per kartu:
  - Juz
  - Nomor surah
  - Nama surah
  - Jumlah ayat
  - Kategori Makkah/Madinah
- Penyesuaian ukuran font dan spacing agar sejalan dengan bahasa desain global.

Dampak:
- Modul Al-Quran tampil informatif dan selaras dengan halaman lain.

---

### 5.8 Widget Test
Berkas: test/widget_test.dart

Perubahan:
- Mengganti referensi app dari MyApp ke ModernHabitApp.
- Menyesuaikan skenario test dasar agar sesuai struktur saat ini.

Dampak:
- Test tidak lagi gagal karena class app yang tidak ditemukan.

## 6. Konsistensi UI yang Diterapkan
Standar visual yang dipakai lintas halaman:
- Latar belakang utama bernuansa abu-hijau muda.
- Kartu menggunakan radius medium dan shadow lembut.
- Tombol aksi utama menggunakan warna mint/green.
- Heading section menggunakan warna hijau gelap.
- Ikon navigasi kanan:
  - Home icon -> Home
  - Profile icon -> Dashboard

## 7. Validasi dan Kualitas
Validasi yang dilakukan selama perubahan:
- Format kode Dart pada berkas yang diubah.
- Pengecekan error melalui analyzer pada modul terkait.
- Pengecekan ulang akses route utama:
  - /home
  - /dashboard
  - /alquran
  - /latihan
  - /target

## 8. Potensi Peningkatan Lanjutan
1. Menambahkan metode updateTarget pada targetProvider agar flow edit tidak membuat item baru.
2. Menyambungkan data progress Home dan Dashboard ke state real-time.
3. Menambahkan indikator tab aktif yang lebih jelas pada top bar.
4. Menambahkan integration test untuk alur navigasi dan target management.

## 9. Catatan Rilis Internal
Perubahan ini termasuk kategori:
- UI Refactor
- Navigation Update
- Feature Surface Expansion
- Test Compatibility Fix

Dokumen ini siap dijadikan lampiran commit atau release note internal.
