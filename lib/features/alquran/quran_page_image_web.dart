import 'dart:html' as html;
import 'dart:ui_web' as ui_web;
import 'package:flutter/material.dart';

class QuranPageImage extends StatefulWidget {
  const QuranPageImage({
    super.key,
    required this.imageUrl,
    required this.pageNumber,
  });

  final String imageUrl;
  final int pageNumber;

  @override
  State<QuranPageImage> createState() => _QuranPageImageState();
}

class _QuranPageImageState extends State<QuranPageImage> {
  late final String _viewType = 'quran-page-${widget.pageNumber}';

  @override
  void initState() {
    super.initState();
    ui_web.platformViewRegistry.registerViewFactory(_viewType, (viewId) {
      return html.ImageElement()
        ..src = widget.imageUrl
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.objectFit = 'contain'
        ..style.display = 'block';
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.60, // Standard aspect ratio for Mushaf pages to prevent bottom clipping
      child: HtmlElementView(viewType: _viewType),
    );
  }
}
