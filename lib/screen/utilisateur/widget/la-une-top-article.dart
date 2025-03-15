import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/date-showing-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          homeUtilisateurBloc.setAticle(homeUtilisateurBloc.uneArticle!);
        /*  js.context.callMethod('open', [
            'https://a221.net/article/${homeUtilisateurBloc.uneArticle!.slug!}',
            '_self'
          ]);

         */
           context.go('/article/${homeUtilisateurBloc.uneArticle!.slug!}');
        },
        child: Image.network(
          BASE_URL_ASSET +
              homeUtilisateurBloc.uneArticle!.imageArticle!.url!,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
