import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/date-showing-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:js' as js;

class LaUneTopArticle extends StatefulWidget {
  const LaUneTopArticle({
    super.key,
  });

  @override
  State<LaUneTopArticle> createState() => _LaUneTopArticleState();
}

class _LaUneTopArticleState extends State<LaUneTopArticle> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    Size size = MediaQuery.of(context).size;
    print("homeUtilisateurBloc.uneArticle!.imageArticle!.url!");
    print(homeUtilisateurBloc.uneArticle!.imageArticle!.url!);
    return Expanded(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () async {
            homeUtilisateurBloc.setAticle(homeUtilisateurBloc.uneArticle!);
            js.context.callMethod('open', [
              'https://a221.net/article/${homeUtilisateurBloc.uneArticle!.slug!}',
              '_self'
            ]);
            // context.go('/article/${homeUtilisateurBloc.uneArticle!.slug!}');
          },
          child: Stack(
            children: [
              Container(
                height: 1000,
                width: 1000,
                child: Image.network(
                  height: 1000,
                  width: 1000,
                  BASE_URL_ASSET +
                      homeUtilisateurBloc.uneArticle!.imageArticle!.url!,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      rouge.withOpacity(.1),
                      rouge.withOpacity(.1),
                      rouge.withOpacity(.2),
                      rouge.withOpacity(.2),
                      rouge.withOpacity(1)
                    ])),
              ),
              Positioned(
                  top: 2,
                  left: 0,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 2,
                      ),
                      Container(
                        height: 45,
                        // width: 150,
                        color: rouge,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              'une centrale'.toUpperCase(),
                              style: fontFammilyDii(
                                  context,
                                  size.width >= 1440
                                      ? 28
                                      : size.width >= 1024 && size.width < 1440
                                          ? 22
                                          : 16,
                                  blanc,
                                  FontWeight.bold,
                                  FontStyle.normal),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Positioned(
                  bottom: 0,
                  left: 13,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      height: 145,
                      width: size.width >= 1440
                          ? 500
                          : size.width >= 1024 && size.width < 1440
                              ? 400
                              : 350,
                      child: Column(
                        children: [
                          Text(homeUtilisateurBloc.uneArticle!.titre!,
                              overflow: TextOverflow.clip,
                              style: fontFammilyDii(
                                  context,
                                  size.width >= 1440
                                      ? 22
                                      : size.width >= 1024 && size.width < 1440
                                          ? 18
                                          : 14,
                                  blanc,
                                  FontWeight.bold,
                                  FontStyle.normal)),
                          paddingVerticalGlobal(8),
                          Row(
                            children: [
                              Text(
                                  '${showDate(homeUtilisateurBloc.uneArticle!.date!)}. by ${homeUtilisateurBloc.uneArticle!.author!.prenom} ${homeUtilisateurBloc.uneArticle!.author!.nom}',
                                  style: fontFammilyDii(context, 12, blanc,
                                      FontWeight.w300, FontStyle.normal)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
