import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/circular-diagram.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String title;
  final int total;
  final double percentage;
  final String label;
  final String desc;
  final double increase;
  final Color color;

  StatCard({
    required this.title,
    required this.total,
    required this.percentage,
    required this.label,
    required this.desc,
    required this.increase,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff1a1a2e),
            Color(0xff16213e),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 20,
            offset: Offset(0, 8),
            spreadRadius: 2,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Icône et titre
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              color.withOpacity(0.3),
                              color.withOpacity(0.2),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          _getIconForTitle(title),
                          color: color,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          title,
                          style: fontFammilyDii(
                            context,
                            14,
                            blanc,
                            FontWeight.w700,
                            FontStyle.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  // Total et augmentation
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        total.toString(),
                        style: fontFammilyDii(
                          context,
                          28,
                          blanc,
                          FontWeight.w900,
                          FontStyle.normal,
                        ),
                      ),
                      SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: increase > 0
                                ? [
                                    Color(0xff10b981).withOpacity(0.2),
                                    Color(0xff059669).withOpacity(0.2),
                                  ]
                                : [
                                    rouge.withOpacity(0.2),
                                    rouge.withOpacity(0.15),
                                  ],
                          ),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: increase > 0
                                ? Color(0xff10b981).withOpacity(0.3)
                                : rouge.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              increase > 0
                                  ? CupertinoIcons.arrow_up_circle_fill
                                  : CupertinoIcons.arrow_down_circle_fill,
                              color: increase > 0
                                  ? Color(0xff10b981)
                                  : rouge,
                              size: 14,
                            ),
                            SizedBox(width: 6),
                            Text(
                              '${increase.abs()}%',
                              style: fontFammilyDii(
                                context,
                                12,
                                increase > 0
                                    ? Color(0xff10b981)
                                    : rouge,
                                FontWeight.w700,
                                FontStyle.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  // Description
                  Text(
                    desc,
                    style: fontFammilyDii(
                      context,
                      11,
                      blanc.withOpacity(.6),
                      FontWeight.w400,
                      FontStyle.normal,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            // Diagramme circulaire
            SizedBox(
              width: 80,
              child: CircularChart(
                percentage: percentage,
                label: label,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForTitle(String title) {
    if (title.contains('Visites') || title.contains('visite')) {
      return CupertinoIcons.eye_fill;
    } else if (title.contains('Journal') || title.contains('Papier')) {
      return CupertinoIcons.news_solid;
    } else if (title.contains('Post') || title.contains('digitaux')) {
      return CupertinoIcons.chart_bar_square_fill;
    }
    return CupertinoIcons.circle_fill;
  }
}
