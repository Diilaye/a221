import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:js' as js;

class UneCentraleMobileModern extends StatelessWidget {
  const UneCentraleMobileModern({super.key});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    Size size = MediaQuery.of(context).size;
    
    if (homeUtilisateurBloc.uneArticleMobile == null) {
      return SizedBox();
    }

    return GestureDetector(
      onTap: () {
        homeUtilisateurBloc.setAticle(homeUtilisateurBloc.uneArticleMobile!);
        js.context.callMethod('open', [
          'https://a221.net/article/${homeUtilisateurBloc.uneArticleMobile!.slug!}',
          '_self'
        ]);
      },
      child: Container(
        width: size.width,
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container avec image et overlay
            Container(
              height: 400,
              width: size.width,
              child: Stack(
                children: [
                  // Image principale
                  homeUtilisateurBloc.uneArticleMobile!.imageArticle?.url != null
                      ? Image.network(
                          BASE_URL_ASSET + homeUtilisateurBloc.uneArticleMobile!.imageArticle!.url!,
                          height: 400,
                          width: size.width,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: 400,
                          color: Colors.grey.shade300,
                          child: Icon(
                            CupertinoIcons.photo,
                            size: 80,
                            color: Colors.grey.shade400,
                          ),
                        ),

                  // Gradient overlay
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          noir.withOpacity(0.85),
                        ],
                        stops: [0.4, 1.0],
                      ),
                    ),
                  ),

                  // Badge "À LA UNE"
                  Positioned(
                    top: 20,
                    left: 16,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [rouge, rouge.withOpacity(0.85)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: rouge.withOpacity(0.5),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            CupertinoIcons.star_fill,
                            color: blanc,
                            size: 16,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'À LA UNE',
                            style: fontFammilyDii(
                              context,
                              14,
                              blanc,
                              FontWeight.w900,
                              FontStyle.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Catégorie tag
                  Positioned(
                    bottom: 130,
                    left: 16,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: blanc,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: noir.withOpacity(0.3),
                            blurRadius: 12,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.circle,
                            color: rouge,
                            size: 10,
                          ),
                          SizedBox(width: 8),
                          Text(
                            homeUtilisateurBloc.uneArticleMobile!.tags?.titre?.toUpperCase() ?? '',
                            style: fontFammilyDii(
                              context,
                              13,
                              rouge,
                              FontWeight.w700,
                              FontStyle.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Titre et informations
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            noir.withOpacity(0.95),
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Fond semi-transparent pour le titre
                          Container(
                            padding: EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: noir.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              homeUtilisateurBloc.uneArticleMobile!.titre ?? '',
                              style: fontFammilyDii(
                                context,
                                24,
                                blanc,
                                FontWeight.w900,
                                FontStyle.normal,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              // Auteur avec meilleur contraste
                              if (homeUtilisateurBloc.uneArticleMobile!.author != null)
                                Flexible(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: noir.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: blanc.withOpacity(0.25),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Icon(
                                            CupertinoIcons.person_fill,
                                            color: blanc,
                                            size: 16,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Flexible(
                                          child: Text(
                                            "${homeUtilisateurBloc.uneArticleMobile!.author!.prenom ?? ''} ${homeUtilisateurBloc.uneArticleMobile!.author!.nom ?? ''}",
                                            style: fontFammilyDii(
                                              context,
                                              15,
                                              blanc,
                                              FontWeight.w700,
                                              FontStyle.normal,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              SizedBox(width: 12),
                              // Bouton lire plus grand
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [rouge, rouge.withOpacity(0.85)],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: rouge.withOpacity(0.5),
                                      blurRadius: 12,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Lire',
                                      style: fontFammilyDii(
                                        context,
                                        16,
                                        blanc,
                                        FontWeight.w900,
                                        FontStyle.normal,
                                      ),
                                    ),
                                    SizedBox(width: 6),
                                    Icon(
                                      CupertinoIcons.arrow_right,
                                      color: blanc,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
