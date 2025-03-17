import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/categorie-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/responsive-ui.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ItemRubriqueMenu extends StatelessWidget {
  final String title;
  final int i;
  final Color color;
  final Color colorText;
  final bool isInvest;
  final CategorieModel cat;
  const ItemRubriqueMenu(
      {super.key,
      required this.title,
      required this.cat,
      required this.i,
      this.color = Colors.white,
      this.colorText = Colors.white,
      this.isInvest = false});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    Size size = MediaQuery.of(context).size;

    return deviceName(size) == ScreenType.Mobile
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: isInvest ? 0.0 : 8.0),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () async {
                  await homeUtilisateurBloc.setCatMenu(
                      homeUtilisateurBloc.categories.firstWhere((e) =>
                          e.titre!.toUpperCase() == title.toUpperCase()));

                  // ignore: use_build_context_synchronously
                  context.go(
                      '/categorie/${homeUtilisateurBloc.categories.firstWhere((e) => e.titre!.toUpperCase() == title.toUpperCase()).slug!.toLowerCase().replaceAll("é", "e")}');
                  await homeUtilisateurBloc.setCategorieMenu();
                  },
                child: Container(
                  height: 45,
                  color: color,
                  child: Row(
                    children: [
                      paddingHorizontalGlobal(8),
                      Text(cat.titre!.toUpperCase(),
                          overflow: TextOverflow.clip,
                          style: fontFammilyDii(
                              context,
                              14,
                              isInvest ? colorText : noir,
                              FontWeight.bold,
                              FontStyle.normal)),
                      paddingHorizontalGlobal(8),
                    ],
                  ),
                ),
              ),
            ),
          )
        : MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (event) => homeUtilisateurBloc.setHoverMenu(i),
            onExit: (event) => homeUtilisateurBloc.setHoverMenu(0),
            child: GestureDetector(
              onTap: () async {
                await homeUtilisateurBloc.setCatMenu(
                    homeUtilisateurBloc.categories.firstWhere(
                        (e) => e.titre!.toUpperCase() == title.toUpperCase()));

                // ignore: use_build_context_synchronously
                context.go(
                    '/categorie/${homeUtilisateurBloc.categories.firstWhere((e) => e.titre!.toUpperCase() == title.toUpperCase()).slug!.toLowerCase().replaceAll("é", "e")}');
                await homeUtilisateurBloc.setCategorieMenu();
              },
              child: Row(
                children: [
                  Container(
                    color: isInvest
                        ? color
                        : homeUtilisateurBloc.hoverMenuClick == i
                            ? gris
                            : blanc,
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        paddingHorizontalGlobal(size.width >= 1440
                            ? 10
                            : size.width <= 1024 && size.width > 1440
                                ? 4
                                : 4),
                        Text(cat.titre!.toUpperCase(),
                            overflow: TextOverflow.clip,
                            style: fontFammilyDii(
                                context,
                                size.width >= 1440
                                    ? 10
                                    : size.width <= 1024 && size.width > 1440
                                        ? 8
                                        : 8,
                                isInvest
                                    ? colorText
                                    : homeUtilisateurBloc.hoverMenu == i
                                        ? rouge
                                        : noir,
                                FontWeight.bold,
                                FontStyle.normal)),
                        paddingHorizontalGlobal(size.width >= 1440
                            ? 10
                            : size.width <= 1024 && size.width > 1440
                                ? 4
                                : 4),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
