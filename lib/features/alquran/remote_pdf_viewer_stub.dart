import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class RemotePdfViewer extends StatelessWidget {
  const RemotePdfViewer({
    super.key,
    required this.url,
    required this.fallbackUrl,
    required this.initialPage,
  });

  final String url;
  final String fallbackUrl;
  final int initialPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: context.appSurface,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24),
      child: Text(
        'PDF Supabase tersedia pada build web aplikasi.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: context.appTextSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
