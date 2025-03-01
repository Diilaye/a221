import 'package:actu/bloc/utilisateur/flash-news-bloc.dart';
import 'package:actu/models/administrateur/flash-news-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/date-showing-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlashNewsWidget extends StatelessWidget {
  final bool havespace;
  final List<FlashNewsModel> flashNews;
  const FlashNewsWidget(
      {super.key, this.havespace = true, required this.flashNews});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final flashNewsUserBloc = Provider.of<FlashNewsUserBloc>(context);

    return Row(
      children: [


        Icon(
          CupertinoIcons.clock,
          color: blanc,
          size: size.width >= 1440
              ? 10
              : size.width >= 1024 && size.width < 1440
                  ? 8
                  : 6,
        ),
        paddingHorizontalGlobal(4),
        Text(
          showDate(flashNews[flashNewsUserBloc.indexShow].date!),
          style: TextStyle(
              fontSize: size.width >= 1440
                  ? 10
                  : size.width >= 1024 && size.width < 1440
                      ? 8
                      : 6,
              color: blanc,
              fontWeight: FontWeight.w300),
        ),
        paddingHorizontalGlobal(4),
        Container(
          height: 45,
          // width: 150,
          color: rouge,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                flashNews[flashNewsUserBloc.indexShow].type!.toUpperCase(),
                style: TextStyle(
                    color: blanc,
                    fontSize: size.width >= 1440
                        ? 14
                        : size.width >= 1024 && size.width < 1440
                            ? 10
                            : 6,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
        paddingHorizontalGlobal(4),
        Expanded(
            child: Text(
          flashNews[flashNewsUserBloc.indexShow].desc!.toUpperCase(),
          style: TextStyle(
              fontSize: size.width >= 1440
                  ? 14
                  : size.width >= 1024 && size.width < 1440
                      ? 10
                      : 8,
              color: blanc),
        )),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () =>
                flashNewsUserBloc.setIndexShow(flashNewsUserBloc.indexShow - 1),
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(border: Border.all(color: blanc)),
              child: Center(
                child: Icon(
                  CupertinoIcons.chevron_back,
                  color: blanc,
                  size: 12,
                ),
              ),
            ),
          ),
        ),
        paddingHorizontalGlobal(),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () =>
                flashNewsUserBloc.setIndexShow(flashNewsUserBloc.indexShow + 1),
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(border: Border.all(color: blanc)),
              child: Center(
                child: Icon(
                  CupertinoIcons.chevron_forward,
                  color: blanc,
                  size: 12,
                ),
              ),
            ),
          ),
        ),

        paddingHorizontalGlobal(),
      ],
    );
  }
}
