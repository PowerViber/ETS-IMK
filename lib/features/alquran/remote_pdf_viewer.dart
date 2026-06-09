import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import 'quran_page_image.dart';

class RemotePdfViewer extends StatelessWidget {
  const RemotePdfViewer({
    super.key,
    required this.mushafStartPage,
    required this.pageCount,
    required this.juzNumber,
  });

  final int mushafStartPage;
  final int pageCount;
  final int juzNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.appBackground,
      child: ListView.builder(
        itemCount: pageCount,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 120), // Extra bottom padding for the floating navigation dock
        itemBuilder: (context, index) {
          final pageNumber = mushafStartPage + index;
          final pageString = pageNumber.toString().padLeft(3, '0');
          final imageUrl = 'https://files.quran.app/hafs/madani/width_1024/page$pageString.png';

          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Page Number Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Halaman $pageNumber',
                      style: TextStyle(
                        color: context.appTextSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Juz $juzNumber',
                      style: TextStyle(
                        color: context.appTextSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Card containing the Quran page image
                Card(
                  color: Colors.white, // Standard white background for mushaf page contrast
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: context.appBorder),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: QuranPageImage(
                        imageUrl: imageUrl,
                        pageNumber: pageNumber,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
