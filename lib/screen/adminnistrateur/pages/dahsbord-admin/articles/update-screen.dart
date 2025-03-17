import 'package:actu/bloc/administrateur/article-bloc.dart';
import 'package:actu/bloc/administrateur/tags-bloc.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class UpdateArticleScreen extends StatefulWidget {
  const UpdateArticleScreen({super.key});

  @override
  State<UpdateArticleScreen> createState() => _UpdateArticleScreenState();
}

class _UpdateArticleScreenState extends State<UpdateArticleScreen> {
  ///[customToolBarList] pass the custom toolbarList to show only selected styles in the editor

  final customToolBarList = [
    ToolBarStyle.bold,
    ToolBarStyle.italic,
    ToolBarStyle.align,
    ToolBarStyle.color,
    ToolBarStyle.background,
    ToolBarStyle.listBullet,
    ToolBarStyle.listOrdered,
    ToolBarStyle.clean,
    ToolBarStyle.addTable,
    ToolBarStyle.editTable,
  ];

  final _toolbarColor = Colors.grey.shade200;
  final _editorTextStyle = const TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontFamily: 'Roboto');
  final _hintTextStyle = const TextStyle(
      fontSize: 18, color: Colors.black38, fontWeight: FontWeight.normal);

  bool _hasFocus = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final addArticleBloc = Provider.of<AddArticleBloc>(context);
    final tagsBloc = Provider.of<TagsBloc>(context);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: addArticleBloc.parcourirFile == 0
          ? ListView(
              children: [
                paddingVerticalGlobal(),
                Row(
                  children: [
                    paddingHorizontalGlobal(8),
                    Text(
                      'Modifier Article'.toUpperCase(),
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
                      'titre article'.toUpperCase(),
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
                        controller: addArticleBloc.titre,
                        decoration: InputDecoration(
                          hintText: "Ajouter titre  ARTICLE".toUpperCase(),
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
                      'Description article'.toUpperCase(),
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
                      child: ToolBar(
                        toolBarColor: _toolbarColor,
                        padding: const EdgeInsets.all(8),
                        iconSize: 25,
                        iconColor: noir,
                        activeIconColor: rouge,
                        controller: addArticleBloc.controllerProduct,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        direction: Axis.horizontal,
                        customButtons: [
                          Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                                color: _hasFocus ? rouge : Colors.grey,
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          InkWell(
                              // onTap: () => unFocusEditor(),
                              child: const Icon(
                            Icons.favorite,
                            color: Colors.black,
                          )),
                          InkWell(
                              onTap: () async {
                                var selectedText = await addArticleBloc
                                    .controllerProduct
                                    .getSelectedText();
                                debugPrint('selectedText $selectedText');
                                var selectedHtmlText = await addArticleBloc
                                    .controllerProduct
                                    .getSelectedHtmlText();
                                debugPrint(
                                    'selectedHtmlText $selectedHtmlText');
                              },
                              child: const Icon(
                                Icons.add_circle,
                                color: Colors.black,
                              )),
                        ],
                      ),
                    ),
                    paddingHorizontalGlobal(8),
                  ],
                ),
                SizedBox(
                  height: 300,
                  width: size.width * .8,
                  child: Row(
                    children: [
                      paddingHorizontalGlobal(8),
                      Container(
                        width: size.width * .78,
                        height: 300,
                        decoration: BoxDecoration(
                            border: Border.all(color: noir, width: .5)),
                        child: QuillHtmlEditor(
                          controller: addArticleBloc.controllerProduct,
                          isEnabled: true,
                          minHeight: 300,
                          loadingBuilder: (context) => const SizedBox(),
                          textStyle: _editorTextStyle,
                          hintTextStyle: _hintTextStyle,
                          hintTextAlign: TextAlign.start,
                          padding: const EdgeInsets.only(left: 5, top: 5),
                          hintTextPadding: EdgeInsets.zero,
                          backgroundColor: blanc,
                          onTextChanged: (text) {
                            if (addArticleBloc.updateDesc == 0) {
                              addArticleBloc.controllerProduct.setText(
                                  addArticleBloc.article!.description!);
                              addArticleBloc.setUpdateDesc(1);
                            } else {
                              addArticleBloc.setBody(text);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                paddingVerticalGlobal(8),
                Row(
                  children: [
                    paddingHorizontalGlobal(8),
                    IconButton(
                      onPressed: () => addArticleBloc.setTypeArticle(0),
                      icon: Icon(
                        addArticleBloc.typeArticle == 0
                            ? CupertinoIcons.square_fill
                            : CupertinoIcons.square,
                        color: bleuMarine,
                        size: 16,
                      ),
                    ),
                    paddingHorizontalGlobal(8),
                    Text(
                      'Ne Rien afficher'.toUpperCase(),
                      style: fontFammilyDii(context, 14, noir.withOpacity(.5),
                          FontWeight.w600, FontStyle.normal),
                    )
                  ],
                ),
                paddingVerticalGlobal(8),
                Row(
                  children: [
                    paddingHorizontalGlobal(8),
                    IconButton(
                      onPressed: () => addArticleBloc.setTypeArticle(1),
                      icon: Icon(
                        addArticleBloc.typeArticle == 1
                            ? CupertinoIcons.square_fill
                            : CupertinoIcons.square,
                        color: bleuMarine,
                        size: 16,
                      ),
                    ),
                    paddingHorizontalGlobal(8),
                    Text(
                      'Afficher sur  Top article'.toUpperCase(),
                      style: fontFammilyDii(context, 14, noir.withOpacity(.5),
                          FontWeight.w600, FontStyle.normal),
                    )
                  ],
                ),
                paddingVerticalGlobal(8),
                Row(
                  children: [
                    paddingHorizontalGlobal(8),
                    IconButton(
                      onPressed: () => addArticleBloc.setTypeArticle(2),
                      icon: Icon(
                        addArticleBloc.typeArticle == 2
                            ? CupertinoIcons.square_fill
                            : CupertinoIcons.square,
                        color: bleuMarine,
                        size: 16,
                      ),
                    ),
                    paddingHorizontalGlobal(8),
                    Text(
                      'Afficher à la une'.toUpperCase(),
                      style: fontFammilyDii(context, 14, noir.withOpacity(.5),
                          FontWeight.w600, FontStyle.normal),
                    )
                  ],
                ),
                paddingVerticalGlobal(8),
                Row(
                  children: [
                    paddingHorizontalGlobal(8),
                    IconButton(
                      onPressed: () => addArticleBloc.setTypeArticle(3),
                      icon: Icon(
                        addArticleBloc.typeArticle == 3
                            ? CupertinoIcons.square_fill
                            : CupertinoIcons.square,
                        color: bleuMarine,
                        size: 16,
                      ),
                    ),
                    paddingHorizontalGlobal(8),
                    Text(
                      'Afficher sur  la une de son rubrique'.toUpperCase(),
                      style: fontFammilyDii(context, 14, noir.withOpacity(.5),
                          FontWeight.w600, FontStyle.normal),
                    )
                  ],
                ),
                paddingVerticalGlobal(),
                Row(
                  children: [
                    paddingHorizontalGlobal(8),
                    Text(
                      'Selectionnez une catégories'.toUpperCase(),
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
                        child: DropdownButton(
                            value: addArticleBloc.categorie,
                            iconSize: .0,
                            icon: const SizedBox(),
                            items: addArticleBloc.categories
                                .map((e) => DropdownMenuItem(
                                    value: e, child: Text(e.titre!)))
                                .toList(),
                            onChanged: (cat) {
                              addArticleBloc.setCategorie(cat);
                            })),
                  ],
                ),
                paddingVerticalGlobal(),
                Row(
                  children: [
                    paddingHorizontalGlobal(8),
                    Text(
                      'Selectionnez un tag'.toUpperCase(),
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
                        child: DropdownSearch<String>(
                          popupProps: PopupProps.menu(
                            showSearchBox: true,
                            searchFieldProps: TextFieldProps(
                                decoration: InputDecoration(
                                    labelText: 'Recherche',
                                    enabledBorder: OutlineInputBorder(),
                                    disabledBorder: OutlineInputBorder(),
                                    border: OutlineInputBorder())),
                            showSelectedItems: true,
                          ),
                          items: tagsBloc.tags.map((e) => e.titre!).toList(),
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: 'Selectionnez un tag'.toUpperCase(),
                            ),
                          ),
                          onChanged: (v) {
                            addArticleBloc.setTags(tagsBloc.tags.firstWhere(
                                    (e) =>
                                e.titre!.toLowerCase() ==
                                    v!.toLowerCase()));
                          },
                          selectedItem: addArticleBloc.tag == null
                              ? ""
                              : addArticleBloc.tag!.titre,
                        )),
                    paddingHorizontalGlobal(16),
                  ],
                ),
                paddingVerticalGlobal(),
                Row(
                  children: [
                    paddingHorizontalGlobal(8),
                    Text(
                      'mots clés'.toUpperCase(),
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
                      child: KeyboardListener(
                          focusNode: addArticleBloc.focusNode,
                          onKeyEvent: (value) {
                            if (value.logicalKey.keyLabel == "Enter" ||
                                value.logicalKey.keyLabel == "Tab") {
                              addArticleBloc.setContainer();
                            }
                          },
                          child: TextField(
                            controller: addArticleBloc.motCles,
                            decoration: InputDecoration(
                              hintText: "Ajouter un  Mots clés".toUpperCase(),
                              border: const OutlineInputBorder(),
                              enabledBorder: const OutlineInputBorder(),
                            ),
                          )),
                    ),
                    paddingHorizontalGlobal(8),
                  ],
                ),
                paddingVerticalGlobal(),
                Row(
                  children: addArticleBloc.keyWorld
                      .map((e) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              height: 45,
                              // width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: rouge),
                              child: Row(
                                children: [
                                  paddingHorizontalGlobal(8),
                                  Text(
                                    e,
                                    style: fontFammilyDii(context, 13, blanc,
                                        FontWeight.w400, FontStyle.normal),
                                  ),
                                  paddingHorizontalGlobal(8),
                                  IconButton(
                                    onPressed: () =>
                                        addArticleBloc.removeContainer(e),
                                    icon: Icon(
                                      Icons.delete,
                                      color: blanc,
                                    ),
                                  ),
                                  paddingHorizontalGlobal(8),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
                paddingVerticalGlobal(),
                Row(
                  children: [
                    paddingHorizontalGlobal(8),
                    Text(
                      'Média Article'.toUpperCase(),
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
                        child: GestureDetector(
                      onTap: () => addArticleBloc.setParcourirFile(1),
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                            color: bleuMarine.withOpacity(.6),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            "Parcourir les fichiers",
                            style: fontFammilyDii(context, 14, blanc,
                                FontWeight.w600, FontStyle.normal),
                          ),
                        ),
                      ),
                    )),
                    paddingHorizontalGlobal(8),
                    Expanded(
                        child: GestureDetector(
                      onTap: () => addArticleBloc.getImageArticleUpdate(),
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                            color: addArticleBloc.imageAticle[0] == null
                                ? noir.withOpacity(.6)
                                : vertSport,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: addArticleBloc.imageAticle[0] == null
                              ? Text(
                                  "Cliquer pour uploader un média",
                                  style: fontFammilyDii(context, 14, blanc,
                                      FontWeight.w600, FontStyle.normal),
                                )
                              : Text(
                                  "Image uploadée avec succes",
                                  style: fontFammilyDii(context, 14, blanc,
                                      FontWeight.w600, FontStyle.normal),
                                ),
                        ),
                      ),
                    )),
                    paddingHorizontalGlobal(8),
                  ],
                ),
                paddingVerticalGlobal(8),
                SizedBox(
                  height: 100,
                  child: Row(
                    children: [
                      paddingHorizontalGlobal(8),
                      Expanded(
                          child: addArticleBloc.fileModel == null
                              ? addArticleBloc.imageAticle[0] == null
                                  ? Container(
                                      decoration: BoxDecoration(
                                          color: noir.withOpacity(.3),
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: Center(
                                        child: Icon(
                                          Icons.image_rounded,
                                          size: 30,
                                          color: blanc,
                                        ),
                                      ),
                                    )
                                  : addArticleBloc.imageAticle[1].runtimeType ==
                                          String
                                      ? Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: blanc,
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      addArticleBloc
                                                          .imageAticle[1])),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: noir.withOpacity(.3),
                                                    blurRadius: .3)
                                              ]),
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: blanc,
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: MemoryImage(
                                                      addArticleBloc
                                                          .imageAticle[1])),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: noir.withOpacity(.3),
                                                    blurRadius: .3)
                                              ]),
                                        )
                              : Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: blanc,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(BASE_URL_ASSET +
                                              addArticleBloc.fileModel!.url!)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: noir.withOpacity(.3),
                                            blurRadius: .3)
                                      ]),
                                )),
                      paddingHorizontalGlobal(),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            color: noir.withOpacity(.3),
                            borderRadius: BorderRadius.circular(4)),
                        child: Center(
                          child: Icon(
                            Icons.image_rounded,
                            size: 30,
                            color: blanc,
                          ),
                        ),
                      )),
                      paddingHorizontalGlobal(),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            color: noir.withOpacity(.3),
                            borderRadius: BorderRadius.circular(4)),
                        child: Center(
                          child: Icon(
                            Icons.image_rounded,
                            size: 30,
                            color: blanc,
                          ),
                        ),
                      )),
                      paddingHorizontalGlobal(),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            color: noir.withOpacity(.3),
                            borderRadius: BorderRadius.circular(4)),
                        child: Center(
                          child: Icon(
                            Icons.image_rounded,
                            size: 30,
                            color: blanc,
                          ),
                        ),
                      )),
                      paddingHorizontalGlobal(),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            color: noir.withOpacity(.3),
                            borderRadius: BorderRadius.circular(4)),
                        child: Center(
                          child: Icon(
                            Icons.image_rounded,
                            size: 30,
                            color: blanc,
                          ),
                        ),
                      )),
                      paddingHorizontalGlobal(8),
                    ],
                  ),
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
                        onTap: () => addArticleBloc.updateArticle(),
                        child: SizedBox(
                          height: 40,
                          child: Row(
                            children: [
                              paddingHorizontalGlobal(6),
                              addArticleBloc.chargement
                                  ? CircularProgressIndicator(
                                      backgroundColor: blanc,
                                      color: bleuMarine,
                                    )
                                  : Text(
                                      "Modifier article",
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
                      onTap: () => addArticleBloc.setShowUpdate(0),
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
                          addArticleBloc.setRechercheFile(value);
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
                  children: addArticleBloc.filesModel.reversed
                      .where((e) => e.url!
                          .split("/")
                          .last
                          .toLowerCase()
                          .contains(addArticleBloc.rechercheFile.toLowerCase()))
                      .map((e) => GestureDetector(
                            onTap: () => addArticleBloc.setFileModel(e),
                            child: Container(
                              color: blanc,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    if (e == addArticleBloc.fileModel)
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
                        onTap: addArticleBloc.fileModel != null
                            ? () {
                                addArticleBloc.setUpdateDesc(0);
                                addArticleBloc.setParcourirFile(0);
                              }
                            : null,
                        child: SizedBox(
                          height: 40,
                          child: Row(
                            children: [
                              paddingHorizontalGlobal(6),
                              addArticleBloc.chargement
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
                        addArticleBloc.setFileModel(null);
                        addArticleBloc.setUpdateDesc(0);
                        addArticleBloc.setParcourirFile(0);
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
