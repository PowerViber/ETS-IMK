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

- [x] Memperbaiki fitur edit target agar menyimpan perubahan pada target lama, bukan membuat target baru.
- [x] Menambahkan feedback eksplisit setelah aksi tambah, edit, hapus, dan tandai selesai target.
- [x] Menambahkan dialog konfirmasi sebelum target dihapus untuk mencegah action-based slip.
- [ ] Menghubungkan progress, streak, dan target harian di Home/Dashboard dengan data nyata.
- [x] Memberikan state jelas pada fitur yang belum aktif, seperti Search, Mulai Latihan, dan Mulai Sesi.
- [x] Menambahkan riwayat aktivitas atau log sederhana agar pengguna dapat memahami urutan aksi yang membentuk kondisi saat ini.
- [x] Memperjelas active state pada navigasi agar pengguna selalu tahu sedang berada di halaman apa.
- [ ] Menyediakan hasil latihan, skor, atau riwayat latihan agar halaman Latihan memiliki feedback cycle yang kuat.
- [ ] Menambahkan penanda progress baca atau posisi terakhir pada halaman Al-Quran.
- [ ] Menyederhanakan istilah atau memberi konteks pada konsep seperti dashboard, streak, progress, dan sesi agar tidak bergantung pada asumsi expert.

Jika target-target tersebut dipenuhi, aplikasi akan lebih mampu "mengajari" pengguna cara kerja sistem melalui antarmuka, sesuai prinsip bahwa designer berperan sebagai educator.

## 9. Perubahan - target.dart (Code Changes & Effect)

| File | Code Changes | Effect terhadap Mental Model |
|---|---|---|
| `lib/features/target/target.dart` | Form target dibuat dinamis untuk mode tambah dan edit. Judul sheet berubah menjadi `Tambah Target Baru` atau `Edit Target`, dan tombol berubah menjadi `Simpan Target` atau `Simpan Perubahan`. | Label dan perilaku menjadi cocok. Pengguna yang memilih edit akan melihat konteks edit dan sistem benar-benar memperbarui target lama, bukan membuat target baru. |
| `lib/features/target/target.dart` | Validasi judul kosong sekarang menampilkan snackbar `Judul target tidak boleh kosong` dan sheet tidak ditutup. | Feedback cycle menjadi lebih jelas karena pengguna langsung tahu mengapa aksi simpan tidak berjalan. |
| `lib/features/target/target.dart` | Aksi tambah, edit, tandai selesai, kembalikan target, dan hapus target menampilkan snackbar berhasil. | Pengguna mendapat feedback eksplisit setelah melakukan aksi, sehingga hubungan input-output lebih mudah dipahami. |
| `lib/features/target/target.dart` | Aksi hapus target sekarang membuka dialog konfirmasi `Hapus Target?` dengan pilihan `Batal` dan `Hapus`. | Mengurangi action-based slip karena target tidak langsung hilang saat ikon delete tidak sengaja ditekan. |
| `lib/features/target/target.dart` | `_TargetCard` menerima `onEdit` dan `onToggleDone` secara opsional, sehingga target yang sudah diarsipkan dapat hanya menampilkan aksi hapus. | UI lebih sesuai dengan status target. Target arsip tidak lagi menampilkan aksi yang tidak tersedia, dan error analyzer akibat callback wajib hilang. |
| `lib/features/target/target.dart` | Chip kosong/aksi `Mulai Sesi` diganti menjadi label non-aksi `Sesi belum tersedia`. | Mencegah learned helplessness karena pengguna tidak melihat tombol aktif yang belum menjalankan fitur nyata. |
| `lib/features/target/target_provider.dart` | Menambahkan method `updateTarget(id, title, description, date)` yang mempertahankan `id` dan `isCompleted`. | Mendukung mental model bahwa edit berarti memperbarui data lama, bukan membuat data baru. |
| `lib/features/target/target_model.dart` | Merapikan `copyWith` agar mempertahankan `id` tanpa qualifier `this.` yang tidak perlu. | Menghilangkan warning analyzer dan menjaga model data tetap stabil saat target diperbarui. |

