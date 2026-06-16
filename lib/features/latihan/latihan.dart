import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import 'latihan_data.dart';
import 'latihan_provider.dart';

class LatihanScreen extends ConsumerWidget {
  const LatihanScreen({super.key});

  void _showSetupBottomSheet(BuildContext context, String gameType) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useRootNavigator: true,
      builder: (context) {
        final juzOptions = [
          {'value': 0, 'label': 'Semua Juz'},
          for (int i = 1; i <= 30; i++)
            {'value': i, 'label': 'Juz $i'},
        ];

        final surahOptions = [
          'Semua Surah',
          ...getSurahNamesList(),
        ];

        bool filterByJuz = true;
        int startJuz = 1;
        int endJuz = 1;
        String selectedSurah = 'Semua Surah';
        int selectedCount = 5;
        bool useCustomFilter = false;

        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 14,
                right: 14,
                bottom: MediaQuery.of(context).viewInsets.bottom + 14,
                top: 14,
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: context.appSurface,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Color(0xFFE7F7F1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            gameType == 'Tebak Surah' ? Icons.quiz : Icons.menu_book,
                            color: const Color(0xFF166D56),
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pengaturan $gameType',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: context.appTextPrimary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Sesuaikan cakupan kuis hafalan Anda.',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: context.appTextSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    
                    // Scope Selection (Segmented-like buttons)
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setModalState(() {
                                useCustomFilter = false;
                              });
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: !useCustomFilter ? const Color(0xFFE7F7F1) : context.appBackground,
                                border: Border.all(
                                  color: !useCustomFilter ? const Color(0xFF1AAA7E) : context.appBorder,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  'Semua Hafalan',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    color: !useCustomFilter ? const Color(0xFF11624B) : context.appTextSecondary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setModalState(() {
                                useCustomFilter = true;
                              });
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: useCustomFilter ? const Color(0xFFE7F7F1) : context.appBackground,
                                border: Border.all(
                                  color: useCustomFilter ? const Color(0xFF1AAA7E) : context.appBorder,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  'Filter Khusus',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    color: useCustomFilter ? const Color(0xFF11624B) : context.appTextSecondary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    if (useCustomFilter) ...[
                      // Toggle Filter Type (Juz Range vs Surah)
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setModalState(() {
                                  filterByJuz = true;
                                });
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: filterByJuz ? const Color(0xFF166D56) : context.appSoftSurface,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    'Pilih Juz',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      color: filterByJuz ? Colors.white : context.appTextSecondary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setModalState(() {
                                  filterByJuz = false;
                                });
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: !filterByJuz ? const Color(0xFF166D56) : context.appSoftSurface,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    'Pilih Surah',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      color: !filterByJuz ? Colors.white : context.appTextSecondary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      if (filterByJuz) ...[
                        // Juz Range Selectors
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Dari Juz:',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      color: context.appTextPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: context.appBackground,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: context.appBorder),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<int>(
                                        value: startJuz,
                                        isExpanded: true,
                                        dropdownColor: context.appSurface,
                                        style: TextStyle(
                                          color: context.appTextPrimary,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                        ),
                                        onChanged: (val) {
                                          if (val != null) {
                                            setModalState(() {
                                              startJuz = val;
                                              if (endJuz < val) {
                                                endJuz = val;
                                              }
                                            });
                                          }
                                        },
                                        items: [
                                          for (int i = 1; i <= 30; i++)
                                            DropdownMenuItem<int>(
                                              value: i,
                                              child: Text('Juz $i'),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Sampai Juz:',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      color: context.appTextPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: context.appBackground,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: context.appBorder),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<int>(
                                        value: endJuz,
                                        isExpanded: true,
                                        dropdownColor: context.appSurface,
                                        style: TextStyle(
                                          color: context.appTextPrimary,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                        ),
                                        onChanged: (val) {
                                          if (val != null) {
                                            setModalState(() {
                                              endJuz = val;
                                              if (startJuz > val) {
                                                startJuz = val;
                                              }
                                            });
                                          }
                                        },
                                        items: [
                                          for (int i = 1; i <= 30; i++)
                                            DropdownMenuItem<int>(
                                              value: i,
                                              child: Text('Juz $i'),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ] else ...[
                        // Surah Dropdown
                        Text(
                          'Pilih Surah:',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: context.appTextPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: context.appBackground,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: context.appBorder),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedSurah,
                              isExpanded: true,
                              dropdownColor: context.appSurface,
                              style: TextStyle(
                                color: context.appTextPrimary,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                              onChanged: (val) {
                                if (val != null) {
                                  setModalState(() {
                                    selectedSurah = val;
                                  });
                                }
                              },
                              items: surahOptions.map((name) {
                                return DropdownMenuItem<String>(
                                  value: name,
                                  child: Text(name),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 18),
                    ],

                    // Question Count Dropdown
                    Text(
                      'Jumlah Soal:',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: context.appTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: context.appBackground,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: context.appBorder),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          value: selectedCount,
                          isExpanded: true,
                          dropdownColor: context.appSurface,
                          style: TextStyle(
                            color: context.appTextPrimary,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                          onChanged: (val) {
                            if (val != null) {
                              setModalState(() {
                                selectedCount = val;
                              });
                            }
                          },
                          items: [5, 10, 15, 20].map((count) {
                            return DropdownMenuItem<int>(
                              value: count,
                              child: Text('$count Soal'),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Start Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Close sheet
                          final path = gameType == 'Tebak Surah'
                              ? '/latihan/tebak-surah'
                              : '/latihan/sambung-ayat';
                          
                          final queryParams = <String, String>{};
                          queryParams['count'] = selectedCount.toString();
                          if (useCustomFilter) {
                            if (filterByJuz) {
                              queryParams['startJuz'] = startJuz.toString();
                              queryParams['endJuz'] = endJuz.toString();
                            } else {
                              if (selectedSurah != 'Semua Surah') {
                                queryParams['surah'] = selectedSurah;
                              }
                            }
                          }

                          final uri = Uri(path: path, queryParameters: queryParams.isEmpty ? null : queryParams);
                          context.go(uri.toString());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF166D56),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Mulai Sekarang',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showMurojaahStartDialog(BuildContext context, MurojaahRecommendation rec) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      useRootNavigator: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 14,
            right: 14,
            bottom: MediaQuery.of(context).viewInsets.bottom + 14,
            top: 14,
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: context.appSurface,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Murojaah ${rec.name}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: context.appTextPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Pilih metode latihan untuk memperkuat hafalan Anda.',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: context.appTextSecondary,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.quiz, size: 18),
                        label: const Text('Tebak Surah'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF166D56),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          final path = '/latihan/tebak-surah';
                          final queryParams = <String, String>{};
                          queryParams['count'] = '5';
                          if (rec.type == 'Surah') {
                            queryParams['surah'] = rec.name;
                          } else {
                            final juzStr = rec.name.replaceAll('Juz ', '');
                            queryParams['startJuz'] = juzStr;
                            queryParams['endJuz'] = juzStr;
                          }
                          context.go(Uri(path: path, queryParameters: queryParams).toString());
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.menu_book, size: 18),
                        label: const Text('Sambung Ayat'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF166D56),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          final path = '/latihan/sambung-ayat';
                          final queryParams = <String, String>{};
                          queryParams['count'] = '5';
                          if (rec.type == 'Surah') {
                            queryParams['surah'] = rec.name;
                          } else {
                            final juzStr = rec.name.replaceAll('Juz ', '');
                            queryParams['startJuz'] = juzStr;
                            queryParams['endJuz'] = juzStr;
                          }
                          context.go(Uri(path: path, queryParameters: queryParams).toString());
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(latihanHistoryProvider);
    final recommendations = ref.watch(latihanHistoryProvider.notifier).getMurojaahRecommendations();

    return Scaffold(
      backgroundColor: context.appBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Latihan',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: context.appTextPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Uji hafalan Al-Quran Anda dengan kuis interaktif.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: context.appTextSecondary,
                ),
              ),
              const SizedBox(height: 18),
              _LatihanCard(
                title: 'Tebak Surah',
                subtitle: 'Latih hafalan nama surah dengan kuis cepat.',
                buttonLabel: 'Mulai Kuis',
                icon: Icons.quiz,
                onTap: () => _showSetupBottomSheet(context, 'Tebak Surah'),
              ),
              const SizedBox(height: 10),
              _LatihanCard(
                title: 'Sambung Ayat',
                subtitle: 'Lanjutkan potongan ayat untuk menguji hafalan.',
                buttonLabel: 'Mulai Latihan',
                icon: Icons.menu_book,
                onTap: () => _showSetupBottomSheet(context, 'Sambung Ayat'),
              ),
              if (recommendations.isNotEmpty) ...[
                const SizedBox(height: 18),
                const _LatihanSectionHeader(
                  title: 'Rekomendasi Murojaah',
                  subtitle: 'Prioritas review berdasarkan tingkat akurasi Anda.',
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: recommendations.length,
                    itemBuilder: (context, idx) {
                      final rec = recommendations[idx];
                      return Container(
                        width: 160,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: context.appSurface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: context.appBorder),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0A000000),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () => _showMurojaahStartDialog(context, rec),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        rec.type == 'Surah' ? Icons.menu_book_rounded : Icons.grid_on_rounded,
                                        color: const Color(0xFF166D56),
                                        size: 16,
                                      ),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          rec.name,
                                          style: TextStyle(
                                            color: context.appTextPrimary,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w800,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Akurasi: ${(rec.accuracy * 100).toStringAsFixed(0)}%',
                                    style: TextStyle(
                                      color: context.appTextSecondary,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: LinearProgressIndicator(
                                      value: rec.accuracy,
                                      backgroundColor: context.appSoftSurface,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        rec.accuracy < 0.5
                                            ? const Color(0xFFE05252)
                                            : rec.accuracy < 0.75
                                                ? const Color(0xFFFFD166)
                                                : const Color(0xFF1AAA7E),
                                      ),
                                      minHeight: 6,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
              const SizedBox(height: 20),
              const _LatihanSectionHeader(
                title: 'Riwayat Latihan',
                subtitle: 'Hasil latihan Anda akan tersimpan di sini.',
              ),
              const SizedBox(height: 10),
              if (history.sessions.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                  decoration: BoxDecoration(
                    color: context.appSurface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: context.appBorder),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x12000000),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.history_toggle_off,
                            color: Color(0xFF166D56), size: 22),
                        const SizedBox(width: 10),
                        Text(
                          'Belum ada riwayat latihan',
                          style: TextStyle(
                            color: context.appTextSecondary,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 112),
                  itemCount: history.sessions.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final session = history.sessions[index];
                    final dateStr = '${session.dateTime.day}/${session.dateTime.month}/${session.dateTime.year}';
                    final timeStr = '${session.dateTime.hour.toString().padLeft(2, '0')}:${session.dateTime.minute.toString().padLeft(2, '0')}';
                    
                    return Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: context.appSurface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: context.appBorder),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0A000000),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: session.type == 'Tebak Surah'
                                  ? const Color(0xFFE7F7F1)
                                  : const Color(0xFFEAF2FF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              session.type == 'Tebak Surah'
                                  ? Icons.quiz
                                  : Icons.menu_book,
                              color: session.type == 'Tebak Surah'
                                  ? const Color(0xFF166D56)
                                  : const Color(0xFF2B66C5),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  session.type,
                                  style: TextStyle(
                                    color: context.appTextPrimary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '$dateStr - $timeStr',
                                  style: TextStyle(
                                    color: context.appTextSecondary,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF166D56),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Skor: ${session.score}/${session.totalQuestions}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LatihanCard extends StatelessWidget {
  const _LatihanCard({
    required this.title,
    required this.subtitle,
    required this.buttonLabel,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String buttonLabel;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.appSurface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: context.appBorder),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: context.appSoftSurface,
                  borderRadius: const BorderRadius.all(Radius.circular(14)),
                ),
                child: Icon(icon, color: const Color(0xFF166D56), size: 24),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: context.appTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: context.appTextSecondary,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE7F7F1),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        buttonLabel,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF11624B),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LatihanSectionHeader extends StatelessWidget {
  const _LatihanSectionHeader({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: context.appTextPrimary,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: context.appTextSecondary,
          ),
        ),
      ],
    );
  }
}
