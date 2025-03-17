import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/screen/utilisateur/widget/section-article/section-article-ternaire.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/responsive-ui.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SectionActualiteWidget extends StatelessWidget {
  final List<ArticlesModel> articles;
  const SectionActualiteWidget({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    Size size = MediaQuery.of(context).size;
    return Expanded(
      flex: 3,
      child: Column(
        children: [
          Container(
            height: 45,
            color: deviceName(size) == ScreenType.Mobile
                ? rouge.withOpacity(.5)
                : blanc,
            child: Row(
              children: [
                if (deviceName(size) == ScreenType.Mobile)
                  paddingHorizontalGlobal(32),
                Text(
                  'Actualités'.toUpperCase(),
                  style: fontFammilyDii(
                      context,
                      24,
                      deviceName(size) == ScreenType.Mobile ? blanc : noir,
                      FontWeight.bold,
                      FontStyle.normal),
                ),
                const Spacer(),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () async {
                      await homeUtilisateurBloc.setCatMenu(homeUtilisateurBloc
                          .categories
                          .firstWhere((e) => e.titre! == "ACTUALITES"));


                      context.go(
                          '/categorie/actualites');
                      await homeUtilisateurBloc.setCategorieMenu();
                    },
                    child: Text(
                      'voir +'.toUpperCase(),
                      style: fontFammilyDii(
                          context,
                          14,
                          rouge,
                          FontWeight.bold,
                          FontStyle.normal),
                    ),
                  ),
                ),
                if (deviceName(size) == ScreenType.Mobile)
                  paddingHorizontalGlobal(32),
              ],
            ),
          ),
          if (deviceName(size) != ScreenType.Mobile) paddingVerticalGlobal(8),
          Expanded(
              child: Container(
            color: rouge.withOpacity(.05),
            child: Row(
              children: [
                paddingHorizontalGlobal(32),
                Expanded(
                  child: Column(
                    children: [
                      paddingVerticalGlobal(8),
                      Expanded(
                          child: Column(
                        children: [
                          paddingVerticalGlobal(),
                          SectionArticleTernaireWidget(
                            articlesModel: articles[0],
                            sizeTags:  13,
                            sizeTitle:  15,
                          ),
                          paddingVerticalGlobal(),
                          SectionArticleTernaireWidget(
                            articlesModel: articles[1],
                            sizeTags: 13,
                            sizeTitle: 15,
                          ),
                          paddingVerticalGlobal(),
                          SectionArticleTernaireWidget(
                            articlesModel: articles[2],
                            sizeTags: 13,
                            sizeTitle: 15,
                          ),
                          paddingVerticalGlobal(),
                          SectionArticleTernaireWidget(
                            articlesModel: articles[3],
                            sizeTags: 13,
                            sizeTitle: 15,
                          ),
                        ],
                      )),
                      paddingVerticalGlobal(32),
                    ],
                  ),
                ),
                paddingHorizontalGlobal(8)
              ],
            ),
          )),
        ],
      ),
    );
  }
}