## 10. Perubahan - State Fitur Belum Aktif (Code Changes & Effect)

| File | Code Changes | Effect terhadap Mental Model |
|---|---|---|
| `lib/features/home/home.dart` | Placeholder search `Cari surat atau ayat ...` diganti menjadi `Pencarian belum tersedia` dan ikon diganti menjadi `search_off`. | Pengguna tidak lagi mengira kolom pencarian sudah bisa digunakan. Ini meningkatkan predictability karena representasi visual sesuai dengan status fitur. |
| `lib/features/dashboard/dashboard.dart` | Ikon search pada app bar diganti menjadi `search_off`, diberi tooltip `Pencarian belum tersedia`, dan `onPressed` dibuat `null`. | Aksi yang belum tersedia tampil sebagai disabled action, sehingga mengurangi knowledge-based mistake dan learned helplessness. |
| `lib/features/latihan/latihan.dart` | Label chip `Mulai Latihan` pada kartu Tebak Surah dan Sambung Ayat diganti menjadi `Segera tersedia`, dengan warna chip non-aksi. | Pengguna memahami bahwa latihan belum bisa dimulai, bukan tombol yang gagal merespons. Ini memperbaiki feedback ekspektasi sebelum fitur latihan penuh dibangun. |

## 11. Perubahan - Riwayat Aktivitas Target (Code Changes & Effect)

| File | Code Changes | Effect terhadap Mental Model |
|---|---|---|
| `lib/features/target/target.dart` | Menambahkan state `_activityLogs` untuk menyimpan maksimal 5 aktivitas terbaru pada layar Target. | Pengguna dapat melihat urutan aksi yang baru dilakukan, sehingga kondisi sistem saat ini lebih mudah dipahami. |
| `lib/features/target/target.dart` | Menambahkan helper `_recordActivity(...)` dengan timestamp jam dan menit. Helper ini dipanggil saat target ditambah, diedit, dipindahkan ke arsip, dikembalikan, dan dihapus. | Memperkuat synthesizability karena pengguna dapat menelusuri perubahan terakhir tanpa harus mengingat semua aksi sendiri. |
| `lib/features/target/target.dart` | Menambahkan section `Riwayat Aktivitas` di bawah `Diarsipkan`, termasuk empty state `Belum ada aktivitas target`. | Sistem memberi representasi eksplisit terhadap riwayat aksi. Empty state juga membantu pengguna memahami bahwa belum ada aktivitas, bukan data gagal dimuat. |

## 12. Perubahan - Active State Navigasi (Code Changes & Effect)

| File | Code Changes | Effect terhadap Mental Model |
|---|---|---|
| `lib/shared/widgets/main_scaffold.dart` | Active state navigasi dipindahkan ke ikon floating dock: ikon halaman aktif diberi fill emerald dan icon color putih. | Pengguna lebih mudah mengetahui halaman shell yang sedang dibuka, sehingga konsistensi navigasi meningkat. |
| `lib/features/home/home.dart` | Ikon Home pada floating dock tampil aktif ketika route `/home` dibuka. | Mengurangi kebingungan antara Home dan halaman lain karena posisi pengguna diberi visual cue yang jelas. |

## 13. Perubahan - Modernisasi Visual Hierarchy Home (Code Changes & Effect)

| File | Code Changes | Effect terhadap Mental Model |
|---|---|---|
| `lib/features/home/home.dart` | Greeting dipisah menjadi salam kecil dan nama pengguna yang lebih besar. | Pengguna langsung memahami bahwa Home adalah halaman orientasi utama, bukan hanya daftar kartu biasa. |
| `lib/features/home/home.dart` | Kartu streak diubah menjadi hero card gelap dengan badge `0 Hari`, judul lebih kuat, dan copy pendukung. | Aksi utama untuk membangun kebiasaan belajar menjadi lebih menonjol dan emosional, sehingga motivasi pengguna lebih jelas. |
| `lib/features/home/home.dart` | Tombol `Mulai Target Baru` dibuat lebih besar, memakai ikon tambah, dan warna primer yang lebih kuat. | Primary action lebih mudah diprediksi dan lebih cepat ditemukan. |
| `lib/features/home/home.dart` | Section `Target Hari Ini` dan `Progress` memakai header dengan subtitle, sedangkan progress cards dibuat putih dengan ikon dalam badge kecil. | Hierarki informasi menjadi lebih modern: halaman punya heading, konteks, aksi utama, lalu ringkasan sekunder. |

