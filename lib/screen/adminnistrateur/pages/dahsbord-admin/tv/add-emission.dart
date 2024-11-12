// import 'package:actu/bloc/administrateur/article-bloc.dart';
import 'package:actu/bloc/administrateur/emission-bloc.dart';
import 'package:actu/bloc/administrateur/menu-admin.dart';
import 'package:actu/screen/adminnistrateur/pages/image-screen/image-sccren-ui.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEmissionScreen extends StatefulWidget {
  const AddEmissionScreen({super.key});

  @override
  State<AddEmissionScreen> createState() => _AddEmissionScreenState();
}

class _AddEmissionScreenState extends State<AddEmissionScreen> {
  ///[customToolBarList] pass the custom toolbarList to show only selected styles in the editor

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    final emissionBloc = Provider.of<EmissionBloc>(context);
    final menuAdminBloc = Provider.of<MenuAdminBloc>(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: emissionBloc.parcourirFile == 0
          ? ListView(
              children: [
                paddingVerticalGlobal(),
                Row(
                  children: [
                    paddingHorizontalGlobal(8),
                    Text(
                      'Ajouter Emission'.toUpperCase(),
                      style: fontFammilyDii(context, 18, rouge, FontWeight.bold,
                          FontStyle.normal),
                    )
                  ],
                ),
                paddingVerticalGlobal(),
                Row(
                  children: [
                    paddingHorizontalGlobal(8),
                    Text(
                      'titre émission'.toUpperCase(),
                      style: fontFammilyDii(context, 14, noir.withOpacity(.5),
                          FontWeight.w300, FontStyle.normal),
                    )
                  ],
                ),
                paddingVerticalGlobal(8),
                Row(
                  children: [
                    paddingHorizontalGlobal(8),
                    Expanded(
                      child: TextField(
                        controller: emissionBloc.titre,
                        decoration: InputDecoration(
                          hintText: "Ajouter titre  émission".toUpperCase(),
                          border: const OutlineInputBorder(),
                          enabledBorder: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    paddingHorizontalGlobal(8),
                  ],
                ),
                paddingVerticalGlobal(),
                Row(
                  children: [
                    paddingHorizontalGlobal(8),
                    Text(
                      'Url média'.toUpperCase(),
                      style: fontFammilyDii(context, 14, noir.withOpacity(.5),
                          FontWeight.w300, FontStyle.normal),
                    )
                  ],
                ),
                paddingVerticalGlobal(),
                Row(
                  children: [
                    paddingHorizontalGlobal(8),
                    Expanded(
                      child: TextField(
                        controller: emissionBloc.url,
                        decoration: InputDecoration(
                          hintText: "url média".toUpperCase(),
                          border: const OutlineInputBorder(),
                          enabledBorder: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    paddingHorizontalGlobal(8),
                  ],
                ),
                paddingVerticalGlobal(),
                Row(
                  children: [
                    paddingHorizontalGlobal(8),
                    Text(
                      'Description émission'.toUpperCase(),
                      style: fontFammilyDii(context, 14, noir.withOpacity(.5),
                          FontWeight.w300, FontStyle.normal),
                    )
                  ],
                ),
                paddingVerticalGlobal(),
                Row(
                  children: [
                    paddingHorizontalGlobal(8),
                    Expanded(
                      child: TextField(
                        controller: emissionBloc.desc,
                        decoration: InputDecoration(
                          hintText: "Description émission ".toUpperCase(),
                          border: const OutlineInputBorder(),
                          enabledBorder: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    paddingHorizontalGlobal(8),
                  ],
                ),
                paddingVerticalGlobal(),
                Row(
                  children: [
                    paddingHorizontalGlobal(8),
                    Text(
                      'heure'.toUpperCase(),
                      style: fontFammilyDii(context, 14, noir.withOpacity(.5),
                          FontWeight.w300, FontStyle.normal),
                    )
                  ],
                ),
                paddingVerticalGlobal(),
                Row(
                  children: [
                    paddingHorizontalGlobal(8),
                    Expanded(
                      child: TextField(
                        controller: emissionBloc.heure,
                        decoration: InputDecoration(
                          hintText: "Heure ".toUpperCase(),
                          border: const OutlineInputBorder(),
                          enabledBorder: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    paddingHorizontalGlobal(8),
                  ],
                ),
                paddingVerticalGlobal(),
                Row(
                  children: [
                    paddingHorizontalGlobal(8),
                    Expanded(
                        child: GestureDetector(
                      onTap: () => emissionBloc.setParcourirFile(1),
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                            color: bleuMarine.withOpacity(.5),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            emissionBloc.fileModel == null
                                ? "Parcourir dans les fichier"
                                : "Image selectionnée avec success",
                            style: fontFammilyDii(context, 14, blanc,
                                FontWeight.w600, FontStyle.normal),
                          ),
                        ),
                      ),
                    )),
                    paddingHorizontalGlobal(8),
                    emissionBloc.fileModel == null
                        ? Expanded(
                            child: GestureDetector(
                            onTap: () => emissionBloc.getImagePost(),
                            child: Container(
                              height: 120,
                              decoration: BoxDecoration(
                                  color: noir.withOpacity(.5),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: Text(
                                  emissionBloc.imagePost[0] == null
                                      ? "Cliquer pour uploader le fichier"
                                      : "image uploadée avec success",
                                  style: fontFammilyDii(context, 14, blanc,
                                      FontWeight.w600, FontStyle.normal),
                                ),
                              ),
                            ),
                          ))
                        : const SizedBox(),
                    paddingHorizontalGlobal(8),
                  ],
                ),
                paddingVerticalGlobal(),
                Row(
                  children: [
                    paddingHorizontalGlobal(8),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => emissionBloc.setTypeEmission(0),
                        child: Card(
                          elevation: 4,
                          color: emissionBloc.typeEmission == 0
                              ? bleuMarine
                              : blanc,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2)),
                          child: Container(
                            height: 50,
                            width: 170,
                            child: Center(
                              child: Text(
                                'Invité'.toUpperCase(),
                                style: fontFammilyDii(
                                    context,
                                    12,
                                    emissionBloc.typeEmission == 0
                                        ? blanc
                                        : noir,
                                    FontWeight.bold,
                                    FontStyle.normal),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    paddingHorizontalGlobal(),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => emissionBloc.setTypeEmission(1),
                        child: Card(
                          color: emissionBloc.typeEmission == 1
                              ? bleuMarine
                              : blanc,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2)),
                          child: SizedBox(
                            height: 50,
                            width: 170,
                            child: Center(
                              child: Text(
                                'à suivre'.toUpperCase(),
                                style: fontFammilyDii(
                                    context,
                                    12,
                                    emissionBloc.typeEmission == 1
                                        ? blanc
                                        : noir,
                                    FontWeight.bold,
                                    FontStyle.normal),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
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
                        onTap: () => emissionBloc.addEmission(),
                        child: SizedBox(
                          height: 40,
                          child: Row(
                            children: [
                              paddingHorizontalGlobal(6),
                              emissionBloc.chargement
                                  ? CircularProgressIndicator(
                                      backgroundColor: blanc,
                                      color: bleuMarine,
                                    )
                                  : Text(
                                      "Ajouter émission",
                                      style: fontFammilyDii(context, 14, blanc,
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
                      onTap: () => menuAdminBloc.setEmission(0),
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
                                style: fontFammilyDii(context, 14, noir,
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
            )
          : Column(
              children: [
                paddingVerticalGlobal(),
                Row(
                  children: [
                    paddingHorizontalGlobal(8),
                    Text(
                      'Rechercher média'.toUpperCase(),
                      style: fontFammilyDii(context, 18, rouge, FontWeight.bold,
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
                          emissionBloc.setRecherche(value);
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
                  children: emissionBloc.filesModel.reversed
                      .where((e) => e.url!
                          .split("/")
                          .last
                          .toLowerCase()
                          .contains(emissionBloc.recherche.toLowerCase()))
                      .map((e) => GestureDetector(
                            onTap: () => emissionBloc.setFileModel(e),
                            child: Container(
                              color: blanc,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    if (e == emissionBloc.fileModel)
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
                                          child: const SizedBox(
                                              height: 50,
                                              width: 50,
                                              child:
                                                  CircularProgressIndicator()),
                                        ),
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
                        onTap: emissionBloc.fileModel != null
                            ? () => emissionBloc.setParcourirFile(0)
                            : null,
                        child: SizedBox(
                          height: 40,
                          child: Row(
                            children: [
                              paddingHorizontalGlobal(6),
                              emissionBloc.chargement
                                  ? CircularProgressIndicator(
                                      backgroundColor: blanc,
                                      color: bleuMarine,
                                    )
                                  : Text(
                                      "Selectionner le média",
                                      style: fontFammilyDii(context, 14, blanc,
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
                      onTap: () => emissionBloc.setParcourirFile(0),
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
                                style: fontFammilyDii(context, 14, noir,
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
