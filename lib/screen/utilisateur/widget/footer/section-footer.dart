import 'package:actu/screen/utilisateur/widget/footer/lien-footer.dart';
import 'package:actu/screen/utilisateur/widget/footer/titre-top-footer.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';

class SectionFooter extends StatelessWidget {
  const SectionFooter({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 100,
      width: 1024,
      color: bgFooter,
      child: Row(
        children: [
          Expanded(
              child: Column(
            children: [
              paddingVerticalGlobal(32),
             /* const Row(
                children: [
                  TitreTopFooter(titre: 'Termes et conditions'),
                  TitreTopFooter(titre: 'Règles de la communauté'),
                  TitreTopFooter(titre: 'politique de confidentialité'),
                  TitreTopFooter(
                    titre: 'Clause de non-responsabilité',
                    haveLastBlock: false,
                  ),
                ],
              ),
              paddingVerticalGlobal(),
              Container(
                height: .5,
                color: blanc.withOpacity(.5),
              ),

              paddingVerticalGlobal(32),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Services commerciales',
                              style: fontFammilyDii(
                                  context,
                                  size.width >= 1440
                                      ? 14
                                      : size.width >= 1024 && size.width < 1440
                                          ? 10
                                          : 8,
                                  blanc,
                                  FontWeight.bold,
                                  FontStyle.normal),
                            ),
                          ],
                        ),
                        paddingVerticalGlobal(32),
                        const LienFooterWidget(
                            titre: "Faites de la publicité avec nous"),
                        const LienFooterWidget(
                          titre: "Abonnements de groupe",
                        ),
                        const LienFooterWidget(titre: "Globe Campus"),
                        const LienFooterWidget(
                          titre: "Magasin de données",
                        ),
                        const LienFooterWidget(
                            titre: "Centre d'événements Globe"),
                        const LienFooterWidget(
                          titre: "Institut de leadership",
                        ),
                      ],
                    )),
                    Expanded(
                        child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Contactez-nous',
                              style: fontFammilyDii(
                                  context,
                                  size.width >= 1440
                                      ? 18
                                      : size.width >= 1024 && size.width < 1440
                                          ? 14
                                          : 10,
                                  blanc,
                                  FontWeight.bold,
                                  FontStyle.normal),
                            ),
                          ],
                        ),
                        paddingVerticalGlobal(32),
                        const LienFooterWidget(
                            titre: "Adresse et numéro de téléphone"),
                        const LienFooterWidget(
                          titre: "Rédacteur des normes",
                        ),
                        const LienFooterWidget(titre: "Personnel"),
                        const LienFooterWidget(
                          titre: "Dépôt sécurisé",
                        ),
                        const LienFooterWidget(titre: "Soumettre un article"),
                      ],
                    )),
                    Expanded(
                        child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Services aux lecteurs',
                              style: fontFammilyDii(
                                  context,
                                  size.width >= 1440
                                      ? 18
                                      : size.width >= 1024 && size.width < 1440
                                          ? 14
                                          : 10,
                                  blanc,
                                  FontWeight.bold,
                                  FontStyle.normal),
                            ),
                          ],
                        ),
                        paddingVerticalGlobal(32),
                        const LienFooterWidget(titre: "Paramètres du compte"),
                        const LienFooterWidget(
                          titre: "Assistance technique et FAQ",
                        ),
                        const LienFooterWidget(titre: "Abonnements"),
                        const LienFooterWidget(
                          titre: "Gérer mes préférences de confidentialité",
                        ),
                        const LienFooterWidget(
                            titre: "Gérer mes préférences publicitaires"),
                        const LienFooterWidget(
                          titre: "Avantages pour les membres",
                        ),
                      ],
                    )),
                    Expanded(
                        child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'À propos de nous',
                              style: fontFammilyDii(
                                  context,
                                  size.width >= 1440
                                      ? 18
                                      : size.width >= 1024 && size.width < 1440
                                          ? 14
                                          : 10,
                                  blanc,
                                  FontWeight.bold,
                                  FontStyle.normal),
                            ),
                          ],
                        ),
                        paddingVerticalGlobal(32),
                        const LienFooterWidget(
                            titre: "Informations sur la société"),
                        const LienFooterWidget(
                          titre: "Devenir correspondant",
                        ),
                        const LienFooterWidget(titre: "Accessibilité"),
                        const LienFooterWidget(
                          titre: "Licences et autorisations",
                        ),
                        const LienFooterWidget(
                            titre: "Code de conduite éditorial"),
                      ],
                    )),
                  ],
                ),
              ),
              Container(
                height: .5,
                color: blanc.withOpacity(.5),
              ),


              paddingVerticalGlobal(32),
              Row(
                children: [
                  Image.asset(
                    "assets/images/android-download.png",
                    fit: BoxFit.cover,
                    width: size.width >= 1440
                        ? 120
                        : size.width >= 1024 && size.width < 1440
                            ? 100
                            : 60,
                  ),
                  paddingHorizontalGlobal(4),
                  Image.asset(
                    "assets/images/apple-dowload.png",
                    width: size.width >= 1440
                        ? 120
                        : size.width >= 1024 && size.width < 1440
                            ? 100
                            : 60,
                    fit: BoxFit.cover,
                  ),
                  const Spacer(),
                  Image.asset(
                    "assets/images/twitter.png",
                    color: blanc,
                    width: size.width >= 1440
                        ? 32
                        : size.width >= 1024 && size.width < 1440
                            ? 24
                            : 20,
                  ),
                  paddingHorizontalGlobal(8),
                  Image.asset(
                    "assets/images/linkedin.png",
                    color: blanc,
                    width: size.width >= 1440
                        ? 32
                        : size.width >= 1024 && size.width < 1440
                            ? 24
                            : 20,
                  ),
                  paddingHorizontalGlobal(8),
                  Image.asset(
                    "assets/images/youtube.png",
                    color: blanc,
                    width: size.width >= 1440
                        ? 32
                        : size.width >= 1024 && size.width < 1440
                            ? 24
                            : 20,
                  ),
                  paddingHorizontalGlobal(8),
                  Image.asset(
                    "assets/images/tiktok.png",
                    color: blanc,
                    width: size.width >= 1440
                        ? 32
                        : size.width >= 1024 && size.width < 1440
                            ? 24
                            : 20,
                  ),
                  paddingHorizontalGlobal(8),
                  Image.asset(
                    "assets/images/facebook.png",
                    color: blanc,
                    width: size.width >= 1440
                        ? 32
                        : size.width >= 1024 && size.width < 1440
                            ? 24
                            : 20,
                  ),
                  paddingHorizontalGlobal(8),
                  Image.asset(
                    "assets/images/instagram.png",
                    color: blanc,
                    width: size.width >= 1440
                        ? 32
                        : size.width >= 1024 && size.width < 1440
                            ? 24
                            : 20,
                  ),
                  paddingHorizontalGlobal(8),
                  Image.asset(
                    "assets/images/snap.png",
                    width: size.width >= 1440
                        ? 32
                        : size.width >= 1024 && size.width < 1440
                            ? 24
                            : 20,
                    color: blanc,
                  ),
                ],
              ),


              paddingVerticalGlobal(32),
              Container(
                height: .5,
                color: blanc.withOpacity(.5),
              ),
              paddingVerticalGlobal(32),
              */
              Text(
                "Service commerciale : ",
                style: fontFammilyDii(
                    context,
                    14,
                    blanc,
                    FontWeight.bold,
                    FontStyle.normal),
              ),
              Text(
                "© Copyright 2025 Digital-eyes Tous droits réservés.",
                style: fontFammilyDii(
                    context,
                    14,
                    blanc,
                    FontWeight.bold,
                    FontStyle.normal),
              ),
              paddingVerticalGlobal(32),
            ],
          )),
        ],
      ),
    );
  }
}
