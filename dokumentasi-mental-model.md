# Dokumentasi Evaluasi Mental Model dan Representasi Aplikasi IQRA'

Tanggal evaluasi: 05 Mei 2026  
Proyek: ETS-IMK  
Aplikasi: IQRA' / MyAlQuran  
Sumber materi: Lesson 2.6 - Mental Model and Representation

## 1. Ringkasan

Dokumen ini mengevaluasi apakah aplikasi IQRA' sudah membantu pengguna membentuk mental model yang tepat terhadap cara kerja sistem. Berdasarkan materi Mental Model and Representation, antarmuka yang baik harus membuat pengguna bisa memprediksi hasil aksi, memahami keadaan sistem saat ini, mengenali pola yang familiar, menerapkan pengetahuan dari bagian lain aplikasi, dan melihat perilaku yang konsisten.

Secara umum, aplikasi sudah memiliki fondasi mental model yang cukup baik melalui navigasi utama yang sederhana, warna visual yang konsisten, ikon yang familiar, dan struktur halaman yang mudah dipahami. Namun, beberapa bagian masih perlu diperbaiki karena ada aksi yang terlihat dapat digunakan tetapi belum memberi hasil nyata, feedback setelah aksi belum kuat, dan flow edit target belum benar-benar memperbarui item lama.

## 2. Checklist Prinsip Learnable Interface

| Prinsip | Status | Analisis |
|---|---|---|
| Predictability | [~] Sebagian terpenuhi | Pengguna dapat memprediksi fungsi tombol utama seperti Home, Profile/Dashboard, Al-Quran, Latihan, Target, dan Mulai Target Baru. Namun beberapa elemen seperti search bar, tombol Mulai Latihan, dan tombol Mulai Sesi belum menunjukkan hasil nyata, sehingga prediksi pengguna belum sepenuhnya cocok dengan perilaku sistem. |
| Synthesizability | [ ] Belum terpenuhi | Aplikasi belum menyediakan riwayat aksi atau penanda urutan perubahan yang jelas. Pengguna belum dapat melihat bagaimana kondisi saat ini terbentuk, misalnya target apa yang baru ditambahkan, kapan diselesaikan, atau aksi apa yang baru dilakukan. |
| Familiarity | [x] Terpenuhi | Aplikasi memakai ikon dan konsep yang familiar: ikon home untuk kembali ke halaman utama, ikon profile untuk dashboard, search bar untuk pencarian, tombol plus untuk menambah target, dan ikon delete/edit/check untuk aksi target. |
| Generalizability | [~] Sebagian terpenuhi | Pengetahuan pengguna dari aplikasi lain cukup bisa diterapkan, misalnya plus berarti tambah dan ikon trash berarti hapus. Namun beberapa pola umum belum lengkap, seperti tombol search yang belum menjalankan pencarian dan edit yang belum benar-benar menyimpan perubahan ke item yang sama. |
| Consistency | [~] Sebagian terpenuhi | Warna, kartu, shadow, heading, dan navigasi utama cukup konsisten. Akan tetapi Home memiliki top bar sendiri sementara halaman shell lain memakai MainScaffold, sehingga ada potensi perbedaan perilaku atau active state antar halaman. |

## 3. Checklist Representasi UI

| Aspek Representasi | Status | Analisis |
|---|---|---|
| Representasi kondisi sistem | [~] Sebagian terpenuhi | Halaman Target sudah membagi target menjadi Target Hari Ini, Target Mendatang, dan Diarsipkan. Ini membantu pengguna memahami status target. Namun Home dan Dashboard masih menampilkan beberapa progress default seperti 0% atau Belum ada progress yang belum sepenuhnya terhubung dengan data nyata. |
| Mapping visual ke realitas tugas | [x] Terpenuhi | Struktur Target Hari Ini, Progress, Riwayat Latihan, dan daftar Juz/Surah cocok dengan tugas pengguna dalam aplikasi belajar Al-Quran. Representasi ini membantu pengguna memahami konteks tanpa instruksi panjang. |
| Visual cue | [~] Sebagian terpenuhi | Warna hijau/mint, ikon, card, section title, dan empty state membantu membedakan area informasi. Namun active tab belum sangat jelas, terutama pada Home karena tab Al-Quran/Latihan/Target berada di top bar tetapi Home sendiri bukan branch shell utama. |
| Feedback setelah aksi | [ ] Belum terpenuhi | Setelah pengguna menambah, menghapus, mengedit, atau menandai target selesai, belum ada snackbar, animasi, toast, atau pesan sukses/gagal. Feedback hanya terlihat secara implisit dari perubahan daftar. |
| Kecocokan label dan perilaku | [~] Sebagian terpenuhi | Sebagian besar label cocok dengan aksi. Risiko terbesar ada pada aksi Edit Target: form terbuka dengan data lama, tetapi tombol Simpan Target masih menambah target baru, bukan memperbarui target yang diedit. |

