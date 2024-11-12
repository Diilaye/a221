import 'package:actu/bloc/administrateur/journal-papier-bloc.dart';
import 'package:actu/bloc/administrateur/menu-admin.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/presse-ecrite/add-presse-ecrite-MOBILE.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/presse-ecrite/add-presse-ecrite.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/presse-ecrite/update-presse-ecrite-mobile.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/presse-ecrite/update-presse-ecrite.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/diallog-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PresseEcriteScreenMobile extends StatelessWidget {
  const PresseEcriteScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final menuAdminBloc = Provider.of<MenuAdminBloc>(context);
    final jourPapierBloc = Provider.of<JourPapierBloc>(context);

    return Stack(
      children: [
        ListView(
          children: [
            paddingVerticalGlobal(size.height * .02),
            Row(
              children: [
                paddingHorizontalGlobal(),
                Text(
                  'Presse écrite'.toUpperCase(),
                  style: fontFammilyDii(
                      context, 14, noir, FontWeight.bold, FontStyle.normal),
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
                  size: 12,
                ),
                paddingHorizontalGlobal(6),
                Icon(
                  CupertinoIcons.chevron_forward,
                  color: noir.withOpacity(.6),
                  size: 10,
                ),
                paddingHorizontalGlobal(6),
                Text(
                  'Presse écrite',
                  style: fontFammilyDii(context, 10, noir.withOpacity(.6),
                      FontWeight.w300, FontStyle.normal),
                ),
                paddingHorizontalGlobal(6),
                Icon(
                  CupertinoIcons.chevron_forward,
                  color: noir.withOpacity(.6),
                  size: 8,
                ),
                paddingHorizontalGlobal(6),
                Text(
                  'Dashbord',
                  style: fontFammilyDii(
                      context, 8, noir, FontWeight.w300, FontStyle.normal),
                ),
                const Spacer(),
              ],
            ),
            paddingVerticalGlobal(),
            Row(
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: () => menuAdminBloc.setPresseEcrite(1),
                  child: CircleAvatar(
                      backgroundColor: bleuMarine,
                      radius: 12,
                      child: Icon(
                        CupertinoIcons.add,
                        color: blanc,
                        size: 12,
                      )),
                ),
                paddingHorizontalGlobal(),
              ],
            ),
            paddingVerticalGlobal(),
            SizedBox(
                height: 700,
                width: size.width,
                child: GridView.count(
                    crossAxisCount: 1,
                    padding: const EdgeInsets.all(8),
                    children: jourPapierBloc.journalPapiers
                        .map((e) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 2,
                                child: Column(
                                  children: [
                                    paddingVerticalGlobal(6),
                                    Expanded(
                                      flex: 5,
                                      child: Row(
                                        children: [
                                          paddingHorizontalGlobal(6),
                                          Expanded(
                                            child: Image.network(
                                              BASE_URL_ASSET + e.image!.url!,
                                              height: 2000,
                                              width: 2000,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          paddingHorizontalGlobal(6),
                                        ],
                                      ),
                                    ),
                                    paddingVerticalGlobal(4),
                                    Row(
                                      children: [
                                        const Spacer(),
                                        IconButton(
                                            onPressed: () {
                                              jourPapierBloc
                                                  .setPapierJournal(e);
                                              jourPapierBloc.setShowUpdate(1);
                                            },
                                            tooltip: "Modifier posts",
                                            icon:
                                                const Icon(CupertinoIcons.pen)),
                                        paddingHorizontalGlobal(6),
                                        IconButton(
                                            onPressed: () async =>
                                                dialogRequest(
                                                        title:
                                                            'Vous êtes sur de vouloir suprimer ce posts',
                                                        context: context)
                                                    .then((value) async {
                                                  if (value) {
                                                    jourPapierBloc
                                                        .setPapierJournal(e);
                                                    jourPapierBloc
                                                        .activeJournalPapier();
                                                  }
                                                }),
                                            tooltip: e.statusOnline! == "on"
                                                ? "Suprimer posts"
                                                : "Réintégrer posts",
                                            icon: Icon(e.statusOnline! == "on"
                                                ? CupertinoIcons.delete
                                                : Icons.publish)),
                                        paddingHorizontalGlobal(8),
                                      ],
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          paddingVerticalGlobal(8),
                                          Row(
                                            children: [
                                              paddingHorizontalGlobal(6),
                                              Expanded(
                                                child: Text(
                                                  '12/06/20024',
                                                  overflow: TextOverflow.clip,
                                                  style: fontFammilyDii(
                                                      context,
                                                      12,
                                                      noir,
                                                      FontWeight.w300,
                                                      FontStyle.normal),
                                                ),
                                              ),
                                              const Spacer(),
                                              Icon(
                                                CupertinoIcons.square_fill,
                                                color: e.statusOnline! == "on"
                                                    ? vert
                                                    : rouge,
                                                size: 12,
                                              ),
                                              paddingHorizontalGlobal(4),
                                              Text(
                                                e.statusOnline! == "on"
                                                    ? 'En ligne'
                                                    : "Brouillons",
                                                overflow: TextOverflow.clip,
                                                style: fontFammilyDii(
                                                    context,
                                                    12,
                                                    noir,
                                                    FontWeight.w800,
                                                    FontStyle.normal),
                                              ),
                                              paddingHorizontalGlobal(6),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        .toList())),
            paddingVerticalGlobal(),
            Row(
              children: [
                paddingHorizontalGlobal(8),
                Text(
                  "Affichage de 1 à 10 sur 50 papier journal",
                  style: fontFammilyDii(context, 10, noir.withOpacity(.7),
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
                      width: 30,
                      child: Center(
                          child: Icon(
                        CupertinoIcons.chevron_left,
                        size: 10,
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
                      width: 30,
                      child: Center(
                          child: Icon(
                        CupertinoIcons.chevron_right,
                        size: 10,
                        color: noir,
                      ))),
                ),
                paddingHorizontalGlobal(),
              ],
            )
          ],
        ),
        if (menuAdminBloc.addPresseEcrite == 1)
          Positioned(
              top: 0,
              right: 0,
              child: SizedBox(
                width: size.width,
                height: size.height,
                child: const AddPresseEcriteScreenMobile(),
              )),
        if (jourPapierBloc.showUpdate == 1)
          Positioned(
              top: 0,
              right: 0,
              child: SizedBox(
                width: size.width,
                height: size.height,
                child: const UpdatePresseEcriteScreenMobile(),
              )),
      ],
    );
  }
}