## 14. Perubahan - Modernisasi Target Screen (Code Changes & Effect)

| File | Code Changes | Effect terhadap Mental Model |
|---|---|---|
| `lib/features/target/target.dart` | Menambahkan judul halaman `Target` dan subtitle konteks di bagian atas layar. | Pengguna langsung memahami fungsi halaman sebelum melihat daftar target. |
| `lib/features/target/target.dart` | CTA `Mulai Target Baru` dibuat lebih besar, berwarna emerald gelap, dan memakai ikon tambah. | Aksi utama halaman menjadi lebih jelas dan mudah ditemukan. |
| `lib/features/target/target.dart` | Section Target Hari Ini, Target Mendatang, Diarsipkan, dan Riwayat Aktivitas memakai header dengan subtitle. | Setiap kelompok informasi punya konteks yang jelas, sehingga pengguna lebih mudah memahami status target. |
| `lib/features/target/target.dart` | Target card, empty state, dan activity log card diubah menjadi card putih dengan border halus dan shadow ringan. | Tampilan lebih modern dan hierarki visual lebih bersih karena tidak semua elemen memakai warna hijau yang sama. |
| `lib/features/target/target.dart` | Empty state `Tidak Ada` diganti menjadi pesan spesifik seperti `Belum ada target hari ini`, `Belum ada target mendatang`, dan `Belum ada arsip`. | Mengurangi ambiguitas karena pengguna tahu data apa yang kosong dan apa yang dapat dilakukan berikutnya. |

## 15. Perubahan - Modernisasi Dashboard, Latihan, dan Al-Quran (Code Changes & Effect)

| File | Code Changes | Effect terhadap Mental Model |
|---|---|---|
| `lib/features/dashboard/dashboard.dart` | Dashboard memakai heading lebih rapi, hero focus card, section subtitle, target rows yang lebih jelas, dan empty progress state yang lebih informatif. | Dashboard terasa sebagai pusat monitoring, bukan kumpulan blok statis. Pengguna lebih cepat membaca prioritas dan status. |
| `lib/features/latihan/latihan.dart` | Halaman Latihan mendapat title page yang lebih jelas, kartu latihan putih yang lebih modern, status `Segera tersedia` dipertahankan, dan riwayat latihan diubah menjadi empty state yang lebih terstruktur. | Pengguna memahami bahwa latihan adalah area fitur yang sedang disiapkan, bukan halaman yang tampak rusak atau belum selesai secara acak. |
| `lib/features/alquran/alquran.dart` | Halaman Al-Quran diberi heading halaman, subtitle, kartu juz putih, badge nomor surah, dan visual hierarchy baru untuk nama surah serta metadata. | Daftar surah menjadi lebih mudah dipindai. Struktur juz dan item surah terasa lebih representatif dan tidak sekadar tabel teks. |
| `lib/features/alquran/alquran.dart` | Label `Juz 5 - 6` dipertahankan sebagai format judul tunggal yang lebih ringkas. | Mengurangi kesan baris pecah yang tidak perlu dan membuat representasi kelompok juz lebih konsisten. |

## 16. Perubahan - Floating Icon Bottom Navigation (Code Changes & Effect)

| File | Code Changes | Effect terhadap Mental Model |
|---|---|---|
| `lib/shared/widgets/main_scaffold.dart` | Navigasi shell dipindahkan dari top tab bar menjadi dock ikon floating di bagian bawah layar, dengan surface semi-transparan, shadow, dan active icon state. | Navigasi utama terasa lebih mobile-native dan lebih mudah dijangkau ibu jari. Pengguna tetap dapat mengenali posisi aktif melalui ikon yang diberi highlight. |
| `lib/shared/widgets/main_scaffold.dart` | Top bar disederhanakan menjadi identitas `IQRA'` dan akses profile/dashboard saja. | Struktur visual menjadi lebih ringan karena area atas tidak lagi memuat dua fungsi sekaligus: branding dan tab switching. |
| `lib/features/home/home.dart` | Home memakai dock ikon floating yang sama dengan status aktif pada ikon Home, sementara top bar diringkas menjadi branding dan profile. | Pengalaman Home dan halaman shell terasa konsisten, sehingga perubahan posisi navigasi tidak memecah mental model pengguna. |

