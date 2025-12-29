import 'package:actu/bloc/administrateur/article-bloc.dart';
import 'package:actu/bloc/administrateur/categorie-bloc.dart';
import 'package:actu/bloc/administrateur/menu-admin.dart';
import 'package:actu/bloc/administrateur/tags-bloc.dart';
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
    bool isMobile = size.width < 900;
    final menuAdminBloc = Provider.of<MenuAdminBloc>(context);
    final addArticleBloc = Provider.of<AddArticleBloc>(context);
    final categorieBloc = Provider.of<CategorieBloc>(context);
    final tagsBloc = Provider.of<TagsBloc>(context);

    return Stack(
      children: [
        if (addArticleBloc.showUpdate == 0)
         (addArticleBloc.articlePagination == null || addArticleBloc.articlePagination!.articles == null) ? const SizedBox() : Container(
           decoration: const BoxDecoration(
             gradient: LinearGradient(
               begin: Alignment.topLeft,
               end: Alignment.bottomRight,
               colors: [
                 Color(0xfff8fafc),
                 Color(0xfff1f5f9),
                 Color(0xffe2e8f0),
               ],
             ),
           ),
           child: ListView(
            children: [
              paddingVerticalGlobal(size.height * .02),
              Row(
                children: [
                  paddingHorizontalGlobal(),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF06b6d4),
                          Color(0xFF3b82f6),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF06b6d4).withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      CupertinoIcons.news_solid,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  paddingHorizontalGlobal(),
                  Text(
                    'Journal'.toUpperCase(),
                    style: fontFammilyDii(
                        context, 28, noir, FontWeight.w900, FontStyle.normal),
                  ),
                  paddingHorizontalGlobal(8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF10b981), Color(0xFF059669)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          CupertinoIcons.doc_text_fill,
                          color: Colors.white,
                          size: 14,
                        ),
                        paddingHorizontalGlobal(6),
                        Text(
                          '${addArticleBloc.articlePagination!.articles?.length ?? 0} Articles',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              paddingVerticalGlobal(size.height * .02),
              Container(
                margin: EdgeInsets.symmetric(horizontal: size.width * .02),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white,
                      Color(0xfff8fafc),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF06b6d4).withOpacity(0.2),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Navigation',
                      style: fontFammilyDii(context, 12, noir.withOpacity(.5),
                          FontWeight.w600, FontStyle.normal),
                    ),
                    paddingVerticalGlobal(8),
                    Row(
                    ),
                    Row(
                children: [
                  paddingHorizontalGlobal(),
                  Icon(
                    CupertinoIcons.home,
                    color: const Color(0xFF06b6d4),
                    size: 16,
                  ),
                  paddingHorizontalGlobal(6),
                  Icon(
                    CupertinoIcons.chevron_forward,
                    color: noir.withOpacity(.4),
                    size: 12,
                  ),
                  paddingHorizontalGlobal(6),
                  Text(
                    'Journal',
                    style: fontFammilyDii(context, 14, const Color(0xFF06b6d4),
                        FontWeight.w600, FontStyle.normal),
                  ),
                  paddingHorizontalGlobal(6),
                  Icon(
                    CupertinoIcons.chevron_forward,
                    color: noir.withOpacity(.4),
                    size: 12,
                  ),
                  paddingHorizontalGlobal(6),
                  Text(
                    'Dashboard',
                    style: fontFammilyDii(
                        context, 12, noir.withOpacity(.6), FontWeight.w500, FontStyle.normal),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF06b6d4).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFF06b6d4).withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      CupertinoIcons.printer,
                      color: const Color(0xFF06b6d4),
                      size: 18,
                    ),
                  ),
                  paddingHorizontalGlobal(8),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF8b5cf6).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFF8b5cf6).withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      CupertinoIcons.folder_circle,
                      color: const Color(0xFF8b5cf6),
                      size: 18,
                    ),
                  ),
                  paddingHorizontalGlobal(),
                ],
              ),
                  ],
                ),
              ),
              paddingVerticalGlobal(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: size.width * .02),
                child: Column(
                children: [
                  // Filtres et bouton - Responsive
                  isMobile ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Dropdown catégories
                      if (categorieBloc.categories.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.white, Color(0xfff8fafc)],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFF06b6d4).withOpacity(0.3),
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                CupertinoIcons.square_grid_2x2,
                                color: const Color(0xFF06b6d4),
                                size: 18,
                              ),
                              paddingHorizontalGlobal(8),
                              Expanded(
                                child: DropdownButton<String?>(
                                  isExpanded: true,
                                  items: [
                                    DropdownMenuItem<String?>(
                                      value: null,
                                      child: Text('Tous les Categories'.toUpperCase()),
                                    ),
                                    ...categorieBloc.categories
                                      .map((e) => DropdownMenuItem<String?>(
                                        value: e.id,
                                        child: Text(e.titre!),
                                      ))
                                      .toList()
                                  ],
                                  value: categorieBloc.categorie?.id,
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
                                      final selectedCat = categorieBloc.categories.firstWhere((cat) => cat.id == v);
                                      categorieBloc.setCategorie(selectedCat);
                                      addArticleBloc.setCategorie(selectedCat);
                                      addArticleBloc.allCatPagination(addArticleBloc.page);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      // Dropdown tags
                      Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.white, Color(0xfff8fafc)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF8b5cf6).withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.tag,
                              color: const Color(0xFF8b5cf6),
                              size: 18,
                            ),
                            paddingHorizontalGlobal(8),
                            Expanded(
                              child: DropdownButton<String?>(
                                isExpanded: true,
                                items: [
                                  DropdownMenuItem<String?>(
                                    value: null,
                                    child: Text('Tous les tags'.toUpperCase()),
                                  ),
                                  ...tagsBloc.tags
                                    .map((e) => DropdownMenuItem<String?>(
                                      value: e.id,
                                      child: Text(e.titre!),
                                    ))
                                    .toList()
                                ],
                                value: tagsBloc.tag?.id,
                                iconSize: 0.0,
                                elevation: 1,
                                focusColor: Colors.transparent,
                                underline: const SizedBox(),
                                padding: const EdgeInsets.all(0),
                                onChanged: (v) {
                                  // Tags selection handler
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Bouton ajouter
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            addArticleBloc.resetAddArticleForm();
                            menuAdminBloc.setAddArticle(1);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF10b981),
                                  Color(0xFF059669),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF10b981).withOpacity(0.4),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  CupertinoIcons.add,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                paddingHorizontalGlobal(8),
                                Text(
                                  'NOUVEL ARTICLE',
                                  style: fontFammilyDii(
                                    context,
                                    13,
                                    Colors.white,
                                    FontWeight.bold,
                                    FontStyle.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ) : Row(
                    children: [
                      categorieBloc.categories.isEmpty
                          ? const SizedBox()
                          : Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Colors.white, Color(0xfff8fafc)],
                                ),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFF06b6d4).withOpacity(0.3),
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF06b6d4).withOpacity(0.1),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.square_grid_2x2,
                                    color: const Color(0xFF06b6d4),
                                    size: 18,
                                  ),
                                  paddingHorizontalGlobal(8),
                                  DropdownButton<String?>(
                                        items: [
                                          DropdownMenuItem<String?>(
                                              value: null,
                                              child: Text('Tous les Categories'
                                                  .toUpperCase())),
                                          ...categorieBloc.categories
                                              .map((e) => DropdownMenuItem<String?>(
                                                  value: e.id,
                                                  child: Text(e.titre!)))
                                              .toList()
                                        ],
                                        value: categorieBloc.categorie?.id,
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
                                            final selectedCat = categorieBloc.categories.firstWhere((cat) => cat.id == v);
                                            categorieBloc.setCategorie(selectedCat);
                                            addArticleBloc.setCategorie(selectedCat);
                                            addArticleBloc.allCatPagination(addArticleBloc.page);
                                          }


                                        }),
                                ],
                              ),
                            ),
                      paddingHorizontalGlobal(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.white, Color(0xfff8fafc)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF8b5cf6).withOpacity(0.3),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF8b5cf6).withOpacity(0.1),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.circle_fill,
                              color: const Color(0xFF8b5cf6),
                              size: 12,
                            ),
                            paddingHorizontalGlobal(8),
                            DropdownButton(
                                  items: [
                                    'all',
                                    'publie',
                                    'brouillon',
                                    'archive',
                                  ]
                                      .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: e == "publie"
                                              ? Text("Publiés")
                                              : e == "brouillon"
                                                  ? Text("Brouillons")
                                                  : e == "archive"
                                                      ? Text("Archivés")
                                                      : Text("Tous")))
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
                          ],
                        ),
                      ),
                      const Spacer(),
                      Center(
                        child: Container(
                          height: 48,
                          width: size.width * .3,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFF06b6d4).withOpacity(0.3),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF06b6d4).withOpacity(0.1),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              paddingHorizontalGlobal(12),
                              Icon(
                                CupertinoIcons.search,
                                color: const Color(0xFF06b6d4),
                                size: 20,
                              ),
                              paddingHorizontalGlobal(8),
                              Expanded(
                                child: TextField(
                                  controller: addArticleBloc.recherche,
                                  style: fontFammilyDii(
                                    context,
                                    14,
                                    noir,
                                    FontWeight.w500,
                                    FontStyle.normal,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Rechercher un article...",
                                    hintStyle: fontFammilyDii(
                                      context,
                                      14,
                                      noir.withOpacity(0.4),
                                      FontWeight.w400,
                                      FontStyle.normal,
                                    ),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
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
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                        onTap: () {
                          addArticleBloc.resetAddArticleForm();
                          menuAdminBloc.setAddArticle(1);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF10b981),
                                Color(0xFF059669),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF10b981).withOpacity(0.4),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                CupertinoIcons.add,
                                color: Colors.white,
                                size: 20,
                              ),
                              paddingHorizontalGlobal(8),
                              Text(
                                'NOUVEL ARTICLE',
                                style: fontFammilyDii(
                                  context,
                                  13,
                                  Colors.white,
                                  FontWeight.bold,
                                  FontStyle.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ),
                      paddingHorizontalGlobal(),
                    ],
                  ),
                  paddingVerticalGlobal(),
                 Container(
                    height: 700,
                    width: size.width,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white,
                          Color(0xfff8fafc),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFF06b6d4).withOpacity(0.2),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Card(
                      elevation: 0,
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          paddingVerticalGlobal(12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0xFF06b6d4).withOpacity(0.1),
                                  const Color(0xFF3b82f6).withOpacity(0.1),
                                ],
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                            ),
                            child: isMobile ? Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Articles',
                                    style: fontFammilyDii(context, 13, const Color(0xFF06b6d4),
                                        FontWeight.w700, FontStyle.normal),
                                  ),
                                ),
                              ],
                            ) : Row(
                            children: [
                              paddingHorizontalGlobal(8),
                              Expanded(
                                  child: Row(children: [
                                Text(
                                  'ID',
                                  style: fontFammilyDii(context, 13, const Color(0xFF06b6d4),
                                      FontWeight.w700, FontStyle.normal),
                                )
                              ])),
                              Expanded(
                                  child: Row(
                                children: [
                                  Text(
                                    'Auteur',
                                    style: fontFammilyDii(context, 13, const Color(0xFF06b6d4),
                                        FontWeight.w700, FontStyle.normal),
                                  ),
                                ],
                              )),
                              Expanded(
                                  child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Center(
                                          child: Text(
                                        'Catégorie',
                                        style: fontFammilyDii(context, 13, const Color(0xFF06b6d4),
                                            FontWeight.w700, FontStyle.normal),
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
                                        style: fontFammilyDii(context, 13, const Color(0xFF06b6d4),
                                            FontWeight.w700, FontStyle.normal),
                                      ),
                                    ],
                                  )),
                              Expanded(
                                  child: Row(
                                children: [
                                  Text(
                                    'Status',
                                    style: fontFammilyDii(context, 13, const Color(0xFF06b6d4),
                                        FontWeight.w700, FontStyle.normal),
                                  ),
                                ],
                              )),
                              Expanded(
                                  child: Row(
                                children: [
                                  Text(
                                    'Actions',
                                    style: fontFammilyDii(context, 13, const Color(0xFF06b6d4),
                                        FontWeight.w700, FontStyle.normal),
                                  ),
                                ],
                              )),
                              paddingHorizontalGlobal(8),
                            ],
                          ),
                          ),
                          paddingVerticalGlobal(4),
                         Expanded(
                              child: Row(
                            children: [
                              paddingHorizontalGlobal(8),
                              Expanded(
                                child: ListView(
                                  children: (addArticleBloc.articlePagination!.articles ?? [])
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


                                      .map((e) => Container(
                                            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.white,
                                                  Colors.grey.shade50,
                                                ],
                                              ),
                                              borderRadius: BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Colors.grey.shade200,
                                                width: 1,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.02),
                                                  blurRadius: 8,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                borderRadius: BorderRadius.circular(12),
                                                onTap: () {},
                                                child: Container(
                                                  padding: EdgeInsets.all(isMobile ? 16 : 12),
                                          child: isMobile ? Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              // ID et Status
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                                    decoration: BoxDecoration(
                                                      gradient: const LinearGradient(
                                                        colors: [
                                                          Color(0xFF06b6d4),
                                                          Color(0xFF3b82f6),
                                                        ],
                                                      ),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    child: Text(
                                                      e.id == null ? "" : "#${e.id!.substring(0, 7)}",
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 11,
                                                        fontWeight: FontWeight.bold,
                                                        letterSpacing: 0.5,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: e.statusOnline == 'publie'
                                                          ? [const Color(0xFF10b981), const Color(0xFF059669)]
                                                          : e.statusOnline == 'brouillon'
                                                            ? [Colors.orange.shade400, Colors.orange.shade600]
                                                            : [Colors.grey.shade400, Colors.grey.shade600],
                                                      ),
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Icon(
                                                          e.statusOnline == 'publie' 
                                                            ? CupertinoIcons.check_mark_circled
                                                            : e.statusOnline == 'brouillon'
                                                              ? CupertinoIcons.doc_text
                                                              : CupertinoIcons.archivebox,
                                                          color: Colors.white,
                                                          size: 12,
                                                        ),
                                                        const SizedBox(width: 4),
                                                        Text(
                                                          e.statusOnline == 'publie'
                                                            ? 'Publié'
                                                            : e.statusOnline == 'brouillon'
                                                              ? 'Brouillon'
                                                              : 'Archivé',
                                                          style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 11,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 12),
                                              // Titre
                                              Text(
                                                e.titre ?? '',
                                                style: fontFammilyDii(context, 14, noir,
                                                    FontWeight.bold, FontStyle.normal),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 8),
                                              // Auteur et catégorie
                                              Row(
                                                children: [
                                                  if (e.author != null) ...[
                                                    Container(
                                                      padding: const EdgeInsets.all(2),
                                                      decoration: BoxDecoration(
                                                        gradient: const LinearGradient(
                                                          colors: [
                                                            Color(0xFF8b5cf6),
                                                            Color(0xFFa78bfa),
                                                          ],
                                                        ),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: const CircleAvatar(
                                                        radius: 12,
                                                        backgroundColor: Colors.white,
                                                        child: Icon(
                                                          CupertinoIcons.person_fill,
                                                          size: 12,
                                                          color: Color(0xFF8b5cf6),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 6),
                                                    Expanded(
                                                      child: Text(
                                                        '${e.author!.nom} ${e.author!.prenom}',
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Color(0xFF64748b),
                                                        ),
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              if (e.categorie != null)
                                                Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                                  decoration: BoxDecoration(
                                                    color: const Color(0xFFfef3c7),
                                                    borderRadius: BorderRadius.circular(8),
                                                    border: Border.all(
                                                      color: const Color(0xFFfbbf24),
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      const Icon(
                                                        CupertinoIcons.folder,
                                                        size: 12,
                                                        color: Color(0xFFf59e0b),
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        e.categorie!.titre ?? '',
                                                        style: const TextStyle(
                                                          fontSize: 11,
                                                          fontWeight: FontWeight.w600,
                                                          color: Color(0xFFf59e0b),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              const SizedBox(height: 12),
                                              // Actions
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  MouseRegion(
                                                    cursor: SystemMouseCursors.click,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        addArticleBloc.setArticle(e, 1, categorieBloc: categorieBloc, tagsBloc: tagsBloc);
                                                        addArticleBloc.setShowUpdate(1);
                                                      },
                                                      child: Container(
                                                        padding: const EdgeInsets.all(8),
                                                        decoration: BoxDecoration(
                                                          gradient: const LinearGradient(
                                                            colors: [
                                                              Color(0xFF06b6d4),
                                                              Color(0xFF3b82f6),
                                                            ],
                                                          ),
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                        child: const Icon(
                                                          CupertinoIcons.pencil,
                                                          color: Colors.white,
                                                          size: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  MouseRegion(
                                                    cursor: SystemMouseCursors.click,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        dialogRequest(
                                                          context: context,
                                                          title: "Voulez-vous supprimer cet article ?",
                                                        ).then((value) {
                                                          if (value) {
                                                            addArticleBloc.setArticle(e, 0, categorieBloc: categorieBloc, tagsBloc: tagsBloc);
                                                            addArticleBloc.activeArticle();
                                                          }
                                                        });
                                                      },
                                                      child: Container(
                                                        padding: const EdgeInsets.all(8),
                                                        decoration: BoxDecoration(
                                                          gradient: const LinearGradient(
                                                            colors: [
                                                              Color(0xFFef4444),
                                                              Color(0xFFdc2626),
                                                            ],
                                                          ),
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                        child: const Icon(
                                                          CupertinoIcons.delete,
                                                          color: Colors.white,
                                                          size: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ) : Row(
                                            children: [
                                              paddingHorizontalGlobal(8),
                                              Expanded(
                                                  child: Row(children: [
                                                    Container(
                                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                                      decoration: BoxDecoration(
                                                        gradient: const LinearGradient(
                                                          colors: [
                                                            Color(0xFF06b6d4),
                                                            Color(0xFF3b82f6),
                                                          ],
                                                        ),
                                                        borderRadius: BorderRadius.circular(8),
                                                      ),
                                                      child: e.id ==null ? Text("") : Text(
                                                      "#${e.id!.substring(0, 7)}",
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 11,
                                                        fontWeight: FontWeight.bold,
                                                        letterSpacing: 0.5,
                                                      ),
                                                    ),
                                                    )
                                                  ])),

                                            Expanded(
                                                  child: e.author==null ? Text("") : Row(
                                                    children: [
                                                      Container(
                                                        padding: const EdgeInsets.all(2),
                                                        decoration: BoxDecoration(
                                                          gradient: const LinearGradient(
                                                            colors: [
                                                              Color(0xFF8b5cf6),
                                                              Color(0xFFa78bfa),
                                                            ],
                                                          ),
                                                          shape: BoxShape.circle,
                                                        ),
                                                        child: CircleAvatar(
                                                        backgroundColor:
                                                        const Color(0xFF8b5cf6),
                                                        radius: 16,
                                                        child: Center(
                                                          child: e.author!.nom == null ? Text("") :  Text(
                                                            "${e.author!.prenom!.substring(0,1)}${e.author!.nom!.substring(0,1)}",
                                                            style: const TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 11,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      ),

                                                      paddingHorizontalGlobal(8),
                                                      Expanded(
                                                        child: e.author!.nom==null ? Text(""): Text(
                                                        '${e.author!.prenom!} ${e.author!.nom!}',
                                                        overflow: TextOverflow.ellipsis,
                                                        style: fontFammilyDii(
                                                            context,
                                                            12,
                                                            noir,
                                                            FontWeight.w600,
                                                            FontStyle.normal),
                                                      ),
                                                      ),


                                                    ],
                                                  )),



                                              Expanded(
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                                        decoration: BoxDecoration(
                                                          color: const Color(0xFFef4444).withOpacity(0.1),
                                                          borderRadius: BorderRadius.circular(8),
                                                          border: Border.all(
                                                            color: const Color(0xFFef4444).withOpacity(0.3),
                                                            width: 1,
                                                          ),
                                                        ),
                                                        child: Row(
                                                        children: [
                                                          Icon(
                                                            CupertinoIcons.tag_fill,
                                                            size: 12,
                                                            color: const Color(0xFFef4444),
                                                          ),
                                                          paddingHorizontalGlobal(6),
                                                          e.categorie==null? Text("") : Text(
                                                                e.categorie!.titre!,
                                                                style: fontFammilyDii(
                                                                    context,
                                                                    11,
                                                                    const Color(0xFFef4444),
                                                                    FontWeight.w700,
                                                                    FontStyle.normal),
                                                              ),
                                                        ],
                                                      ),
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
                                                          maxLines: 2,
                                                          style:
                                                          fontFammilyDii(
                                                              context,
                                                              13,
                                                              noir,
                                                              FontWeight
                                                                  .w600,
                                                              FontStyle
                                                                  .normal),
                                                        ),
                                                      ),
                                                    ],
                                                  )),

                                              Expanded(
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                                        decoration: BoxDecoration(
                                                          gradient: LinearGradient(
                                                            colors: e.statusOnline! == "on"
                                                              ? [const Color(0xFF10b981), const Color(0xFF059669)]
                                                              : [const Color(0xFFef4444), const Color(0xFFdc2626)],
                                                          ),
                                                          borderRadius: BorderRadius.circular(20),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: (e.statusOnline! == "on"
                                                                ? const Color(0xFF10b981)
                                                                : const Color(0xFFef4444)).withOpacity(0.3),
                                                              blurRadius: 8,
                                                              offset: const Offset(0, 2),
                                                            ),
                                                          ],
                                                        ),
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                      Icon(
                                                        CupertinoIcons
                                                            .circle_fill,
                                                        size: 8,
                                                        color: Colors.white,
                                                      ),
                                                      paddingHorizontalGlobal(6),
                                                      Text(
                                                        e.statusOnline! == "on"
                                                            ? 'En ligne'
                                                            : 'Brouillon',
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 11,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )),

                                              Expanded(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: const Color(0xFF06b6d4).withOpacity(0.1),
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                        child: IconButton(
                                                          onPressed: () =>
                                                              addArticleBloc
                                                                  .setArticle(
                                                                  e, 1,
                                                                  categorieBloc: categorieBloc,
                                                                  tagsBloc: tagsBloc),
                                                          tooltip:
                                                          "Modifier l'article",
                                                          icon: const Icon(
                                                            CupertinoIcons.pen,
                                                            color: Color(0xFF06b6d4),
                                                            size: 18,
                                                          ),
                                                          padding: const EdgeInsets.all(8),
                                                          constraints: const BoxConstraints(),
                                                        ),
                                                      ),
                                                      paddingHorizontalGlobal(8),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: const Color(0xFFef4444).withOpacity(0.1),
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                        child: IconButton(
                                                          onPressed: () async =>
                                                              dialogRequest(
                                                                  title:
                                                                  'Vous êtes sûr de vouloir supprimer cet article ?',
                                                                  context:
                                                                  context)
                                                                  .then(
                                                                      (value) async {
                                                                    if (value) {
                                                                      addArticleBloc
                                                                          .setArticle(
                                                                          e, 0,
                                                                          categorieBloc: categorieBloc,
                                                                          tagsBloc: tagsBloc);
                                                                      addArticleBloc
                                                                          .activeArticle();
                                                                    }
                                                                  }),
                                                          tooltip: e.statusOnline! ==
                                                              "on"
                                                              ? "Supprimer l'article"
                                                              : "Remettre en ligne",
                                                          icon: Icon(
                                                            e.statusOnline! == "on"
                                                              ? CupertinoIcons.delete
                                                              : CupertinoIcons.arrow_up_circle,
                                                            color: const Color(0xFFef4444),
                                                            size: 18,
                                                          ),
                                                          padding: const EdgeInsets.all(8),
                                                          constraints: const BoxConstraints(),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                              paddingHorizontalGlobal(8),
                                            ],
                                          ),
                                                ),
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
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.white, Color(0xfff8fafc)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFF06b6d4).withOpacity(0.2),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: addArticleBloc.articlePagination!.page ==null ? Text("") :  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF06b6d4),
                              Color(0xFF3b82f6),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              CupertinoIcons.doc_text,
                              color: Colors.white,
                              size: 16,
                            ),
                            paddingHorizontalGlobal(8),
                            Text(
                        "Page N° ${addArticleBloc.articlePagination!.page!}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                        onTap: () => addArticleBloc.setPage(addArticleBloc.articlePagination!.page!-1),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white,
                                Colors.grey.shade100,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xFF06b6d4).withOpacity(0.3),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF06b6d4).withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(
                          CupertinoIcons.chevron_left,
                          size: 16,
                          color: Color(0xFF06b6d4),
                        ),
                              paddingHorizontalGlobal(6),
                              Text(
                                'Précédent',
                                style: fontFammilyDii(
                                  context,
                                  13,
                                  const Color(0xFF06b6d4),
                                  FontWeight.w600,
                                  FontStyle.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ),
                      paddingHorizontalGlobal(12),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                        onTap: () => addArticleBloc.setPage(addArticleBloc.articlePagination!.page!+1),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF06b6d4),
                                Color(0xFF3b82f6),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF06b6d4).withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Suivant',
                                style: fontFammilyDii(
                                  context,
                                  13,
                                  Colors.white,
                                  FontWeight.w600,
                                  FontStyle.normal,
                                ),
                              ),
                              paddingHorizontalGlobal(6),
                              const Icon(
                          CupertinoIcons.chevron_right,
                          size: 16,
                          color: Colors.white,
                        ),
                            ],
                          ),
                        ),
                      ),
                      ),
                    ],
                  ),
                  ),
                ],
              ),
              ),
              const SizedBox(height: 24),
            ],
          ),
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
