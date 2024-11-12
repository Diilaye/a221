import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/bar-diagram.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ActivityChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final double maxY;

  ActivityChart({required this.data, required this.maxY});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text("Activités",
                      style: fontFammilyDii(context, 20, noir, FontWeight.bold,
                          FontStyle.normal)),
                ),
              ],
            ),
            paddingVerticalGlobal(8),
            const Expanded(
                child: BarDiagarm(
              maxY: 400,
              data: [
                {'day': 'Mon', 'views': 150, 'comments': 100},
                {'day': 'Tue', 'views': 120, 'comments': 80},
                {'day': 'Wed', 'views': 180, 'comments': 90},
                {'day': 'Thu', 'views': 250, 'comments': 160},
                {'day': 'Fri', 'views': 200, 'comments': 110},
                {'day': 'Sat', 'views': 300, 'comments': 140},
                {'day': 'Sun', 'views': 350, 'comments': 150},
              ],
            ))
          ],
        ),
      ),
    );
  }
}