## 17. Perubahan - Refined Floating Dock Interaction (Code Changes & Effect)

| File | Code Changes | Effect terhadap Mental Model |
|---|---|---|
| `lib/shared/widgets/main_scaffold.dart` | Surface dock dibuat lebih transparan secara default dan tidak lagi terasa seperti blok solid di belakang ikon. | Dock terasa lebih ringan di atas konten dan tidak mendominasi layar. |
| `lib/shared/widgets/main_scaffold.dart` | Saat ikon di-long press, dock menjadi full opacity dan menampilkan label konteks seperti `Home`, `Al-Quran`, `Latihan`, atau `Target`. | Pengguna bisa tetap memakai navigasi logo-only, tetapi masih punya akses ke arti ikon ketika membutuhkan bantuan. |
| `lib/shared/widgets/main_scaffold.dart` | Padding kosong di bawah konten shell dihapus sehingga tidak ada lagi strip latar persegi di belakang dock floating. | Dock benar-benar terasa melayang di atas konten, bukan berada di atas area footer buatan. |
| `lib/features/home/home.dart` | Floating dock Home mendapat perilaku opacity dan long-press label yang sama seperti scaffold utama. | Konsistensi interaksi tetap terjaga pada halaman pertama aplikasi. |

## 18. Perubahan - Dark Mode dan Toggle Dashboard (Code Changes & Effect)

| File | Code Changes | Effect terhadap Mental Model |
|---|---|---|
| `lib/core/theme/theme_mode_provider.dart` | Menambahkan provider `themeModeProvider` untuk mengelola mode terang dan gelap secara global. | Preferensi tampilan memiliki sumber state yang jelas dan bisa dipakai konsisten di seluruh aplikasi. |
| `lib/core/theme/app_theme.dart` | Menambahkan `darkTheme`, palet warna permukaan gelap, serta helper context seperti `appBackground`, `appSurface`, `appTextPrimary`, dan warna dock. | Representasi visual tetap konsisten saat mode berubah; pengguna tidak menemukan halaman yang sebagian terang dan sebagian gelap secara acak. |
| `lib/main.dart` | `MaterialApp.router` kini membaca `themeModeProvider`, memakai `theme`, `darkTheme`, dan `themeMode`. | Toggle benar-benar mengubah tema aplikasi, bukan hanya satu layar tertentu. |
| `lib/features/dashboard/dashboard.dart` | Menambahkan panel `Mode Gelap` dengan ikon status, deskripsi singkat, dan `Switch` sebagai kontrol utama perubahan tema. | Dashboard menjadi tempat kontrol preferensi tampilan yang mudah ditemukan dan predictable. |
| `lib/features/home/home.dart`, `lib/shared/widgets/main_scaffold.dart`, `lib/features/target/target.dart`, `lib/features/latihan/latihan.dart`, `lib/features/alquran/alquran.dart` | Permukaan, teks utama, teks sekunder, border, dan dock floating diikat ke helper theme-aware agar ikut menyesuaikan light/dark mode. | Dark mode terasa menyeluruh dan tidak merusak keterbacaan di layar inti aplikasi. |

## 19. Perubahan - PDF Juz Reader Al-Quran (Code Changes & Effect)

