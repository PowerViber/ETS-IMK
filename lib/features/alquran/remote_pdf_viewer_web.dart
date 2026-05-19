// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:convert';
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';

class RemotePdfViewer extends StatefulWidget {
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
        ..srcdoc = _pdfJsViewerHtml(
          pdfUrl: widget.url,
          fallbackUrl: widget.fallbackUrl,
          initialPage: widget.initialPage,
        )
        ..title = 'Pembaca Al-Quran'
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.border = '0'
        ..style.backgroundColor = 'transparent'
        ..setAttribute('loading', 'lazy')
        ..setAttribute(
            'sandbox', 'allow-scripts allow-same-origin allow-downloads')
        ..setAttribute('allowfullscreen', 'true');
    });
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: _viewType);
  }
}

String _pdfJsViewerHtml({
  required String pdfUrl,
  required String fallbackUrl,
  required int initialPage,
}) {
  final encodedPdfUrl = jsonEncode(pdfUrl);
  final encodedFallbackUrl = jsonEncode(fallbackUrl);

  return '''
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <style>
    :root {
      color-scheme: light dark;
      --reader-bg: #f4f8f6;
      --reader-surface: rgba(255, 255, 255, 0.92);
      --reader-text: #164b3f;
      --reader-muted: #6b7d77;
      --reader-border: rgba(22, 109, 86, 0.14);
      --reader-accent: #166d56;
    }
    @media (prefers-color-scheme: dark) {
      :root {
        --reader-bg: #101412;
        --reader-surface: rgba(28, 35, 32, 0.94);
        --reader-text: #e8f4ef;
        --reader-muted: #aab8b3;
        --reader-border: rgba(219, 239, 231, 0.12);
        --reader-accent: #66c7a8;
      }
    }
    * { box-sizing: border-box; }
    html, body {
      width: 100%;
      height: 100%;
      margin: 0;
      overflow: hidden;
      background: var(--reader-bg);
      font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
    }
    body {
      display: flex;
      flex-direction: column;
      color: var(--reader-text);
    }
    .toolbar {
      min-height: 48px;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 12px;
      padding: 8px 12px;
      background: var(--reader-surface);
      border-bottom: 1px solid var(--reader-border);
      backdrop-filter: blur(14px);
    }
    .toolbar button {
      width: 36px;
      height: 32px;
      border: 1px solid var(--reader-border);
      border-radius: 12px;
      background: transparent;
      color: var(--reader-text);
      font-size: 18px;
      font-weight: 800;
    }
    .toolbar button:disabled {
      opacity: 0.35;
    }
    .page-label {
      min-width: 92px;
      text-align: center;
      font-size: 13px;
      font-weight: 800;
      color: var(--reader-text);
    }
    .viewer {
      flex: 1;
      min-height: 0;
      overflow: auto;
      padding: 12px 10px 116px;
      text-align: center;
      -webkit-overflow-scrolling: touch;
    }
    canvas {
      display: block;
      width: 100%;
      height: auto;
      margin: 0 auto;
      border-radius: 8px;
      background: #fff;
      box-shadow: 0 10px 28px rgba(15, 23, 42, 0.16);
    }
    .state {
      height: 100%;
      display: grid;
      place-items: center;
      padding: 24px;
      text-align: center;
      color: var(--reader-muted);
      font-size: 14px;
      line-height: 1.5;
    }
    .state a {
      display: inline-block;
      margin-top: 12px;
      color: var(--reader-accent);
      font-weight: 800;
      text-decoration: none;
    }
  </style>
</head>
<body>
  <div class="toolbar" aria-label="Kontrol halaman PDF">
    <button id="prevPage" type="button" aria-label="Halaman sebelumnya">‹</button>
    <div id="pageLabel" class="page-label">Memuat...</div>
    <button id="nextPage" type="button" aria-label="Halaman berikutnya">›</button>
  </div>
  <main id="viewer" class="viewer">
    <div id="state" class="state">Memuat halaman mushaf...</div>
    <canvas id="pdfCanvas" hidden></canvas>
  </main>
  <script type="module">
    import * as pdfjsLib from 'https://cdn.jsdelivr.net/npm/pdfjs-dist@4.10.38/build/pdf.mjs';

    pdfjsLib.GlobalWorkerOptions.workerSrc =
      'https://cdn.jsdelivr.net/npm/pdfjs-dist@4.10.38/build/pdf.worker.mjs';

    const pdfUrl = $encodedPdfUrl;
    const fallbackUrl = $encodedFallbackUrl;
    const canvas = document.getElementById('pdfCanvas');
    const context = canvas.getContext('2d');
    const viewer = document.getElementById('viewer');
    const state = document.getElementById('state');
    const pageLabel = document.getElementById('pageLabel');
    const prevPage = document.getElementById('prevPage');
    const nextPage = document.getElementById('nextPage');

    let pdfDocument = null;
    let pageNumber = Math.max(1, $initialPage);
    let renderTask = null;
    let resizeTimer = null;

    function setBusy(message) {
      state.hidden = false;
      state.textContent = message;
      canvas.hidden = true;
    }

    function updateControls() {
      const total = pdfDocument ? pdfDocument.numPages : 0;
      pageLabel.textContent = total ? pageNumber + ' / ' + total : 'Memuat...';
      prevPage.disabled = !total || pageNumber <= 1;
      nextPage.disabled = !total || pageNumber >= total;
    }

    async function renderPage() {
      if (!pdfDocument) return;
      if (renderTask) {
        renderTask.cancel();
      }

      updateControls();
      const page = await pdfDocument.getPage(pageNumber);
      const baseViewport = page.getViewport({ scale: 1 });
      const availableWidth = Math.max(280, viewer.clientWidth - 20);
      const deviceScale = Math.min(window.devicePixelRatio || 1, 2);
      const cssScale = availableWidth / baseViewport.width;
      const viewport = page.getViewport({ scale: cssScale * deviceScale });

      canvas.width = Math.floor(viewport.width);
      canvas.height = Math.floor(viewport.height);
      canvas.style.maxWidth = Math.floor(viewport.width / deviceScale) + 'px';
      canvas.style.width = '100%';

      state.hidden = true;
      canvas.hidden = false;

      renderTask = page.render({ canvasContext: context, viewport });
      try {
        await renderTask.promise;
      } catch (error) {
        if (error?.name !== 'RenderingCancelledException') {
          throw error;
        }
      } finally {
        renderTask = null;
      }
    }

    prevPage.addEventListener('click', () => {
      if (pageNumber > 1) {
        pageNumber -= 1;
        renderPage();
      }
    });

    nextPage.addEventListener('click', () => {
      if (pdfDocument && pageNumber < pdfDocument.numPages) {
        pageNumber += 1;
        renderPage();
      }
    });

    window.addEventListener('resize', () => {
      window.clearTimeout(resizeTimer);
      resizeTimer = window.setTimeout(renderPage, 180);
    });

    try {
      setBusy('Memuat halaman mushaf...');
      pdfDocument = await pdfjsLib.getDocument({ url: pdfUrl }).promise;
      pageNumber = Math.min(pageNumber, pdfDocument.numPages);
      await renderPage();
    } catch (error) {
      state.hidden = false;
      canvas.hidden = true;
      state.innerHTML =
        'PDF belum bisa dirender di perangkat ini.<br><a href="' +
        fallbackUrl +
        '" target="_blank" rel="noopener">Buka PDF langsung</a>';
      pageLabel.textContent = 'Gagal';
      prevPage.disabled = true;
      nextPage.disabled = true;
    }
  </script>
</body>
</html>
''';
}
