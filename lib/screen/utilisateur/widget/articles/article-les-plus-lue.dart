import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/date-showing-dii.dart';
import 'package:actu/utils/responsive-ui.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'dart:js' as js;

class ArticleLesPlusLue extends StatelessWidget {
  final int nombre;
  final ArticlesModel? article;
  const ArticleLesPlusLue(
      {super.key, required this.nombre, this.article = null});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    Size size = MediaQuery.of(context).size;
    return article == null
        ? Expanded(
            child: Column(
              children: [
                paddingVerticalGlobal(),
                Row(
                  children: [
                    paddingHorizontalGlobal(8),
                    Expanded(
                        child: Container(
                      height: 1,
                      color: noir,
                    )),
                    paddingHorizontalGlobal(8),
                  ],
                ),
                paddingVerticalGlobal(),
                Expanded(
                    child: Row(
                  children: [
                    paddingHorizontalGlobal(),
                    Column(
                      children: [
                        Text(
                          '${nombre}.',
                          style: fontFammilyDii(context, 22, rouge,
                              FontWeight.bold, FontStyle.normal),
                        ),
                      ],
                    ),
                    paddingHorizontalGlobal(6),
                    Expanded(
                        child: Column(
                      children: [
                        paddingVerticalGlobal(4),
                        Text(
                          'Un fonctionnaire épinglé après avoir menti sur sa scolarité',
                          style: fontFammilyDii(context, 18, noir,
                              FontWeight.w500, FontStyle.normal),
                        ),
                        paddingVerticalGlobal(4),
                        Row(children: [
                          Text(
                            'Il y a 2 heures Politique provinciale',
                            style: fontFammilyDii(context, 12, noir,
                                FontWeight.w300, FontStyle.normal),
                          ),
                        ]),
                      ],
                    )),
                    paddingHorizontalGlobal(),
                  ],
                )),
              ],
            ),
          )
        : Expanded(
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  homeUtilisateurBloc.setAticle(homeUtilisateurBloc.articles
                      .lastWhere((e) => e.id! == article!.id!));
                  js.context.callMethod('open',
                      ['https://a221.net/article/${article!.slug!}', '_self']);
                  // context.go('/article/${article!.slug!}');
                },
                child: Column(
                  children: [
                    paddingVerticalGlobal(),
                    Row(
                      children: [
                        paddingHorizontalGlobal(8),
                        Expanded(
                            child: Container(
                          height: 1,
                          color: noir,
                        )),
                        paddingHorizontalGlobal(8),
                      ],
                    ),
                    paddingVerticalGlobal(),
                    Expanded(
                        child: Row(
                      children: [
                        paddingHorizontalGlobal(),
                        Column(
                          children: [
                            Text(
                              '${nombre}.',
                              style: fontFammilyDii(context, 22, rouge,
                                  FontWeight.bold, FontStyle.normal),
                            ),
                          ],
                        ),
                        paddingHorizontalGlobal(6),
                        Expanded(
                            child: Column(
                          children: [
                            paddingVerticalGlobal(4),
                            Text(
                              article!.titre!,
                              style: fontFammilyDii(
                                  context,
                                  12,
                                  noir,
                                  FontWeight.w600,
                                  FontStyle.normal),
                              overflow: TextOverflow.ellipsis,
                            ),
                            paddingVerticalGlobal(4),
                            Row(children: [
                              Text(
                                'Daté le ${showDate(article!.date!)}',
                                style: fontFammilyDii(context, 10, noir,
                                    FontWeight.w300, FontStyle.normal),
                              ),
                            ]),
                          ],
                        )),
                        paddingHorizontalGlobal(),
                      ],
                    )),
                  ],
                ),
              ),
            ),
          );
  }
}
