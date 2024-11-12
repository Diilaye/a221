import 'package:actu/bloc/administrateur/journal-papier-bloc.dart';
import 'package:actu/bloc/administrateur/menu-admin.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPresseEcriteScreenMobile extends StatefulWidget {
  const AddPresseEcriteScreenMobile({super.key});

  @override
  State<AddPresseEcriteScreenMobile> createState() =>
      _AddPresseEcriteScreenMobileState();
}

class _AddPresseEcriteScreenMobileState
    extends State<AddPresseEcriteScreenMobile> {
  ///[customToolBarList] pass the custom toolbarList to show only selected styles in the editor

  @override
  Widget build(BuildContext context) {
    final jourPapierBloc = Provider.of<JourPapierBloc>(context);
    final menuAdminBloc = Provider.of<MenuAdminBloc>(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: jourPapierBloc.parcourirFile == 0
          ? ListView(
              children: [
                paddingVerticalGlobal(),
                Row(
                  children: [
                    paddingHorizontalGlobal(8),
                    Text(
                      'Ajouter Presse écrite'.toUpperCase(),
                      style: fontFammilyDii(context, 14, rouge, FontWeight.bold,
                          FontStyle.normal),
                    )
                  ],
                ),
                paddingVerticalGlobal(),
                Row(
                  children: [
                    paddingHorizontalGlobal(8),
                    jourPapierBloc.imageJournal[0] == null
                        ? Expanded(
                            child: GestureDetector(
                                onTap: () => jourPapierBloc.setParcourirFile(1),
                                child: jourPapierBloc.imageJournal[0] == null
                                    ? jourPapierBloc.fileModel == null
                                        ? Container(
                                            height: 240,
                                            decoration: BoxDecoration(
                                                color:
                                                    bleuMarine.withOpacity(.5),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Center(
                                              child: Text(
                                                "Parcourir dans les fichier",
                                                style: fontFammilyDii(
                                                    context,
                                                    10,
                                                    blanc,
                                                    FontWeight.w600,
                                                    FontStyle.normal),
                                              ),
                                            ),
                                          )
                                        : Container(
                                            height: 240,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: blanc,
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        BASE_URL_ASSET +
                                                            jourPapierBloc
                                                                .fileModel!
                                                                .url!)),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color:
                                                          noir.withOpacity(.3),
                                                      blurRadius: .3)
                                                ]),
                                          )
                                    : Container(
                                        height: 620,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: blanc,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: MemoryImage(
                                                    jourPapierBloc
                                                        .imageJournal[1])),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: noir.withOpacity(.3),
                                                  blurRadius: .3)
                                            ]),
                                      )))
                        : const SizedBox(),
                    paddingHorizontalGlobal(8),
                    jourPapierBloc.fileModel == null
                        ? Expanded(
                            child: GestureDetector(
                                onTap: () => jourPapierBloc.getImageJournal(),
                                child: jourPapierBloc.imageJournal[0] == null
                                    ? Container(
                                        height: 240,
                                        decoration: BoxDecoration(
                                            color: noir.withOpacity(.5),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Center(
                                          child: Text(
                                            "Cliquer pour uploader l'image d'avant garde",
                                            style: fontFammilyDii(
                                                context,
                                                10,
                                                blanc,
                                                FontWeight.w600,
                                                FontStyle.normal),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: 240,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: blanc,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: MemoryImage(
                                                    jourPapierBloc
                                                        .imageJournal[1])),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: noir.withOpacity(.3),
                                                  blurRadius: .3)
                                            ]),
                                      )))
                        : const SizedBox(),
                    paddingHorizontalGlobal(8),
                  ],
                ),
                paddingVerticalGlobal(),
                Row(
                  children: [
                    paddingHorizontalGlobal(8),
                    Expanded(
                        child: GestureDetector(
                      // onTap: () => jourPapierBloc.getFileJournal(),
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                            color: noir.withOpacity(.5),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            jourPapierBloc.fileUrl[0] == null
                                ? "Cliquer pour uploader le fichier"
                                : "Fichier uploadée avec success",
                            style: fontFammilyDii(context, 10, blanc,
                                FontWeight.w600, FontStyle.normal),
                          ),
                        ),
                      ),
                    )),
                    paddingHorizontalGlobal(8),
                  ],
                ),
                paddingVerticalGlobal(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Card(
                      elevation: 2,
                      color: bleuMarine,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: GestureDetector(
                        onTap: () => jourPapierBloc.addJournalPapier(),
                        child: SizedBox(
                          height: 40,
                          child: Row(
                            children: [
                              paddingHorizontalGlobal(6),
                              Text(
                                "Ajouter papier journal",
                                style: fontFammilyDii(context, 10, blanc,
                                    FontWeight.bold, FontStyle.normal),
                              ),
                              paddingHorizontalGlobal(6),
                            ],
                          ),
                        ),
                      ),
                    ),
                    paddingHorizontalGlobal(),
                    GestureDetector(
                      onTap: () => menuAdminBloc.setPresseEcrite(0),
                      child: Card(
                        elevation: 2,
                        color: blanc,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: SizedBox(
                          height: 40,
                          child: Row(
                            children: [
                              paddingHorizontalGlobal(6),
                              Text(
                                "Annuler ",
                                style: fontFammilyDii(context, 10, noir,
                                    FontWeight.bold, FontStyle.normal),
                              ),
                              paddingHorizontalGlobal(6),
                            ],
                          ),
                        ),
                      ),
                    ),
                    paddingHorizontalGlobal()
                  ],
                ),
                paddingVerticalGlobal(64),
              ],
            )
          : Column(
              children: [
                paddingVerticalGlobal(),
                Row(
                  children: [
                    paddingHorizontalGlobal(8),
                    Text(
                      'Rechercher média'.toUpperCase(),
                      style: fontFammilyDii(context, 14, rouge, FontWeight.bold,
                          FontStyle.normal),
                    )
                  ],
                ),
                paddingVerticalGlobal(8),
                Row(
                  children: [
                    paddingHorizontalGlobal(8),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          jourPapierBloc.setRecherche(value);
                        },
                        decoration: const InputDecoration(
                          border: const OutlineInputBorder(),
                          enabledBorder: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    paddingHorizontalGlobal(8),
                  ],
                ),
                paddingVerticalGlobal(),
                Expanded(
                    child: GridView.count(
                  crossAxisCount: 5,
                  childAspectRatio: .8,
                  crossAxisSpacing: 6,
                  children: jourPapierBloc.filesModel.reversed
                      .where((e) => e.url!
                          .split("/")
                          .last
                          .toLowerCase()
                          .contains(jourPapierBloc.recherche.toLowerCase()))
                      .map((e) => GestureDetector(
                            onTap: () => jourPapierBloc.setFileModel(e),
                            child: Container(
                              color: blanc,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    if (e == jourPapierBloc.fileModel)
                                      SizedBox(
                                        height: 20,
                                        child: Row(
                                          children: [
                                            const Spacer(),
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: vertSport,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                            )
                                          ],
                                        ),
                                      ),
                                    Expanded(
                                      child: CachedNetworkImage(
                                        imageUrl: BASE_URL_ASSET + e.url!,
                                        placeholder: (context, url) => Center(
                                            child:
                                                const CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                    Container(
                                      height: 20,
                                      child: Center(
                                        child: Text(e.url!
                                            .split("/")
                                            .last
                                            .split(".")[e.url!
                                                .split("/")
                                                .last
                                                .split(".")
                                                .length -
                                            2]),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                )),
                paddingVerticalGlobal(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Card(
                      elevation: 2,
                      color: bleuMarine,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: GestureDetector(
                        onTap: jourPapierBloc.fileModel != null
                            ? () => jourPapierBloc.setParcourirFile(0)
                            : null,
                        child: SizedBox(
                          height: 40,
                          child: Row(
                            children: [
                              paddingHorizontalGlobal(6),
                              jourPapierBloc.chargement
                                  ? CircularProgressIndicator(
                                      backgroundColor: blanc,
                                      color: bleuMarine,
                                    )
                                  : Text(
                                      "Selectionner le média",
                                      style: fontFammilyDii(context, 10, blanc,
                                          FontWeight.bold, FontStyle.normal),
                                    ),
                              paddingHorizontalGlobal(6),
                            ],
                          ),
                        ),
                      ),
                    ),
                    paddingHorizontalGlobal(),
                    GestureDetector(
                      onTap: () {
                        jourPapierBloc.setFileModel(null);
                        jourPapierBloc.setParcourirFile(0);
                      },
                      child: Card(
                        elevation: 2,
                        color: blanc,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: SizedBox(
                          height: 40,
                          child: Row(
                            children: [
                              paddingHorizontalGlobal(6),
                              Text(
                                "Annuler",
                                style: fontFammilyDii(context, 10, noir,
                                    FontWeight.bold, FontStyle.normal),
                              ),
                              paddingHorizontalGlobal(6),
                            ],
                          ),
                        ),
                      ),
                    ),
                    paddingHorizontalGlobal()
                  ],
                ),
                paddingVerticalGlobal(),
              ],
            ),
    );
  }
}
