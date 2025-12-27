import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:js' as js;

import 'package:provider/provider.dart';

class SectionUneTernaireWidget extends StatefulWidget {
  final ArticlesModel article;
  const SectionUneTernaireWidget({super.key, required this.article});

  @override
  State<SectionUneTernaireWidget> createState() => _SectionUneTernaireWidgetState();
}

class _SectionUneTernaireWidgetState extends State<SectionUneTernaireWidget> with SingleTickerProviderStateMixin {
  bool isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return SizedBox(
      width: double.infinity,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) {
          setState(() => isHovered = true);
          _controller.forward();
        },
        onExit: (_) {
          setState(() => isHovered = false);
          _controller.reverse();
        },
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Column(
        children: [
          GestureDetector(
            onTap: () {
              homeUtilisateurBloc.setAticle(widget.article);
              js.context.callMethod('open',
                  ['https://a221.net/article/${widget.article.slug!}', '_self']);
            },
            child: Container(
              height: 360,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  BASE_URL_ASSET + widget.article.imageArticle!.url!,
                  height: 440,
                  width: 600,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          paddingVerticalGlobal(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  context.go('/tag/${widget.article.tags!.slug!}');
                },
                child:  Container(
                  decoration: BoxDecoration(
                    color: rouge,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: rouge.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      paddingHorizontalGlobal(12),
                      Text(
                        widget.article.tags!.titre!.toUpperCase(),
                        style: fontFammilyDii(
                            context,
                             16,
                            blanc,
                            FontWeight.bold,
                            FontStyle.normal),
                      ),
                      paddingHorizontalGlobal(12),
                    ],
                  ),
                ),
             
              ),
            ],
          ),
          paddingVerticalGlobal(4),
          GestureDetector(
            onTap: () {
              homeUtilisateurBloc.setAticle(widget.article);
              js.context.callMethod('open', [
                'https://a221.net/article/${widget.article.slug!}',
                '_self'
              ]);
            },
            child: Text(
              widget.article.titre!,
              style: fontFammilyDii(
                  context,
                   18,
                  noir,
                  FontWeight.bold,
                  FontStyle.normal),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    ),
      ),
    );
  }
}