## 4. Checklist Pencegahan User Error

| Area Error | Status | Analisis |
|---|---|---|
| Mistake prevention | [~] Sebagian terpenuhi | Label menu cukup jelas dan familiar, sehingga mengurangi kemungkinan pengguna salah memahami halaman. Namun fitur yang belum aktif dapat menyebabkan knowledge-based mistake karena pengguna mengira search atau latihan sudah berjalan. |
| Slip prevention | [~] Sebagian terpenuhi | Ikon edit, checklist, dan delete dipisah secara vertikal sehingga cukup mudah dipilih. Namun belum ada konfirmasi untuk hapus target, sehingga action-based slip dapat langsung menghilangkan data. |
| Memory lapse prevention | [ ] Belum terpenuhi | Belum ada reminder, riwayat aksi, notifikasi, atau prompt yang membantu pengguna mengingat target atau latihan yang belum selesai. |
| Feedback cycle | [ ] Belum terpenuhi | Hubungan input-output masih kurang kuat pada beberapa aksi. Tombol yang berhasil ditekan belum selalu memberi feedback eksplisit kepada pengguna. |
| Expert blind spot | [~] Sebagian terpenuhi | Antarmuka sudah menggunakan bahasa sederhana seperti Target Hari Ini dan Mulai Target Baru. Namun beberapa istilah atau alur masih mengasumsikan pengguna memahami maksud dashboard, progress, streak, dan sesi tanpa penjelasan kontekstual yang cukup. |

## 5. Konsep Tambahan dari Materi

| Konsep | Status | Analisis |
|---|---|---|
| Metaphor dan analogy | [~] Sebagian terpenuhi | Aplikasi memakai metafora yang umum seperti target, progress, streak, latihan, dan dashboard. Metafora ini membantu pengguna membawa pengetahuan dari aplikasi habit tracker atau learning app lain, tetapi beberapa metafora belum didukung data nyata. |
| Learning curve | [~] Sebagian terpenuhi | Tampilan awal cukup mudah dipelajari karena pilihan utama hanya Al-Quran, Latihan, dan Target. Learning curve dapat lebih cepat jika setiap tombol penting memberi hasil langsung atau memberi penanda bahwa fitur belum tersedia. |
| Rule-based mistake | [~] Sebagian terpenuhi | Risiko muncul ketika pengguna mengikuti aturan umum "edit berarti mengubah data lama", tetapi sistem saat ini justru menambah item baru. Ini perlu diperbaiki agar keputusan pengguna berdasarkan aturan umum tetap menghasilkan outcome yang benar. |
| Learned helplessness | [~] Sebagian terpenuhi | Risiko learned helplessness dapat muncul bila pengguna berkali-kali menekan search, Mulai Latihan, atau Mulai Sesi tetapi tidak mendapat output yang jelas. Solusinya adalah memberi feedback, disabled state, atau halaman placeholder yang menjelaskan status fitur. |

## 6. Analisis per Halaman

### 6.1 Home

Home sudah menjadi pusat orientasi awal yang baik. Greeting, search bar, streak, target hari ini, dan progress membantu pengguna memahami bahwa aplikasi berfokus pada aktivitas belajar dan pencapaian harian.

Hal yang sudah memenuhi mental model:
- Struktur halaman mendukung orientasi cepat.
- Tombol Mulai Target Baru mengarah ke halaman Target sesuai ekspektasi.
- Ikon dan warna selaras dengan desain aplikasi.

Hal yang perlu diperbaiki:
- Search bar masih terlihat aktif tetapi belum berfungsi.
- Progress masih berisi nilai default, sehingga representasi belum akurat terhadap keadaan sistem.
- Streak belum terhubung dengan data aktivitas nyata.

### 6.2 Al-Quran

Halaman Al-Quran sudah menggunakan representasi yang familiar: daftar Juz dan Surah. Informasi nomor surah, nama surah, jumlah ayat, dan kategori Makkah/Madinah membantu pengguna membentuk mental model tentang struktur konten.

