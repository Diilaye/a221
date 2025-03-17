import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'dart:js' as js;

class SectionArticleTernaireWidget extends StatelessWidget {
  final int tagShowRigth;
  final int showRigth;
  final double sizeTags;
  final double sizeTitle;
  final ArticlesModel articlesModel;
  const SectionArticleTernaireWidget(
      {super.key,
      this.tagShowRigth = 0,
      this.showRigth = 0,
      this.sizeTags = 14,
      this.sizeTitle = 14,
      required this.articlesModel});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return showRigth == 0
        ? Expanded(
            flex: 1,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      homeUtilisateurBloc.setAticle(articlesModel);
                      js.context.callMethod('open', [
                        'https://a221.net/article/${articlesModel.slug!}',
                        '_self'
                      ]);
                      // context.go('/article/${articlesModel.slug!}');
                    },
                    child: Image.network(
                      BASE_URL_ASSET + articlesModel.imageArticle!.url!,
                      height: 150,
                      width: 150,
                      fit: BoxFit.contain,
                    ),
                  ),
                  paddingHorizontalGlobal(8),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: tagShowRigth == 0
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                homeUtilisateurBloc.setAticle(articlesModel);
                                // js.context.callMethod('open', [
                                //   'https://a221.net/tag/${articlesModel.tags!.slug!}',
                                //   '_self'
                                // ]);
                                context.go('/tag/${articlesModel.tags!.slug!}');
                              },
                              child: Container(
                                height: 30,
                                color: rouge,
                                child: Row(
                                  children: [
                                    paddingHorizontalGlobal(6),
                                    Text(
                                      articlesModel.tags!.titre!.toUpperCase(),
                                      style: fontFammilyDii(
                                          context,
                                          sizeTags,
                                          blanc,
                                          FontWeight.bold,
                                          FontStyle.normal),
                                    ),
                                    paddingHorizontalGlobal(6),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    homeUtilisateurBloc
                                        .setAticle(articlesModel);
                                    js.context.callMethod('open', [
                                      'https://a221.net/article/${articlesModel.slug!}',
                                      '_self'
                                    ]);
                                    // context.go('/article/${articlesModel.slug!}');
                                  },
                                  child: Text(
                                    articlesModel.titre!,
                                    overflow: TextOverflow.clip,
                                    style: fontFammilyDii(
                                        context,
                                        sizeTitle,
                                        noir,
                                        FontWeight.bold,
                                        FontStyle.normal),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ))
        : Expanded(
            flex: 1,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: tagShowRigth == 1
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                homeUtilisateurBloc.setAticle(articlesModel);
                                js.context.callMethod('open', [
                                  'https://a221.net/tag/${articlesModel.tags!.slug}',
                                  '_self'
                                ]);
                                // context.go('/tag/${articlesModel.tags!.slug!}');
                              },
                              child: Container(
                                height: 30,
                                color: rouge,
                                child: Row(
                                  children: [
                                    paddingHorizontalGlobal(6),
                                    Text(
                                      articlesModel.tags!.titre!.toUpperCase(),
                                      style: fontFammilyDii(
                                          context,
                                          sizeTags,
                                          blanc,
                                          FontWeight.bold,
                                          FontStyle.normal),
                                    ),
                                    paddingHorizontalGlobal(6),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    homeUtilisateurBloc
                                        .setAticle(articlesModel);
                                    js.context.callMethod('open', [
                                      'https://a221.net/article/${articlesModel.slug!}',
                                      '_self'
                                    ]);
                                  },
                                  child: Text(
                                    articlesModel.titre!,
                                    overflow: TextOverflow.fade,
                                    style: fontFammilyDii(
                                        context,
                                        sizeTitle,
                                        noir,
                                        FontWeight.bold,
                                        FontStyle.normal),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      homeUtilisateurBloc.setAticle(articlesModel);
                      js.context.callMethod('open', [
                        'https://a221.net/article/${articlesModel.slug!}',
                        '_self'
                      ]);
                    },
                    child: Image.network(
                      BASE_URL_ASSET + articlesModel.imageArticle!.url!,
                      height: 150,
                      width: 150,
                      fit: BoxFit.fill,
                    ),
                  ),
                  paddingHorizontalGlobal(8),
                ],
              ),
            ));
  }
}
