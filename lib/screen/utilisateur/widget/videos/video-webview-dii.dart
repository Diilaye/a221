import 'package:actu/utils/color-by-dii.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class YoutubeWebView extends StatefulWidget {
  final String url ;

  final double taille ;

  const YoutubeWebView({super.key, required this.url , this.taille = 750});
  @override
  _YoutubeWebViewState createState() => _YoutubeWebViewState();
}

class _YoutubeWebViewState extends State<YoutubeWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()

      ..loadRequest(Uri.parse(widget.url
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 1024,
        height: widget.taille,
        decoration: BoxDecoration(
          color: noir,
        ),
        child: WebViewWidget(controller: _controller),
      ),
    );
  }
}
