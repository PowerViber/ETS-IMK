// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';

class RemotePdfViewer extends StatefulWidget {
  const RemotePdfViewer({
    super.key,
    required this.url,
    required this.fallbackUrl,
  });

  final String url;
  final String fallbackUrl;

  @override
  State<RemotePdfViewer> createState() => _RemotePdfViewerState();
}

class _RemotePdfViewerState extends State<RemotePdfViewer> {
  late final String _viewType =
      'remote-quran-pdf-${widget.url.hashCode}-${identityHashCode(this)}';

  @override
  void initState() {
    super.initState();
    ui_web.platformViewRegistry.registerViewFactory(_viewType, (viewId) {
      return html.IFrameElement()
        ..src = widget.url
        ..title = 'Pembaca Al-Quran'
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.border = '0'
        ..style.backgroundColor = 'transparent'
        ..setAttribute('loading', 'lazy')
        ..setAttribute('allowfullscreen', 'true');
    });
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: _viewType);
  }
}
