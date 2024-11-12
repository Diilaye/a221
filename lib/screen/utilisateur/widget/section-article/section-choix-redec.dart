import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/screen/utilisateur/widget/section-article/section-article-ternaire.dart';
import 'package:actu/screen/utilisateur/widget/section-article/section-dossier-redaction-widget.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/responsive-ui.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SectionChoixRedacWidget extends StatelessWidget {
  const SectionChoixRedacWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return Container(
      height: 600,
      width: size.width,
      color: gris,
      child: Padding(
        padding: deviceName(size) == ScreenType.Desktop
            ? EdgeInsets.symmetric(horizontal: size.width * .1)
            : EdgeInsets.symmetric(horizontal: size.width * .01),
        child: Column(
          children: [
            paddingVerticalGlobal(),
            Text(
              "à venir".toUpperCase(),
              style: fontFammilyDii(
                  context,
                  deviceName(size) == ScreenType.Desktop
                      ? 24
                      : deviceName(size) == ScreenType.Tablet
                          ? 18
                          : 14,
                  noir,
                  FontWeight.bold,
                  FontStyle.normal),
            ),
            paddingVerticalGlobal(),
            homeUtilisateurBloc.articles.isEmpty
                ? SizedBox()
                : Expanded(
                    child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              SectionArticleTernaireWidget(
                                tagShowRigth: 1,
                                articlesModel:
                                    homeUtilisateurBloc.articleChoixRedac[0],
                                sizeTags: size.width >= 1440 ? 14 : 10,
                                sizeTitle: size.width >= 1440 ? 14 : 12,
                              ),
                              paddingVerticalGlobal(),
                              SectionArticleTernaireWidget(
                                tagShowRigth: 0,
                                articlesModel:
                                    homeUtilisateurBloc.articleChoixRedac[1],
                                sizeTags: size.width >= 1440 ? 14 : 10,
                                sizeTitle: size.width >= 1440 ? 14 : 12,
                              ),
                              paddingVerticalGlobal(),
                              SectionArticleTernaireWidget(
                                tagShowRigth: 0,
                                articlesModel:
                                    homeUtilisateurBloc.articleChoixRedac[2],
                                sizeTags: size.width >= 1440 ? 14 : 10,
                                sizeTitle: size.width >= 1440 ? 14 : 12,
                              ),
                            ],
                          )),
                        ],
                      )),
                      paddingHorizontalGlobal(),
                      Expanded(
                          child: SectionDossierRedactionWidget(
                        articles: homeUtilisateurBloc.uneChoixRedac,
                      )),
                      paddingHorizontalGlobal(),
                      Expanded(
                          child: Column(
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              SectionArticleTernaireWidget(
                                tagShowRigth: 1,
                                showRigth: 1,
                                articlesModel:
                                    homeUtilisateurBloc.articleChoixRedac[3],
                                sizeTags: size.width >= 1440 ? 14 : 10,
                                sizeTitle: size.width >= 1440 ? 14 : 12,
                              ),
                              paddingVerticalGlobal(),
                              SectionArticleTernaireWidget(
                                tagShowRigth: 0,
                                showRigth: 1,
                                articlesModel:
                                    homeUtilisateurBloc.articleChoixRedac[4],
                                sizeTags: size.width >= 1440 ? 14 : 10,
                                sizeTitle: size.width >= 1440 ? 14 : 12,
                              ),
                              paddingVerticalGlobal(),
                              SectionArticleTernaireWidget(
                                tagShowRigth: 0,
                                showRigth: 1,
                                articlesModel:
                                    homeUtilisateurBloc.articleChoixRedac[5],
                                sizeTags: size.width >= 1440 ? 14 : 10,
                                sizeTitle: size.width >= 1440 ? 14 : 12,
                              ),
                            ],
                          )),
                        ],
                      )),
                    ],
                  )),
            paddingVerticalGlobal(),
          ],
        ),
      ),
    );
  }
}
