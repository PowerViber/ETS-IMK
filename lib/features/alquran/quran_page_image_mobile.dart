import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class QuranPageImage extends StatelessWidget {
  const QuranPageImage({
    super.key,
    required this.imageUrl,
    required this.pageNumber,
  });

  final String imageUrl;
  final int pageNumber;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.contain,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          height: 450,
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            color: const Color(0xFF166D56),
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: 250,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.broken_image_outlined,
                color: Colors.redAccent,
                size: 48,
              ),
              const SizedBox(height: 12),
              Text(
                'Gagal memuat halaman $pageNumber',
                style: TextStyle(
                  color: context.appTextSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Periksa koneksi internet Anda.',
                style: TextStyle(
                  color: context.appTextSecondary,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
