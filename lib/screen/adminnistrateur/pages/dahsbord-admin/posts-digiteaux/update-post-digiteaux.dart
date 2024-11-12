import 'package:actu/bloc/administrateur/post-digiteaux-bloc.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdatePostDigiteauxScreen extends StatefulWidget {
  const UpdatePostDigiteauxScreen({super.key});

  @override
  State<UpdatePostDigiteauxScreen> createState() =>
      _UpdatePostDigiteauxScreenState();
}

class _UpdatePostDigiteauxScreenState extends State<UpdatePostDigiteauxScreen> {
  ///[customToolBarList] pass the custom toolbarList to show only selected styles in the editor

  @override
  Widget build(BuildContext context) {
    final postsDigiteauxBloc = Provider.of<PostsDigiteauxBloc>(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: postsDigiteauxBloc.parcourirFile == 0
          ? ListView(
              children: [
                paddingVerticalGlobal(),
                Row(
                  children: [
                    paddingHorizontalGlobal(8),
                    Text(
                      'Modifier Posts Digiteaux'.toUpperCase(),
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
                      'titre posts'.toUpperCase(),
                      style: fontFammilyDii(context, 14, noir.withOpacity(.5),
                          FontWeight.w300, FontStyle.normal),
                    )
                  ],
                ),
                paddingVerticalGlobal(8),
                SizedBox(
                  height: 60,
                  child: Row(
                    children: [
                      paddingHorizontalGlobal(8),
                      Expanded(
                        child: TextField(
                          controller: postsDigiteauxBloc.titre,
                          decoration: InputDecoration(
                            hintText: "Titre post".toUpperCase(),
                            border: const OutlineInputBorder(),
                            enabledBorder: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      paddingHorizontalGlobal(8),
                    ],
                  ),
                ),
                paddingVerticalGlobal(),
                Row(
                  children: [
                    paddingHorizontalGlobal(8),
                    Expanded(
                        child: GestureDetector(
                            onTap: () =>
                                postsDigiteauxBloc.getImagePostUpdate(),
                            child: postsDigiteauxBloc.fileModel == null
                                ? postsDigiteauxBloc.imagePost[0] == null
                                    ? Container(
                                        height: 500,
                                        decoration: BoxDecoration(
                                            color: noir.withOpacity(.5),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Center(
                                          child: Text(
                                            "Cliquer pour uploader le fichier",
                                            style: fontFammilyDii(
                                                context,
                                                14,
                                                blanc,
                                                FontWeight.w600,
                                                FontStyle.normal),
                                          ),
                                        ),
                                      )
                                    : postsDigiteauxBloc
                                                .imagePost[1].runtimeType ==
                                            String
                                        ? Container(
                                            height: 500,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: blanc,
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        postsDigiteauxBloc
                                                            .imagePost[1])),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color:
                                                          noir.withOpacity(.3),
                                                      blurRadius: .3)
                                                ]),
                                          )
                                        : Container(
                                            height: 500,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: blanc,
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: MemoryImage(
                                                        postsDigiteauxBloc
                                                            .imagePost[1])),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color:
                                                          noir.withOpacity(.3),
                                                      blurRadius: .3)
                                                ]),
                                          )
                                : Container(
                                    height: 500,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: blanc,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(BASE_URL_ASSET +
                                                postsDigiteauxBloc
                                                    .fileModel!.url!)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: noir.withOpacity(.3),
                                              blurRadius: .3)
                                        ]),
                                  ))),
                    paddingHorizontalGlobal(8),
                  ],
                ),
                paddingVerticalGlobal(),
                Row(
                  children: [
                    paddingHorizontalGlobal(8),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => postsDigiteauxBloc.setParcourirFile(1),
                        child: Container(
                          height: 80,
                          color: bleuMarine.withOpacity(.5),
                          child: Center(
                            child: Text(
                              postsDigiteauxBloc.fileModel == null
                                  ? "Parcourir dans les fichier"
                                  : "Image uplodé avec succèe",
                              style: fontFammilyDii(context, 14, blanc,
                                  FontWeight.w600, FontStyle.normal),
                            ),
                          ),
                        ),
                      ),
                    ),
                    paddingHorizontalGlobal(8),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => postsDigiteauxBloc.getImagePost(),
                        child: Container(
                          height: 80,
                          color: noir.withOpacity(.5),
                          child: Center(
                            child: Text(
                              "Cliquer pour uploader le fichier",
                              style: fontFammilyDii(context, 14, blanc,
                                  FontWeight.w600, FontStyle.normal),
                            ),
                          ),
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
                      'Type de Posts'.toUpperCase(),
                      style: fontFammilyDii(context, 14, noir.withOpacity(.5),
                          FontWeight.w300, FontStyle.normal),
                    )
                  ],
                ),
                paddingVerticalGlobal(8),
                Row(
                  children: [
                    paddingHorizontalGlobal(8),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => postsDigiteauxBloc.settypePost(0),
                        child: Card(
                          elevation: 4,
                          color: postsDigiteauxBloc.typePost == 0
                              ? bleuMarine
                              : blanc,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2)),
                          child: Container(
                            height: 50,
                            width: 170,
                            child: Center(
                              child: Text(
                                'éssentiel du jour'.toUpperCase(),
                                style: fontFammilyDii(
                                    context,
                                    12,
                                    postsDigiteauxBloc.typePost == 0
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
                        onTap: () => postsDigiteauxBloc.settypePost(1),
                        child: Card(
                          color: postsDigiteauxBloc.typePost == 1
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
                                'posts commerciale'.toUpperCase(),
                                style: fontFammilyDii(
                                    context,
                                    12,
                                    postsDigiteauxBloc.typePost == 1
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
                        onTap: () => postsDigiteauxBloc.updatePost(),
                        child: SizedBox(
                          height: 40,
                          child: Row(
                            children: [
                              paddingHorizontalGlobal(6),
                              postsDigiteauxBloc.chargement
                                  ? CircularProgressIndicator(
                                      backgroundColor: blanc,
                                      color: bleuMarine,
                                    )
                                  : Text(
                                      "Modifier post",
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
                      onTap: () => postsDigiteauxBloc.setShowUpdate(0),
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
                          postsDigiteauxBloc.setRecherche(value);
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
                  children: postsDigiteauxBloc.filesModel.reversed
                      .where((e) => e.url!
                          .split("/")
                          .last
                          .toLowerCase()
                          .contains(postsDigiteauxBloc.recherche.toLowerCase()))
                      .map((e) => GestureDetector(
                            onTap: () => postsDigiteauxBloc.setFileModel(e),
                            child: Container(
                              color: blanc,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    if (e == postsDigiteauxBloc.fileModel)
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
                        onTap: postsDigiteauxBloc.fileModel != null
                            ? () => postsDigiteauxBloc.setParcourirFile(0)
                            : null,
                        child: SizedBox(
                          height: 40,
                          child: Row(
                            children: [
                              paddingHorizontalGlobal(6),
                              postsDigiteauxBloc.chargement
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
                      onTap: () {
                        postsDigiteauxBloc.setFileModel(null);
                        postsDigiteauxBloc.setParcourirFile(0);
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
