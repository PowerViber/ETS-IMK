import 'package:flutter/material.dart';

class AlQuranScreen extends StatelessWidget {
  const AlQuranScreen({super.key});

  static const List<JuzSection> sections = [
    JuzSection(
      title: 'Juz 1',
      surahItems: [
        SurahItem(number: 1, name: 'Al-Fatihah', ayahCount: 7, type: 'Makkah'),
        SurahItem(
            number: 2, name: 'Al-Baqarah', ayahCount: 286, type: 'Madinah'),
      ],
    ),
    JuzSection(
      title: 'Juz 2',
      surahItems: [
        SurahItem(
            number: 3, name: 'Ali Imran', ayahCount: 200, type: 'Madinah'),
      ],
    ),
    JuzSection(
      title: 'Juz 4',
      surahItems: [
        SurahItem(number: 4, name: 'An-Nisa', ayahCount: 176, type: 'Madinah'),
      ],
    ),
    JuzSection(
      title: 'Juz 5\nJuz 6',
      surahItems: [
        SurahItem(
            number: 5, name: 'Al-Maidah', ayahCount: 120, type: 'Madinah'),
      ],
    ),
    JuzSection(
      title: 'Juz 7',
      surahItems: [
        SurahItem(number: 6, name: 'Al-Anam', ayahCount: 165, type: 'Madinah'),
      ],
    ),
    JuzSection(
      title: 'Juz 8',
      surahItems: [
        SurahItem(number: 7, name: 'Al-Araf', ayahCount: 206, type: 'Makkah'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F1F1),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Daftar Surah dan Juz',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF234B41),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  itemCount: sections.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return JuzCard(section: sections[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class JuzCard extends StatelessWidget {
  const JuzCard({super.key, required this.section});

  final JuzSection section;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFD3DFDB),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              color: Color(0xFFA7D4C7),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Text(
              section.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2D5550),
                height: 1.2,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              children: [
                for (final item in section.surahItems) ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 26,
                        child: Text(
                          item.number.toString(),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF24463E),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF24463E),
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${item.ayahCount} Ayat',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2E5A52),
                                height: 1.2,
                              ),
                            ),
                            Text(
                              item.type,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF254740),
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (item != section.surahItems.last)
                    const SizedBox(height: 8),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class JuzSection {
  const JuzSection({required this.title, required this.surahItems});

  final String title;
  final List<SurahItem> surahItems;
}

class SurahItem {
  const SurahItem({
    required this.number,
    required this.name,
    required this.ayahCount,
    required this.type,
  });

  final int number;
  final String name;
  final int ayahCount;
  final String type;
}
