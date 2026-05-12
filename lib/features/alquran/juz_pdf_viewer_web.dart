// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';

class JuzPdfViewer extends StatefulWidget {
  const JuzPdfViewer({
    super.key,
    required this.assetPath,
  });

  final String assetPath;

  @override
  State<JuzPdfViewer> createState() => _JuzPdfViewerState();
}

class _JuzPdfViewerState extends State<JuzPdfViewer> {
  late final String _viewType =
      'juz-pdf-${widget.assetPath.hashCode}-${identityHashCode(this)}';

  @override
  void initState() {
    super.initState();
    ui_web.platformViewRegistry.registerViewFactory(_viewType, (viewId) {
      return html.IFrameElement()
        ..src = widget.assetPath
        ..title = 'Pembaca ${widget.assetPath}'
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.border = '0'
        ..style.backgroundColor = 'transparent';
    });
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: _viewType);
  }
}
