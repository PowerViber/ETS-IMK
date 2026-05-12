import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import 'juz_document.dart';

class JuzReaderScreen extends StatefulWidget {
  const JuzReaderScreen({
    super.key,
    required this.document,
  });

  final JuzDocument document;

  @override
  State<JuzReaderScreen> createState() => _JuzReaderScreenState();
}

class _JuzReaderScreenState extends State<JuzReaderScreen> {
  late final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pageAssets = widget.document.pageAssetPaths;

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
              widget.document.title,
              style: TextStyle(
                color: context.appTextPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              widget.document.pageRangeLabel,
              style: TextStyle(
                color: context.appTextSecondary,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: Column(
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
                      Icons.menu_book_rounded,
                      color: Color(0xFF166D56),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.document.totalPages} halaman khusus untuk ${widget.document.title}',
                          style: TextStyle(
                            color: context.appTextPrimary,
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Geser halaman untuk membaca tanpa toolbar PDF browser.',
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
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: pageAssets.length,
                  onPageChanged: (value) {
                    setState(() {
                      _currentPage = value;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x22000000),
                              blurRadius: 18,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: InteractiveViewer(
                            minScale: 1,
                            maxScale: 4,
                            child: Center(
                              child: Image.asset(
                                pageAssets[index],
                                fit: BoxFit.contain,
                                width: double.infinity,
                                height: double.infinity,
                                filterQuality: FilterQuality.high,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 26,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xE6166D56),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        '${_currentPage + 1} / ${pageAssets.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
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
