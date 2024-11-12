import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/screen/utilisateur/widget/la-une-article.dart';
import 'package:actu/screen/utilisateur/widget/la-une-top-article.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/date-showing-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionUneWidget extends StatelessWidget {
  const SectionUneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return Center(
      child: SizedBox(
        height: 500,
        width: size.width * .8,
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Column(
                    children: [
                      paddingVerticalGlobal(4),
                      homeUtilisateurBloc.uneArticle == null
                          ? SizedBox()
                          : LaUneTopArticle(),
                      paddingVerticalGlobal(8),
                      SizedBox(
                        height: 5,
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                              color: homeUtilisateurBloc.uneTop == 0
                                  ? rouge
                                  : noir.withOpacity(.3),
                            )),
                            Expanded(
                                child: Container(
                              color: homeUtilisateurBloc.uneTop == 1
                                  ? rouge
                                  : noir.withOpacity(.3),
                            )),
                            Expanded(
                                child: Container(
                              color: homeUtilisateurBloc.uneTop == 2
                                  ? rouge
                                  : noir.withOpacity(.3),
                            )),
                            Expanded(
                                child: Container(
                              color: homeUtilisateurBloc.uneTop == 3
                                  ? rouge
                                  : noir.withOpacity(.3),
                            )),
                            Expanded(
                                child: Container(
                              color: homeUtilisateurBloc.uneTop == 4
                                  ? rouge
                                  : noir.withOpacity(.3),
                            )),
                          ],
                        ),
                      ),
                      paddingVerticalGlobal(8),
                    ],
                  ),
                )),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Column(
                    children: homeUtilisateurBloc.articleUnes.map((e) {
                      return LaUneArticle(
                        rubrique: e.categorie!.titre!,
                        date: showDate(e.date!),
                        titre: e.titre!,
                        color: hexToColor(e.categorie!.bgColor!),
                        isActif: homeUtilisateurBloc.uneTop ==
                            homeUtilisateurBloc.articleUnes.indexOf(e),
                        i: homeUtilisateurBloc.articleUnes.indexOf(e),
                      );
                    }).toList(),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
