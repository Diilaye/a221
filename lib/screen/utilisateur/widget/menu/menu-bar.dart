import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/categorie-model.dart';
import 'package:actu/screen/utilisateur/widget/menu/item-rubrique.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/responsive-ui.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MenuBarArticle extends StatefulWidget {
  final int home;
  final double top;
  final List<CategorieModel> categories;
  MenuBarArticle(
      {super.key, required this.categories, this.home = -1, this.top = 162});

  @override
  State<MenuBarArticle> createState() => _MenuBarArticleState();
}

class _MenuBarArticleState extends State<MenuBarArticle> {
  List<Widget> getAllCategories(Size size) {
    List<Widget> liste = [];
    for (var i = 0; i < widget.categories.length; i++) {
      if (i == 6) {
        liste.add(const Spacer());
      }

      if (i >= 6) {
        liste.add(ItemRubriqueMenu(
          title: widget.categories[i].titre!,
          i: i + 1,
          color: hexToColor("${widget.categories[i].bgColor}"),
          colorText: hexToColor("${widget.categories[i].color}"),
          isInvest: true,
          cat: widget.categories[i],
        ));
      } else {
        liste.add(Row(
          children: [
            paddingHorizontalGlobal(size.width >= 1440
                ? 40
                : size.width <= 1024 && size.width > 1440
                    ? 20
                    : 12),
            ItemRubriqueMenu(
              title: widget.categories[i].titre!,
              i: i + 1,
              isInvest: false,
              cat: widget.categories[i],
            ),
          ],
        ));
      }
    }
    return liste;
  }

  List<Widget> getAllCategoriesMobile(Size size) {
    List<Widget> liste = [];
    for (var i = 0; i < widget.categories.length; i++) {
      if (i >= 6) {
        liste.add(ItemRubriqueMenu(
          title: widget.categories[i].titre!,
          i: i + 1,
          color: hexToColor("${widget.categories[i].bgColor}"),
          colorText: hexToColor("${widget.categories[i].color}"),
          isInvest: true,
          cat: widget.categories[i],
        ));
      } else {
        liste.add(Row(
          children: [
            paddingHorizontalGlobal(12),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(width: 5, color: blanc),
              )),
              child: Center(
                child: ItemRubriqueMenu(
                  title: widget.categories[i].titre!,
                  i: i + 1,
                  isInvest: false,
                  cat: widget.categories[i],
                ),
              ),
            ),
          ],
        ));
      }
    }
    return liste;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    return deviceName(size) == ScreenType.Mobile
        ? Column(
            children: [
              SizedBox(
                height: 60,
                width: size.width,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  controller: homeUtilisateurBloc.controllerListHomeMobileNav,
                  children: [
                    paddingHorizontalGlobal(8),
                    GestureDetector(
                      onTap: () {
                        context.go('/');
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            border: Border(
                          top: BorderSide(
                              width: 5,
                              color: widget.home == -1 ? bleuMarine : blanc),
                        )),
                        child: Center(
                          child: Icon(
                            CupertinoIcons.house_alt,
                            color: noir,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.go('/recent');
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            border: Border(
                          top: BorderSide(
                              width: 5,
                              color: widget.home == -2 ? bleuMarine : blanc),
                        )),
                        child: Center(
                          child: Icon(
                            CupertinoIcons.clock,
                            color: noir,
                          ),
                        ),
                      ),
                    ),
                    ...getAllCategoriesMobile(size)
                  ],
                ),
              ),
              SizedBox(
                height: 10,
                width: size.width,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    homeUtilisateurBloc.mobileNavPadd > 200
                        ? paddingHorizontalGlobal(
                            homeUtilisateurBloc.mobileNavPadd +
                                (size.width - 400))
                        : paddingHorizontalGlobal(
                            (homeUtilisateurBloc.mobileNavPadd)),
                    if (homeUtilisateurBloc.mobileNavPadd > 8)
                      Container(
                        height: 6,
                        width: 150,
                        decoration: BoxDecoration(
                            color: rouge,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                  ],
                ),
              )
            ],
          )
        : Positioned(
            top: widget.top,
            left: size.width * .1,
            right: size.width * .1,
            child: Column(
              children: [
                paddingHorizontalGlobal(),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                      color: blanc,
                      boxShadow: [BoxShadow(color: noir, blurRadius: .5)]),
                  child: Row(
                    children: [
                      paddingHorizontalGlobal(),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        onEnter: (event) => homeUtilisateurBloc.setHoverMenu(9),
                        onExit: (event) => homeUtilisateurBloc.setHoverMenu(0),
                        child: GestureDetector(
                          onTap: () {
                            homeUtilisateurBloc.setHoverMenuClick(0, null);
                            context.go("/");
                          },
                          child: Icon(
                            CupertinoIcons.home,
                            size: 20,
                            color: homeUtilisateurBloc.hoverMenu == 9
                                ? rouge
                                : noir,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: getAllCategories(size),
                        ),
                      ),
                      paddingHorizontalGlobal(16),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        onEnter: (event) =>
                            homeUtilisateurBloc.setHoverMenu(10),
                        onExit: (event) => homeUtilisateurBloc.setHoverMenu(0),
                        child: Icon(
                          CupertinoIcons.search,
                          size: 20,
                          color: homeUtilisateurBloc.hoverMenu == 10
                              ? rouge
                              : noir,
                        ),
                      ),
                      paddingHorizontalGlobal(),
                    ],
                  ),
                ),
                paddingHorizontalGlobal(),
              ],
            ),
          );
  }
}
