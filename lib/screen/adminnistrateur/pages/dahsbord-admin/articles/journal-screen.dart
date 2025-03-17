import 'package:actu/bloc/administrateur/article-bloc.dart';
import 'package:actu/bloc/administrateur/categorie-bloc.dart';
import 'package:actu/bloc/administrateur/menu-admin.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/articles/add-screen.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/articles/update-screen.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/diallog-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JournalScreen extends StatelessWidget {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final menuAdminBloc = Provider.of<MenuAdminBloc>(context);
    final addArticleBloc = Provider.of<AddArticleBloc>(context);
    final categorieBloc = Provider.of<CategorieBloc>(context);

    return Stack(
      children: [
        if (addArticleBloc.showUpdate == 0)
         addArticleBloc.articlePagination== null? const SizedBox() : ListView(
            children: [
              paddingVerticalGlobal(size.height * .02),
              Row(
                children: [
                  paddingHorizontalGlobal(),
                  Text(
                    'Journal'.toUpperCase(),
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
                    'Journal',
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
              Column(
                children: [
                  Row(
                    children: [
                      paddingHorizontalGlobal(),
                      categorieBloc.categories.isEmpty
                          ? const SizedBox()
                          : Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: SizedBox(
                                height: 30,
                                child: Row(
                                  children: [
                                    paddingHorizontalGlobal(8),
                                    DropdownButton(
                                        items: [
                                          DropdownMenuItem(
                                              value: null,
                                              child: Text('Tous les Categories'
                                                  .toUpperCase())),
                                          ...categorieBloc.categories
                                              .map((e) => DropdownMenuItem(
                                                  value: e,
                                                  child: Text(e.titre!)))
                                              .toList()
                                        ],
                                        value: categorieBloc.categorie,
                                        iconSize: 0.0,
                                        elevation: 1,
                                        focusColor: Colors.transparent,
                                        underline: const SizedBox(),
                                        padding: const EdgeInsets.all(0),
                                        onChanged: (v) {
                                          if(v==null) {
                                            categorieBloc.setCategorie(null);
                                            addArticleBloc.setCategorie(null);
                                            addArticleBloc.allCatPagination(addArticleBloc.page);
                                          }else {
                                            categorieBloc.setCategorie(v);
                                            addArticleBloc.setCategorie(v);
                                            addArticleBloc.allCatPagination(addArticleBloc.page);
                                          }


                                        }),
                                    paddingHorizontalGlobal(8),
                                  ],
                                ),
                              ),
                            ),
                      paddingHorizontalGlobal(),
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: SizedBox(
                          height: 30,
                          child: Row(
                            children: [
                              paddingHorizontalGlobal(8),
                              DropdownButton(
                                  items: [
                                    'all',
                                    'on',
                                    'off',
                                  ]
                                      .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: e == "on"
                                              ? Text("En ligne")
                                              : e == "off"
                                                  ? Text("Broullons")
                                                  : Text("Tous les status")))
                                      .toList(),
                                  value: addArticleBloc.statusNews,
                                  iconSize: 0.0,
                                  elevation: 1,
                                  focusColor: Colors.transparent,
                                  underline: const SizedBox(),
                                  padding: const EdgeInsets.all(0),
                                  onChanged: (v) {
                                    addArticleBloc.setStatusNews(v!);
                                  }),
                              paddingHorizontalGlobal(8),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Center(
                        child: SizedBox(
                          height: 45,
                          width: size.width * .3,
                          child: Row(
                            children: [
                              paddingHorizontalGlobal(8),
                              Expanded(
                                child: TextField(
                                  controller: addArticleBloc.recherche,
                                  decoration: const InputDecoration(
                                    hintText: "RECHERCHER UN ARTICLE",
                                    border: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(),
                                  ),
                                  onChanged: (value) =>
                                      addArticleBloc.setRecherche(value),
                                ),
                              ),
                              paddingHorizontalGlobal(8),
                            ],
                          ),
                        ),
                      ),
                      paddingHorizontalGlobal(),
                      GestureDetector(
                        onTap: () => menuAdminBloc.setAddArticle(1),
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
                              // Expanded(
                              //     child: Row(
                              //   children: [
                              //     Text(
                              //       'Date',
                              //       style: fontFammilyDii(context, 14, noir,
                              //           FontWeight.w500, FontStyle.normal),
                              //     ),
                              //   ],
                              // )),
                              Expanded(
                                  child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Center(
                                          child: Text(
                                        'Catégorie',
                                        style: fontFammilyDii(context, 14, noir,
                                            FontWeight.w500, FontStyle.normal),
                                      )),
                                    ],
                                  ),
                                ],
                              )),
                              Expanded(
                                  flex: 2,
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
                                  children: addArticleBloc.articlePagination!.articles!
                                     .where((e) {
                                        if (addArticleBloc.rechercheT.isEmpty) {
                                          if (categorieBloc.categorie == null) {
                                            if (e.statusOnline! ==
                                                    addArticleBloc.statusNews ||
                                                addArticleBloc.statusNews ==
                                                    'all') {
                                              return true;
                                            } else {
                                              return false;
                                            }
                                          } else {
                                            if (e.statusOnline! ==
                                                    addArticleBloc.statusNews ||
                                                addArticleBloc.statusNews ==
                                                    'all') {
                                              return e.categorie!.id ==
                                                  categorieBloc.categorie!.id!;
                                            } else {
                                              return false;
                                            }
                                          }
                                        } else {
                                          if (categorieBloc.categorie == null) {
                                            if (e.statusOnline! ==
                                                    addArticleBloc.statusNews ||
                                                addArticleBloc.statusNews ==
                                                    'all') {
                                              return e.titre!
                                                  .toLowerCase()
                                                  .contains(addArticleBloc
                                                      .rechercheT
                                                      .toLowerCase());
                                            } else {
                                              return false;
                                            }
                                          } else {
                                            if (e.statusOnline! ==
                                                    addArticleBloc.statusNews ||
                                                addArticleBloc.statusNews ==
                                                    'all') {
                                              return (e.categorie!.id ==
                                                      categorieBloc
                                                          .categorie!.id!) &&
                                                  e.titre!
                                                      .toLowerCase()
                                                      .contains(addArticleBloc
                                                          .rechercheT
                                                          .toLowerCase());
                                            } else {
                                              return false;
                                            }
                                          }
                                        }
                                      })


                                      .map((e) => e==null ? SizedBox(): Container(
                                            height: 50,
                                            color: blanc,
                                          child: Row(
                                            children: [
                                              paddingHorizontalGlobal(8),
                                              Expanded(
                                                  child: Row(children: [
                                                    e.id ==null ? Text("") : Text(
                                                      "#${e.id!.substring(0, 7)}",
                                                      style: fontFammilyDii(
                                                          context,
                                                          12,
                                                          noir,
                                                          FontWeight.w500,
                                                          FontStyle.normal),
                                                    )
                                                  ])),

                                            Expanded(
                                                  child: e.author==null ? Text("") : Row(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor:
                                                        bleuMarine,
                                                        radius: 16,
                                                        child: Center(
                                                          child: e.author!.nom == null ? Text("") :  Text(
                                                            "${e.author!.prenom!.substring(0,1)}${e.author!.nom!.substring(0,1)}",
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
                                                      e.author!.nom==null ? Text(""): Text(
                                                        '${e.author!.prenom!} ${e.author!.nom!}',
                                                        style: fontFammilyDii(
                                                            context,
                                                            12,
                                                            noir,
                                                            FontWeight.w500,
                                                            FontStyle.normal),
                                                      ),


                                                    ],
                                                  )),



                                              Expanded(
                                                  child: Row(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Center(
                                                              child: e.categorie==null? Text("") : Text(
                                                                e.categorie!.titre!,
                                                                style: fontFammilyDii(
                                                                    context,
                                                                    12,
                                                                    noir,
                                                                    FontWeight.w500,
                                                                    FontStyle.normal),
                                                              )),
                                                        ],
                                                      ),
                                                    ],
                                                  )),

                                              Expanded(
                                                  flex: 2,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: e.titre  == null? Text("") : Text(
                                                          e.titre!,
                                                          overflow:
                                                          TextOverflow
                                                              .ellipsis,
                                                          style:
                                                          fontFammilyDii(
                                                              context,
                                                              14,
                                                              noir,
                                                              FontWeight
                                                                  .w500,
                                                              FontStyle
                                                                  .normal),
                                                        ),
                                                      ),
                                                    ],
                                                  )),

                                              Expanded(
                                                  child: Row(
                                                    children: [
                                                      paddingHorizontalGlobal(),
                                                      Icon(
                                                        CupertinoIcons
                                                            .circle_fill,
                                                        size: 10,
                                                        color: e.statusOnline! ==
                                                            "on"
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
                                                          onPressed: () =>
                                                              addArticleBloc
                                                                  .setArticle(
                                                                  e, 1),
                                                          tooltip:
                                                          "Modifier l'article",
                                                          icon: Icon(
                                                              CupertinoIcons
                                                                  .pen)),
                                                      paddingHorizontalGlobal(6),
                                                      IconButton(
                                                          onPressed: () async =>
                                                              dialogRequest(
                                                                  title:
                                                                  'Vous êtes sur de vouloir suprimer cette article',
                                                                  context:
                                                                  context)
                                                                  .then(
                                                                      (value) async {
                                                                    if (value) {
                                                                      addArticleBloc
                                                                          .setArticle(
                                                                          e, 0);
                                                                      addArticleBloc
                                                                          .activeArticle();
                                                                    }
                                                                  }),
                                                          tooltip: e.statusOnline! ==
                                                              "on"
                                                              ? "Suprimer l'article"
                                                              : "Remettre en ligne",
                                                          icon: e.statusOnline! ==
                                                              "on"
                                                              ? Icon(
                                                              CupertinoIcons
                                                                  .delete)
                                                              : Icon(Icons
                                                              .accessibility)),
                                                    ],
                                                  )),
                                              paddingHorizontalGlobal(8),
                                            ],
                                          ) ,
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
                  addArticleBloc.articlePagination!.page ==null ? Text("") :  Row(
                    children: [
                      paddingHorizontalGlobal(8),
                      Text(
                        "Affichage page N° ${addArticleBloc.articlePagination!.page!}".toUpperCase(),
                        style: fontFammilyDii(context, 14, noir.withOpacity(.7),
                            FontWeight.w700, FontStyle.normal),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => addArticleBloc.setPage(addArticleBloc.articlePagination!.page!-1),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
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
                        ),
                      ),
                      paddingHorizontalGlobal(8),
                      GestureDetector(
                        onTap: () => addArticleBloc.setPage(addArticleBloc.articlePagination!.page!+1),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
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
                        ),
                      ),
                      paddingHorizontalGlobal(),
                    ],
                  )
                ],
              )
            ],
          ),
        if (addArticleBloc.showUpdate == 1)
          Positioned(
              child: SizedBox(
            width: size.width * .8,
            height: size.height,
            child: const UpdateArticleScreen(),
          )),
        if (menuAdminBloc.addArticle == 1)
          Positioned(
              top: 0,
              right: 0,
              child: SizedBox(
                width: size.width * .8,
                height: size.height,
                child: AddArticleScreen(),
              )),
      ],
    );
  }
}
