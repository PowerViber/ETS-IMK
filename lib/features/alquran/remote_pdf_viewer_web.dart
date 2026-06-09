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
    required this.pageCount,
  });

  final String url;
  final String fallbackUrl;
  final int initialPage;
  final int pageCount;

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
          pageCount: widget.pageCount,
        )
        ..title = 'Pembaca Al-Quran'
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.border = '0'
        ..style.backgroundColor = 'transparent'
        ..setAttribute('loading', 'lazy')
        ..setAttribute(
          'sandbox',
          'allow-scripts allow-same-origin allow-downloads',
        )
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
  required int pageCount,
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
      min-height: 42px;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 8px 12px;
      background: var(--reader-surface);
      border-bottom: 1px solid var(--reader-border);
      backdrop-filter: blur(14px);
    }
    .page-label {
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
      -webkit-overflow-scrolling: touch;
    }
    .pages {
      display: flex;
      flex-direction: column;
      gap: 14px;
      align-items: center;
    }
    .page-shell {
      position: relative;
      width: 100%;
      display: flex;
      justify-content: center;
      align-items: flex-start;
      border-radius: 8px;
    }
    .page-shell canvas {
      display: block;
      width: 100%;
      height: auto;
      margin: 0 auto;
      border-radius: 8px;
      background: #fff;
      box-shadow: 0 10px 28px rgba(15, 23, 42, 0.16);
    }
    .page-badge {
      position: absolute;
      top: 8px;
      left: 8px;
      z-index: 1;
      min-width: 34px;
      padding: 4px 8px;
      border-radius: 999px;
      background: rgba(22, 109, 86, 0.88);
      color: #fff;
      font-size: 11px;
      font-weight: 800;
      text-align: center;
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
  <script src="https://cdn.jsdelivr.net/npm/pdfjs-dist@3.11.174/build/pdf.min.js"></script>
</head>
<body>
  <div class="toolbar" aria-label="Status halaman PDF">
    <div id="pageLabel" class="page-label">Memuat...</div>
  </div>
  <main id="viewer" class="viewer">
    <div id="state" class="state">Memuat halaman mushaf...</div>
    <div id="pages" class="pages" hidden></div>
  </main>
  <script>
    (async () => {
      const pdfjsLib = window['pdfjs-dist/build/pdf'] || window.pdfjsLib;
      pdfjsLib.GlobalWorkerOptions.workerSrc =
        'https://cdn.jsdelivr.net/npm/pdfjs-dist@3.11.174/build/pdf.worker.min.js';

      const pdfUrl = $encodedPdfUrl;
      const fallbackUrl = $encodedFallbackUrl;
      const viewer = document.getElementById('viewer');
      const state = document.getElementById('state');
      const pages = document.getElementById('pages');
      const pageLabel = document.getElementById('pageLabel');

      let pdfDocument = null;
      let startPage = Math.max(1, $initialPage);
      let endPage = startPage;
      let observer = null;
      let resizeTimer = null;

      function setBusy(message) {
        state.hidden = false;
        state.textContent = message;
        pages.hidden = true;
      }

      function pageWidth() {
        return Math.max(280, viewer.clientWidth - 20);
      }

      function updateLabel(currentPage) {
        const total = pdfDocument ? pdfDocument.numPages : 0;
        pageLabel.textContent = total
          ? 'Halaman ' + currentPage + ' / ' + total
          : 'Memuat...';
      }

      async function renderPageShell(shell) {
        if (!pdfDocument || shell.dataset.rendered === 'true') {
          return;
        }

        shell.dataset.rendered = 'true';
        const pageNumber = Number(shell.dataset.page);
        const canvas = shell.querySelector('canvas');
        const context = canvas.getContext('2d');
        const page = await pdfDocument.getPage(pageNumber);
        const baseViewport = page.getViewport({ scale: 1 });
        const deviceScale = Math.min(window.devicePixelRatio || 1, 2);
        const cssScale = pageWidth() / baseViewport.width;
        const viewport = page.getViewport({ scale: cssScale * deviceScale });

        canvas.width = Math.floor(viewport.width);
        canvas.height = Math.floor(viewport.height);
        canvas.style.maxWidth = Math.floor(viewport.width / deviceScale) + 'px';
        canvas.style.width = '100%';
        shell.style.minHeight = '';

        await page.render({ canvasContext: context, viewport }).promise;
      }

      function buildPageShells() {
        pages.innerHTML = '';
        const fragment = document.createDocumentFragment();

        for (let pageNumber = startPage; pageNumber <= endPage; pageNumber += 1) {
          const shell = document.createElement('section');
          shell.className = 'page-shell';
          shell.dataset.page = String(pageNumber);
          shell.dataset.rendered = 'false';
          shell.style.minHeight = Math.round(pageWidth() * 1.45) + 'px';

          const badge = document.createElement('div');
          badge.className = 'page-badge';
          badge.textContent = String(pageNumber);

          const canvas = document.createElement('canvas');
          shell.append(badge, canvas);
          fragment.append(shell);
        }

        pages.append(fragment);
        state.hidden = true;
        pages.hidden = false;
      }

      function observePages() {
        if (observer) {
          observer.disconnect();
        }

        observer = new IntersectionObserver((entries) => {
          entries.forEach((entry) => {
            const pageNumber = Number(entry.target.dataset.page);
            if (entry.isIntersecting) {
              updateLabel(pageNumber);
              renderPageShell(entry.target);
            }
          });
        }, {
          root: viewer,
          rootMargin: '900px 0px',
          threshold: 0.01,
        });

        document.querySelectorAll('.page-shell').forEach((shell) => {
          observer.observe(shell);
        });
      }

      function resetRenderedPages() {
        document.querySelectorAll('.page-shell').forEach((shell) => {
          shell.dataset.rendered = 'false';
          const canvas = shell.querySelector('canvas');
          const context = canvas.getContext('2d');
          context.clearRect(0, 0, canvas.width, canvas.height);
          canvas.width = 0;
          canvas.height = 0;
          shell.style.minHeight = Math.round(pageWidth() * 1.45) + 'px';
        });
        observePages();
      }

      window.addEventListener('resize', () => {
        window.clearTimeout(resizeTimer);
        resizeTimer = window.setTimeout(resetRenderedPages, 180);
      });

      try {
        setBusy('Memuat halaman mushaf...');
        pdfDocument = await pdfjsLib.getDocument({ url: pdfUrl }).promise;
        startPage = Math.min(startPage, pdfDocument.numPages);
        endPage = Math.min(pdfDocument.numPages, startPage + Math.max(1, $pageCount) - 1);
        updateLabel(startPage);
        buildPageShells();
        observePages();
      } catch (error) {
        state.hidden = false;
        pages.hidden = true;
        state.innerHTML =
          'PDF belum bisa dirender di perangkat ini.<br><a href="' +
          fallbackUrl +
          '" target="_blank" rel="noopener">Buka PDF langsung</a>';
        pageLabel.textContent = 'Gagal';
      }
    })();
  </script>
</body>
</html>
''';
}
