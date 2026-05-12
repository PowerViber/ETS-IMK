import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class LatihanScreen extends StatelessWidget {
  const LatihanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appBackground,
      body: Padding(
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
              'Mode latihan sedang disiapkan untuk hafalan yang lebih interaktif.',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: context.appTextSecondary,
              ),
            ),
            const SizedBox(height: 18),
            const _LatihanCard(
              title: 'Tebak Surah',
              subtitle: 'Latih hafalan nama surah dengan kuis cepat.',
              buttonLabel: 'Segera tersedia',
              icon: Icons.quiz,
            ),
            const SizedBox(height: 10),
            const _LatihanCard(
              title: 'Sambung Ayat',
              subtitle: 'Lanjutkan potongan ayat untuk menguji hafalan.',
              buttonLabel: 'Segera tersedia',
              icon: Icons.menu_book,
            ),
            const SizedBox(height: 20),
            const _LatihanSectionHeader(
              title: 'Riwayat Latihan',
              subtitle: 'Hasil latihan akan tersimpan di area ini.',
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
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
              ),
            ),
          ],
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
  });

  final String title;
  final String subtitle;
  final String buttonLabel;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFB9C9C3),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    buttonLabel,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF315B50),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
