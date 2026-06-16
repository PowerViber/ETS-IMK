import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import 'juz_document.dart';
import 'remote_pdf_viewer.dart';

class JuzReaderScreen extends StatelessWidget {
  const JuzReaderScreen({
    super.key,
    required this.document,
  });

  final JuzDocument document;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: context.appBackground,
      appBar: AppBar(
        backgroundColor: context.appBackground,
        leading: IconButton(
          tooltip: 'Kembali ke daftar juz',
          onPressed: () => context.go('/alquran'),
          icon: Icon(Icons.arrow_back_rounded, color: context.appTextPrimary),
        ),
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              document.title,
              style: TextStyle(
                color: context.appTextPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              document.pageRangeLabel,
              style: TextStyle(
                color: context.appTextSecondary,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: context.appSurface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: context.appBorder),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: context.appSoftSurface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.cloud_done_rounded,
                        color: Color(0xFF166D56),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mushaf Madani (Hafs)',
                            style: TextStyle(
                              color: context.appTextPrimary,
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Halaman dimuat otomatis dari CDN Quran.app dengan resolusi tinggi.',
                            style: TextStyle(
                              color: context.appTextSecondary,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(18),
                ),
                child: RemotePdfViewer(
                  mushafStartPage: document.mushafStartPage,
                  pageCount: document.totalPages,
                  juzNumber: document.number,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
