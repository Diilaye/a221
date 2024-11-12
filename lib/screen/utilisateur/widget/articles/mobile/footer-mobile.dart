import 'package:actu/screen/utilisateur/widget/footer/titre-top-footer.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';

class FooterMobile extends StatelessWidget {
  const FooterMobile({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      color: bgFooter,
      child: Row(
        children: [
          paddingHorizontalGlobal(size.width * .1),
          Expanded(
              child: Column(
            children: [
              paddingVerticalGlobal(32),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TitreTopFooter(
                    titre: 'Termes et conditions',
                    haveLastBlock: false,
                  ),
                ],
              ),
              paddingVerticalGlobal(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TitreTopFooter(
                    titre: 'Règles de la communauté',
                    haveLastBlock: false,
                  ),
                ],
              ),
              paddingVerticalGlobal(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TitreTopFooter(
                    titre: 'politique de confidentialité',
                    haveLastBlock: false,
                  ),
                ],
              ),
              paddingVerticalGlobal(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
              paddingVerticalGlobal(),
              Column(
                children: [
                  SizedBox(
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Services commerciales',
                          style: fontFammilyDii(context, 12, blanc,
                              FontWeight.bold, FontStyle.normal),
                        ),
                      ],
                    ),
                  ),
                  paddingVerticalGlobal(),
                  SizedBox(
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Faites de la publicité avec nous',
                          style: fontFammilyDii(context, 12, blanc,
                              FontWeight.bold, FontStyle.normal),
                        ),
                      ],
                    ),
                  ),
                  paddingVerticalGlobal(),
                  SizedBox(
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Abonnements de groupe',
                          style: fontFammilyDii(context, 12, blanc,
                              FontWeight.bold, FontStyle.normal),
                        ),
                      ],
                    ),
                  ),
                  paddingVerticalGlobal(),
                  SizedBox(
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Globe Campus',
                          style: fontFammilyDii(context, 12, blanc,
                              FontWeight.bold, FontStyle.normal),
                        ),
                      ],
                    ),
                  ),
                  paddingVerticalGlobal(),
                  SizedBox(
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Magasin de données',
                          style: fontFammilyDii(context, 12, blanc,
                              FontWeight.bold, FontStyle.normal),
                        ),
                      ],
                    ),
                  ),
                  paddingVerticalGlobal(),
                  SizedBox(
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Centre d'événements Globe",
                          style: fontFammilyDii(context, 12, blanc,
                              FontWeight.bold, FontStyle.normal),
                        ),
                      ],
                    ),
                  ),
                  paddingVerticalGlobal(),
                  SizedBox(
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Institut de leadership",
                          style: fontFammilyDii(context, 12, blanc,
                              FontWeight.bold, FontStyle.normal),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              paddingVerticalGlobal(),
              Container(
                height: .5,
                color: blanc.withOpacity(.5),
              ),
              paddingVerticalGlobal(),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Contactez-nous',
                        style: fontFammilyDii(context, 12, blanc,
                            FontWeight.bold, FontStyle.normal),
                      ),
                    ],
                  ),
                  paddingVerticalGlobal(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Adresse et numéro de téléphone",
                        style: fontFammilyDii(context, 12, blanc,
                            FontWeight.bold, FontStyle.normal),
                      ),
                    ],
                  ),
                  paddingVerticalGlobal(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Rédacteur des normes",
                        style: fontFammilyDii(context, 12, blanc,
                            FontWeight.bold, FontStyle.normal),
                      ),
                    ],
                  ),
                  paddingVerticalGlobal(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Personnel",
                        style: fontFammilyDii(context, 12, blanc,
                            FontWeight.bold, FontStyle.normal),
                      ),
                    ],
                  ),
                  paddingVerticalGlobal(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Dépôt sécurisé",
                        style: fontFammilyDii(context, 12, blanc,
                            FontWeight.bold, FontStyle.normal),
                      ),
                    ],
                  ),
                  paddingVerticalGlobal(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Soumettre un article",
                        style: fontFammilyDii(context, 12, blanc,
                            FontWeight.bold, FontStyle.normal),
                      ),
                    ],
                  ),
                ],
              ),
              paddingVerticalGlobal(),
              Container(
                height: .5,
                color: blanc.withOpacity(.5),
              ),
              paddingVerticalGlobal(),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Services aux lecteurs',
                        style: fontFammilyDii(context, 12, blanc,
                            FontWeight.bold, FontStyle.normal),
                      ),
                    ],
                  ),
                  paddingVerticalGlobal(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Paramètres du compte',
                        style: fontFammilyDii(context, 12, blanc,
                            FontWeight.bold, FontStyle.normal),
                      ),
                    ],
                  ),
                  paddingVerticalGlobal(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Assistance technique et FAQ',
                        style: fontFammilyDii(context, 12, blanc,
                            FontWeight.bold, FontStyle.normal),
                      ),
                    ],
                  ),
                  paddingVerticalGlobal(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Abonnements',
                        style: fontFammilyDii(context, 12, blanc,
                            FontWeight.bold, FontStyle.normal),
                      ),
                    ],
                  ),
                  paddingVerticalGlobal(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Gérer mes préférences de confidentialité',
                        style: fontFammilyDii(context, 12, blanc,
                            FontWeight.bold, FontStyle.normal),
                      ),
                    ],
                  ),
                  paddingVerticalGlobal(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Gérer mes préférences publicitaires",
                        style: fontFammilyDii(context, 12, blanc,
                            FontWeight.bold, FontStyle.normal),
                      ),
                    ],
                  ),
                  paddingVerticalGlobal(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Avantages pour les membres",
                        style: fontFammilyDii(context, 12, blanc,
                            FontWeight.bold, FontStyle.normal),
                      ),
                    ],
                  ),
                ],
              ),
              paddingVerticalGlobal(),
              Container(
                height: .5,
                color: blanc.withOpacity(.5),
              ),
              paddingVerticalGlobal(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/android-download.png",
                    fit: BoxFit.cover,
                    width: 120,
                  ),
                  paddingHorizontalGlobal(8),
                  Image.asset(
                    "assets/images/apple-dowload.png",
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              paddingVerticalGlobal(),
              Container(
                height: .5,
                color: blanc.withOpacity(.5),
              ),
              paddingVerticalGlobal(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/twitter.png",
                    color: blanc,
                    width: 28,
                  ),
                  paddingHorizontalGlobal(8),
                  Image.asset(
                    "assets/images/linkedin.png",
                    color: blanc,
                    width: 28,
                  ),
                  paddingHorizontalGlobal(8),
                  Image.asset(
                    "assets/images/youtube.png",
                    color: blanc,
                    width: 28,
                  ),
                  paddingHorizontalGlobal(8),
                  Image.asset(
                    "assets/images/tiktok.png",
                    color: blanc,
                    width: 28,
                  ),
                  paddingHorizontalGlobal(8),
                  Image.asset(
                    "assets/images/facebook.png",
                    color: blanc,
                    width: 28,
                  ),
                  paddingHorizontalGlobal(8),
                  Image.asset(
                    "assets/images/instagram.png",
                    color: blanc,
                    width: 28,
                  ),
                  paddingHorizontalGlobal(8),
                  Image.asset(
                    "assets/images/snap.png",
                    width: 28,
                    color: blanc,
                  ),
                ],
              ),
              paddingVerticalGlobal(),
              Container(
                height: .5,
                color: blanc.withOpacity(.5),
              ),
              paddingVerticalGlobal(),
              Text(
                "© Copyright 2024 Digital-eyes Tous droits réservés. Ngor Almadie villa 220 Dakar, 01234 Moustapha Diakhaté, président et chef de la direction",
                textAlign: TextAlign.center,
                style: fontFammilyDii(
                    context, 12, blanc, FontWeight.bold, FontStyle.normal),
              ),
              paddingVerticalGlobal(32),
            ],
          )),
          paddingHorizontalGlobal(size.width * .1),
        ],
      ),
    );
  }
}