Hal yang perlu diperbaiki:
- Belum ada aksi saat pengguna memilih surah.
- Belum ada penanda posisi baca, progress baca, atau ayat terakhir.
- Data yang ditampilkan masih terbatas.

### 6.3 Latihan

Halaman Latihan sudah menunjukkan dua jenis aktivitas yang mudah dipahami: Tebak Surah dan Sambung Ayat. Ini baik untuk familiarity karena pengguna langsung mengenali format latihan.

Hal yang perlu diperbaiki:
- Tombol Mulai Latihan belum menjalankan latihan.
- Riwayat Latihan masih empty state statis.
- Belum ada feedback, skor, atau hasil latihan yang membantu synthesizability.

### 6.4 Target

Halaman Target adalah bagian yang paling kuat secara mental model karena pengguna dapat menambah target, melihat target berdasarkan waktu, menandai selesai, mengedit, dan menghapus.

Hal yang sudah memenuhi mental model:
- Pembagian Target Hari Ini, Target Mendatang, dan Diarsipkan jelas.
- Tombol plus dan form target mudah dipahami.
- Ikon edit, checklist, dan delete familiar.

Hal yang perlu diperbaiki:
- Edit target harus memperbarui target lama, bukan membuat target baru.
- Hapus target perlu konfirmasi untuk mencegah slip.
- Tambah, hapus, edit, dan selesai perlu feedback eksplisit.

### 6.5 Dashboard

Dashboard membantu pengguna melihat ringkasan, weekly streak, target hari ini, dan progress. Secara representasi, halaman ini cocok sebagai area monitoring.

Hal yang perlu diperbaiki:
- Weekly streak masih statis.
- Progress belum terhubung dengan aktivitas nyata.
- Dashboard dan Home memiliki informasi yang mirip, sehingga perlu pembagian fungsi yang lebih jelas agar mental model pengguna tidak bingung.

## 7. Prioritas Perbaikan Kode Berikutnya

1. Perbaiki flow edit target agar benar-benar memperbarui `TargetItem` yang dipilih.
2. Tambahkan feedback eksplisit menggunakan snackbar setelah tambah, edit, hapus, dan selesai target.
3. Tambahkan konfirmasi sebelum hapus target.
4. Nonaktifkan atau beri state "belum tersedia" pada search, Mulai Latihan, dan Mulai Sesi sampai fitur benar-benar terhubung.
5. Hubungkan progress, streak, dan riwayat latihan ke data nyata.
6. Perjelas active state pada navigasi, terutama perbedaan Home dan halaman shell utama.

## 8. Kesimpulan

Aplikasi IQRA' sudah sebagian memenuhi requirement mental model dan representasi dari materi Lesson 2.6. Kekuatan utamanya ada pada familiarity, struktur visual, dan konsistensi dasar. Kekurangan utamanya ada pada synthesizability, feedback cycle, dan beberapa mapping label-ke-perilaku yang belum akurat.

Target yang perlu ditempuh agar aplikasi lebih memenuhi prinsip mental model:

- [ ] Memperbaiki fitur edit target agar menyimpan perubahan pada target lama, bukan membuat target baru.
- [ ] Menambahkan feedback eksplisit setelah aksi tambah, edit, hapus, dan tandai selesai target.
- [ ] Menambahkan dialog konfirmasi sebelum target dihapus untuk mencegah action-based slip.
- [ ] Menghubungkan progress, streak, dan target harian di Home/Dashboard dengan data nyata.
- [ ] Memberikan state jelas pada fitur yang belum aktif, seperti Search, Mulai Latihan, dan Mulai Sesi.
- [ ] Menambahkan riwayat aktivitas atau log sederhana agar pengguna dapat memahami urutan aksi yang membentuk kondisi saat ini.
- [ ] Memperjelas active state pada navigasi agar pengguna selalu tahu sedang berada di halaman apa.
- [ ] Menyediakan hasil latihan, skor, atau riwayat latihan agar halaman Latihan memiliki feedback cycle yang kuat.
- [ ] Menambahkan penanda progress baca atau posisi terakhir pada halaman Al-Quran.
- [ ] Menyederhanakan istilah atau memberi konteks pada konsep seperti dashboard, streak, progress, dan sesi agar tidak bergantung pada asumsi expert.

Jika target-target tersebut dipenuhi, aplikasi akan lebih mampu "mengajari" pengguna cara kerja sistem melalui antarmuka, sesuai prinsip bahwa designer berperan sebagai educator.
