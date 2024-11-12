import 'package:actu/models/administrateur/journal-papier-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/responsive-ui.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:flutter/cupertino.dart';

class SectionEditionWidget extends StatelessWidget {
  final PapierJournalModel journalModel;
  const SectionEditionWidget({super.key, required this.journalModel});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
        flex: 2,
        child: Column(
          children: [
            Container(
              height: 45,
              // color: noir,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'édition du jour'.toUpperCase(),
                    style: fontFammilyDii(
                        context,
                        deviceName(size) == ScreenType.Desktop
                            ? 24
                            : deviceName(size) == ScreenType.Tablet
                                ? 20
                                : 20,
                        deviceName(size) == ScreenType.Mobile ? blanc : noir,
                        FontWeight.bold,
                        FontStyle.normal),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                // decoration: BoxDecoration(color: rouge.withOpacity(.4)),
                child: Image.network(
                  BASE_URL_ASSET + journalModel.image!.url!,
                  fit: size.width >= 1440
                      ? BoxFit.cover
                      : size.width >= 1024 && size.width < 1440
                          ? BoxFit.fill
                          : BoxFit.contain,
                ),
              ),
            ),
          ],
        ));
  }
}
