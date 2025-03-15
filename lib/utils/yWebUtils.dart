import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class YoutubeHtmlWidget extends StatelessWidget {
  final String urlY ;
  YoutubeHtmlWidget({required this.urlY});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 1024,
        height: 750,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
        ),
        child: HtmlWidget(
          '''
            <style>
              iframe {
                border-radius: 8px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
              }
            </style>
            <iframe 
              src=$urlY 
              frameborder="0" 
              allowfullscreen>
            </iframe>
          ''',
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('url', urlY));
  }
}
