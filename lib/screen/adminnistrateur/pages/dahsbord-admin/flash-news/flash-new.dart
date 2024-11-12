import 'package:actu/bloc/administrateur/flash-news-bloc.dart';
import 'package:actu/bloc/administrateur/menu-admin.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/flash-news/add-flash-news.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/flash-news/update-flash-news.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/diallog-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlashNewsScreen extends StatelessWidget {
  const FlashNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final menuAdminBloc = Provider.of<MenuAdminBloc>(context);
    final flashNewsBloc = Provider.of<FlashNewsBloc>(context);

    return Stack(
      children: [
        ListView(
          children: [
            paddingVerticalGlobal(size.height * .02),
            Row(
              children: [
                paddingHorizontalGlobal(),
                Text(
                  'Flash news'.toUpperCase(),
                  style: fontFammilyDii(
                      context, 20, noir, FontWeight.bold, FontStyle.normal),
                )
              ],
            ),
            paddingVerticalGlobal(size.height * .02),
            Row(
              children: [
                paddingHorizontalGlobal(),
                Icon(
                  CupertinoIcons.home,
                  color: noir.withOpacity(.6),
                  size: 14,
                ),
                paddingHorizontalGlobal(6),
                Icon(
                  CupertinoIcons.chevron_forward,
                  color: noir.withOpacity(.6),
                  size: 12,
                ),
                paddingHorizontalGlobal(6),
                Text(
                  'flash news',
                  style: fontFammilyDii(context, 14, noir.withOpacity(.6),
                      FontWeight.w300, FontStyle.normal),
                ),
                paddingHorizontalGlobal(6),
                Icon(
                  CupertinoIcons.chevron_forward,
                  color: noir.withOpacity(.6),
                  size: 12,
                ),
                paddingHorizontalGlobal(6),
                Text(
                  'Dashbord',
                  style: fontFammilyDii(
                      context, 12, noir, FontWeight.w300, FontStyle.normal),
                ),
                const Spacer(),
                CircleAvatar(
                    backgroundColor: noir.withOpacity(.5),
                    child: Center(child: Icon(CupertinoIcons.printer))),
                paddingHorizontalGlobal(8),
                CircleAvatar(
                    backgroundColor: noir.withOpacity(.5),
                    child: Center(child: Icon(CupertinoIcons.folder_circle))),
                paddingHorizontalGlobal(),
              ],
            ),
            paddingVerticalGlobal(),
            Row(
              children: [
                const Spacer(),
                Center(
                  child: SizedBox(
                    height: 45,
                    width: size.width * .4,
                    child: Row(
                      children: [
                        paddingHorizontalGlobal(8),
                        Expanded(
                          child: TextField(
                            // controller: connectionBloc.email,
                            decoration: InputDecoration(
                              hintText:
                                  "RECHERCHER UN flash news".toUpperCase(),
                              border: const OutlineInputBorder(),
                              enabledBorder: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                        paddingHorizontalGlobal(8),
                      ],
                    ),
                  ),
                ),
                paddingHorizontalGlobal(),
                GestureDetector(
                  onTap: () => menuAdminBloc.setFlashNews(1),
                  child: CircleAvatar(
                      backgroundColor: bleuMarine,
                      child: Icon(
                        CupertinoIcons.add,
                        color: blanc,
                      )),
                ),
                paddingHorizontalGlobal(),
              ],
            ),
            paddingVerticalGlobal(),
            SizedBox(
              height: 700,
              width: size.width,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    paddingVerticalGlobal(8),
                    Row(
                      children: [
                        paddingHorizontalGlobal(8),
                        Expanded(
                            child: Row(children: [
                          Text(
                            'ID',
                            style: fontFammilyDii(context, 14, noir,
                                FontWeight.w500, FontStyle.normal),
                          )
                        ])),
                        Expanded(
                            child: Row(
                          children: [
                            Text(
                              'Author',
                              style: fontFammilyDii(context, 14, noir,
                                  FontWeight.w500, FontStyle.normal),
                            ),
                          ],
                        )),
                        Expanded(
                            child: Row(
                          children: [
                            Text(
                              'Date',
                              style: fontFammilyDii(context, 14, noir,
                                  FontWeight.w500, FontStyle.normal),
                            ),
                          ],
                        )),
                        Expanded(
                            child: Row(
                          children: [
                            Text(
                              'Titre',
                              style: fontFammilyDii(context, 14, noir,
                                  FontWeight.w500, FontStyle.normal),
                            ),
                          ],
                        )),
                        Expanded(
                            child: Row(
                          children: [
                            paddingHorizontalGlobal(),
                            Text(
                              'Status',
                              style: fontFammilyDii(context, 14, noir,
                                  FontWeight.w500, FontStyle.normal),
                            ),
                          ],
                        )),
                        Expanded(
                            child: Row(
                          children: [
                            Text(
                              '...',
                              style: fontFammilyDii(context, 14, noir,
                                  FontWeight.w500, FontStyle.normal),
                            ),
                          ],
                        )),
                        paddingHorizontalGlobal(8),
                      ],
                    ),
                    paddingVerticalGlobal(8),
                    Expanded(
                        child: Row(
                      children: [
                        paddingHorizontalGlobal(8),
                        Expanded(
                          child: ListView(
                            children: flashNewsBloc.flashNews
                                .map((e) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Container(
                                        height: 50,
                                        color: blanc,
                                        child: Row(
                                          children: [
                                            paddingHorizontalGlobal(8),
                                            Expanded(
                                                child: Row(children: [
                                              Text(
                                                "#${e.id!.substring(0, 7)}",
                                                style: fontFammilyDii(
                                                    context,
                                                    14,
                                                    noir,
                                                    FontWeight.w500,
                                                    FontStyle.normal),
                                              )
                                            ])),
                                            Expanded(
                                                child: Row(
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor: bleuMarine,
                                                  radius: 16,
                                                  child: Center(
                                                    child: Text(
                                                      '${e.author!.prenom!.substring(0, 1)}${e.author!.nom!.substring(0, 1)}',
                                                      style: fontFammilyDii(
                                                          context,
                                                          10,
                                                          blanc,
                                                          FontWeight.w500,
                                                          FontStyle.normal),
                                                    ),
                                                  ),
                                                ),
                                                paddingHorizontalGlobal(4),
                                                Text(
                                                  '${e.author!.prenom!} ${e.author!.nom!}',
                                                  style: fontFammilyDii(
                                                      context,
                                                      14,
                                                      noir,
                                                      FontWeight.w500,
                                                      FontStyle.normal),
                                                ),
                                              ],
                                            )),
                                            Expanded(
                                                child: Row(
                                              children: [
                                                Text(
                                                  e.date!
                                                      .split("T")[0]
                                                      .split("-")
                                                      .reversed
                                                      .join('/'),
                                                  style: fontFammilyDii(
                                                      context,
                                                      14,
                                                      noir,
                                                      FontWeight.w500,
                                                      FontStyle.normal),
                                                ),
                                              ],
                                            )),
                                            Expanded(
                                                child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    e.desc!,
                                                    overflow: TextOverflow.clip,
                                                    style: fontFammilyDii(
                                                        context,
                                                        14,
                                                        noir,
                                                        FontWeight.w500,
                                                        FontStyle.normal),
                                                  ),
                                                ),
                                              ],
                                            )),
                                            Expanded(
                                                child: Row(
                                              children: [
                                                paddingHorizontalGlobal(),
                                                Icon(
                                                  CupertinoIcons.circle_fill,
                                                  size: 10,
                                                  color: e.statusOnline! == "on"
                                                      ? vertSport
                                                      : rouge,
                                                ),
                                                paddingHorizontalGlobal(4),
                                                Text(
                                                  e.statusOnline! == "on"
                                                      ? 'En ligne'
                                                      : 'Broullions',
                                                  style: fontFammilyDii(
                                                      context,
                                                      14,
                                                      noir,
                                                      FontWeight.w500,
                                                      FontStyle.normal),
                                                ),
                                              ],
                                            )),
                                            Expanded(
                                                child: Row(
                                              children: [
                                                paddingHorizontalGlobal(6),
                                                IconButton(
                                                    onPressed: () {
                                                      flashNewsBloc
                                                          .setFlashNews(e);
                                                      flashNewsBloc
                                                          .setShowUpdate(1);
                                                    },
                                                    tooltip:
                                                        "Modifier flashs nes",
                                                    icon: Icon(
                                                        CupertinoIcons.pen)),
                                                paddingHorizontalGlobal(6),
                                                IconButton(
                                                    onPressed: () async =>
                                                        dialogRequest(
                                                                title:
                                                                    'Vous êtes sur de vouloir suprimer cette flahs-news',
                                                                context:
                                                                    context)
                                                            .then(
                                                                (value) async {
                                                          if (value) {
                                                            flashNewsBloc
                                                                .setFlashNews(
                                                                    e);
                                                            flashNewsBloc
                                                                .active();
                                                          }
                                                        }),
                                                    tooltip: e.statusOnline! ==
                                                            "on"
                                                        ? "Suprimer flash nes"
                                                        : "Remettre en ligne",
                                                    icon: e.statusOnline! ==
                                                            "on"
                                                        ? Icon(CupertinoIcons
                                                            .delete)
                                                        : Icon(Icons
                                                            .accessibility)),
                                              ],
                                            )),
                                            paddingHorizontalGlobal(8),
                                          ],
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                        paddingHorizontalGlobal(8)
                      ],
                    )),
                    paddingVerticalGlobal(8)
                  ],
                ),
              ),
            ),
            paddingVerticalGlobal(),
            Row(
              children: [
                paddingHorizontalGlobal(8),
                Text(
                  "Affichage de 1 à 10 sur 50 articles",
                  style: fontFammilyDii(context, 14, noir.withOpacity(.7),
                      FontWeight.w700, FontStyle.normal),
                ),
                const Spacer(),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: SizedBox(
                      height: 30,
                      width: 50,
                      child: Center(
                          child: Icon(
                        CupertinoIcons.chevron_left,
                        size: 14,
                        color: noir,
                      ))),
                ),
                paddingHorizontalGlobal(8),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: SizedBox(
                      height: 30,
                      width: 50,
                      child: Center(
                          child: Icon(
                        CupertinoIcons.chevron_right,
                        size: 14,
                        color: noir,
                      ))),
                ),
                paddingHorizontalGlobal(),
              ],
            )
          ],
        ),
        if (menuAdminBloc.addFlashNews == 1)
          Positioned(
              top: 0,
              right: 0,
              child: SizedBox(
                width: size.width * .8,
                height: size.height,
                child: const AddFlashNewsScreen(),
              )),
        if (flashNewsBloc.showUpdate == 1)
          Positioned(
              top: 0,
              right: 0,
              child: SizedBox(
                width: size.width * .8,
                height: size.height,
                child: const UpdateFlashNewsScreen(),
              )),
      ],
    );
  }
}