| File | Code Changes | Effect terhadap Mental Model |
|---|---|---|
| `surah-quran/juz/juz-01.pdf` s.d. `juz-30.pdf` | PDF utama `alquran.pdf` dipisahkan menjadi 30 file juz berdasarkan rentang halaman mushaf standar. | Pengguna membuka satu konteks bacaan yang jelas, bukan satu dokumen besar tanpa batas bagian. |
| `lib/features/alquran/juz_document.dart` | Menambahkan data metadata juz: nomor juz, rentang halaman mushaf, jumlah halaman, dan path asset PDF. | Struktur representasi juz menjadi eksplisit dan bisa dipakai konsisten oleh daftar maupun reader. |
| `lib/features/alquran/alquran.dart` | Halaman Al-Quran diubah menjadi perpustakaan 30 juz yang menampilkan judul, rentang halaman, dan jumlah halaman PDF. | Pengguna lebih mudah memilih bagian yang diinginkan sebelum masuk ke mode baca. |
| `lib/features/alquran/juz_reader.dart` | Reader juz diubah dari iframe PDF browser menjadi `PageView` native berbasis image pages, lengkap dengan zoom gesture dan indikator halaman. | Toolbar PDF browser hilang sehingga perpindahan dari UI aplikasi ke halaman bacaan terasa lebih seamless. |
| `lib/core/router/app_router.dart` | Menambahkan route `/alquran/juz/:number` untuk membuka reader juz tertentu. | Navigasi dari daftar menuju bacaan menjadi langsung dan predictable. |
| `pubspec.yaml` | Menambahkan asset folder halaman hasil render `surah-quran/juz-pages/juz-01/` s.d. `juz-30/`. | Reader dapat menampilkan mushaf langsung sebagai bagian dari UI aplikasi, tanpa chrome dari PDF viewer browser. |

## 20. Perubahan - Supabase Quran PDF Hosting (Code Changes & Effect)

| File | Code Changes | Effect terhadap Mental Model |
|---|---|---|
| `lib/features/alquran/juz_document.dart` | Menambahkan metadata `QuranPdfSource` untuk 8 file PDF Supabase `alquran_1.pdf` sampai `alquran_8.pdf`, termasuk rentang halaman sumber. | Aplikasi tetap tahu bagian PDF mana yang harus dibuka untuk setiap juz tanpa menyimpan file besar di repository. |
| `lib/features/alquran/juz_reader.dart`, `lib/features/alquran/remote_pdf_viewer.dart` | Reader sekarang membuka file PDF hosted Supabase dengan parameter halaman awal dan mode toolbar minimal. | Pengguna tetap masuk dari daftar juz ke halaman baca, sementara asset besar diambil dari storage eksternal. |
| `pubspec.yaml`, `.gitignore` | Menghapus registrasi asset PDF/image Quran besar dari bundle Flutter dan menambahkan ignore rule untuk file besar lokal. | Repository lebih ringan untuk GitHub dan Vercel, serta mengurangi risiko asset besar ikut ter-commit lagi. |

## 21. Perubahan - Mobile PDF Rendering Al-Quran (Code Changes & Effect)

| File | Code Changes | Effect terhadap Mental Model |
|---|---|---|
| `lib/features/alquran/remote_pdf_viewer_web.dart` | Iframe tidak lagi diarahkan langsung ke file PDF. Reader web sekarang memuat PDF.js dan merender halaman mushaf ke canvas, dengan kontrol halaman sederhana. | Di Android Chrome, pengguna melihat halaman mushaf langsung di dalam aplikasi, bukan placeholder PDF gelap dengan tombol `Open`. |
| `lib/features/alquran/juz_document.dart` | Menambahkan `initialPageInPart` agar halaman awal juz bisa dikirim sebagai angka eksplisit ke reader canvas. | Reader tetap memulai dari halaman juz yang benar walaupun PDF disimpan sebagai 8 part Supabase, bukan 30 file juz lokal. |
| `lib/features/alquran/juz_reader.dart` | Reader mengirim URL mentah Supabase dan nomor halaman awal ke `RemotePdfViewer`. | Alur dari daftar juz ke halaman baca tetap terasa sama, tetapi rendering tidak bergantung pada kemampuan browser membuka PDF inline. |
| `lib/features/alquran/remote_pdf_viewer_stub.dart` | Constructor stub disamakan dengan versi web memakai parameter `initialPage`. | Struktur komponen tetap konsisten di build non-web dan web. |
