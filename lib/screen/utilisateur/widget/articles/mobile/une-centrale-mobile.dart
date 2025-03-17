import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/htm-to-string-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'dart:js' as js;

class UneCentraleMobile extends StatelessWidget {
  const UneCentraleMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    Size size = MediaQuery.of(context).size;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          homeUtilisateurBloc.setAticle(homeUtilisateurBloc.uneArticleMobile!);
          js.context.callMethod('open', [
            'https://a221.net/article/${homeUtilisateurBloc.uneArticleMobile!.slug!}',
            '_self'
          ]);
        },
        child: Container(
          // height: 450,
          width: size.width,
          child: Column(
            children: [
              paddingVerticalGlobal(8),
              Row(
                children: [
                  paddingHorizontalGlobal(12),
                  Icon(
                    Icons.circle,
                    color: rouge,
                    size: 12,
                  ),
                  paddingHorizontalGlobal(2),
                  Text(
                    homeUtilisateurBloc.uneArticleMobile!.tags!.titre!.toUpperCase(),
                    style: fontFammilyDii(
                        context, 18, rouge, FontWeight.bold, FontStyle.normal),
                  )
                ],
              ),
             /* paddingVerticalGlobal(4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  homeUtilisateurBloc.uneArticleMobile!.titre!,
                  style: fontFammilyDii(
                      context, 20, noir, FontWeight.bold, FontStyle.normal),
                ),
              ),

              */
              paddingVerticalGlobal(4),
              Image.network(
                BASE_URL_ASSET +
                    homeUtilisateurBloc.uneArticleMobile!.imageArticle!.url!,
                height: 300,
                width: size.width * .9,
                fit: BoxFit.fill,
              ),
              paddingVerticalGlobal(4),
          /*   Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "${homeUtilisateurBloc.uneArticleMobile!.author!.prenom!} ${homeUtilisateurBloc.uneArticleMobile!.author!.nom!}",
                    style: fontFammilyDii(
                        context, 10, noir, FontWeight.w200, FontStyle.normal),
                  ),



                  paddingHorizontalGlobal(8)
                ],
              ),

           */
            ],
          ),
        ),
      ),
    );
  }
}
