import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BarDiagarm extends StatelessWidget {
  final int maxY;
  final List<Map<String, dynamic>> data;

  const BarDiagarm({super.key, required this.maxY, required this.data});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: blanc,
          child: Column(
            children: List.generate(
                8,
                (int i) => Column(
                      children: [
                        paddingVerticalGlobal(maxY / 24),
                        Row(
                          children: [
                            SizedBox(
                                width: 25,
                                child: Row(
                                  children: [
                                    Text("${i * (maxY / 8)}"),
                                  ],
                                )),
                            paddingHorizontalGlobal(4),
                            Expanded(
                                child: Container(
                              height: 1,
                              color: rouge,
                            ))
                          ],
                        ),
                        paddingVerticalGlobal(maxY / 24),
                      ],
                    )).reversed.toList(),
          ),
        ),
        Positioned(
            bottom: 0,
            left: 8,
            right: 0,
            child: Row(
              children: data
                  .map((e) => Expanded(child: Center(child: Text(e['day']))))
                  .toList(),
            )),
        Positioned(
            bottom: 28,
            top: 0,
            left: 8,
            right: 0,
            child: SizedBox(
              height: maxY.toDouble(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      color: rouge,
                    ),
                  ),
                  Row(
                    children: data
                        .map((e) => Expanded(
                                child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: e['views'] > e['comments']
                                          ? e['views']
                                          : e['comments'],
                                      child: Column(
                                        children: [
                                          Container(
                                            height: e['views'],
                                            width: 25,
                                            color: rouge,
                                          ),
                                        ],
                                      ),
                                    ),
                                    paddingHorizontalGlobal(0),
                                    SizedBox(
                                      height: e['views'] > e['comments']
                                          ? e['views']
                                          : e['comments'],
                                      child: Column(
                                        children: [
                                          Container(
                                            height: e['comments'],
                                            width: 25,
                                            color: bleuMarine,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )))
                        .toList(),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

class BarDouble extends StatelessWidget {
  final Map<String, dynamic> data;
  const BarDouble({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      child: Row(
        children: [
          paddingHorizontalGlobal(8),
          Container(
            width: 30,
            height: data['views'],
            color: rouge,
          ),
          paddingHorizontalGlobal(2),
          Container(
            width: 30,
            height: data['comments'],
            color: bleuMarine,
          ),
          paddingHorizontalGlobal(8),
        ],
      ),
    );
  }
}

class BarChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> data;
  final double maxY;

  BarChartPainter({required this.data, required this.maxY});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint barPaintViews = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final Paint barPaintComments = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final double barWidth = size.width / (data.length * 2);

    for (int i = 0; i < data.length; i++) {
      final double x = (i * 2 + 1) * barWidth;
      final double viewsHeight = (data[i]['views'] / maxY) * size.height;
      final double commentsHeight = (data[i]['comments'] / maxY) * size.height;

      canvas.drawRect(
        Rect.fromLTWH(x, size.height - viewsHeight, barWidth, viewsHeight),
        barPaintViews,
      );

      canvas.drawRect(
        Rect.fromLTWH(x + barWidth / 2, size.height - commentsHeight, barWidth,
            commentsHeight),
        barPaintComments,
      );
    }

    final textStyle = TextStyle(color: Colors.black, fontSize: 12);
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < data.length; i++) {
      final double x = (i * 2 + 1) * barWidth;

      textPainter.text = TextSpan(text: data[i]['day'], style: textStyle);
      textPainter.layout();
      textPainter.paint(canvas, Offset(x, size.height + 4));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
