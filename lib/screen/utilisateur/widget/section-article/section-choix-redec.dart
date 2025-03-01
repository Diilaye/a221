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

    return Center(
      child: Container(
        height: 600,
        width: 1024,
        color: gris,
        child: Column(
          children: [
            paddingVerticalGlobal(),
            Text(
              "à venir".toUpperCase(),
              style: fontFammilyDii(
                  context,
                   24,
                  noir,
                  FontWeight.bold,
                  FontStyle.normal),
            ),
            paddingVerticalGlobal(),
            homeUtilisateurBloc.articleChoixRedac.isEmpty
                ? SizedBox()
                : Expanded(
                    child: Row(
                    children: [
                      Expanded(
                          child: SectionDossierRedactionWidget(
                            articles: homeUtilisateurBloc.articleChoixRedac[0],
                          )),
                      paddingHorizontalGlobal(),
                      Expanded(
                          child: SectionDossierRedactionWidget(
                        articles: homeUtilisateurBloc.articleChoixRedac[1],
                      )),
                      paddingHorizontalGlobal(),
                      Expanded(
                          child: SectionDossierRedactionWidget(
                            articles: homeUtilisateurBloc.articleChoixRedac[2],
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
