import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'dart:js' as js;

class ArticleBlocMultiUneLueWidget extends StatefulWidget {
  final double card;
  final Color color;
  final ArticlesModel? article;

  const ArticleBlocMultiUneLueWidget({
    super.key,
    this.card = 0,
    this.color = Colors.black,
    this.article,
  });

  @override
  State<ArticleBlocMultiUneLueWidget> createState() =>
      _ArticleBlocMultiUneLueWidgetState();
}

class _ArticleBlocMultiUneLueWidgetState
    extends State<ArticleBlocMultiUneLueWidget>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
    isHovered ? _controller.forward() : _controller.reverse();
  }

  void _navigateToArticle(HomeUtilisateurBloc bloc) {
    if (widget.article?.slug == null) return;
    bloc.setAticle(widget.article!);
    js.context.callMethod(
      'open',
      ['https://a221.net/article/${widget.article!.slug!}', '_self'],
    );
  }

  void _navigateToTag(BuildContext context) {
    if (widget.article?.tags?.slug == null) return;
    context.go('/tag/${widget.article!.tags!.slug!}');
  }

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      cursor: SystemMouseCursors.click,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: widget.color.withOpacity(_isHovered ? 0.2 : 0.1),
                  blurRadius: _isHovered ? 20 : 10,
                  spreadRadius: _isHovered ? 4 : 2,
                  offset: Offset(0, _isHovered ? 8 : 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Hero(
                            tag: 'article-${widget.article?.id ?? ""}',
                            child: GestureDetector(
                              onTap: () =>
                                  _navigateToArticle(homeUtilisateurBloc),
                              child: Image.network(
                                widget.article?.imageArticle?.url != null &&
                                        widget.article?.imageArticle?.url != ''
                                    ? BASE_URL_ASSET +
                                        widget.article!.imageArticle!.url!
                                    : 'https://cdn.vectorstock.com/i/500p/81/79/no-photo-icon-default-placeholder-vector-41468179.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        if (widget.article?.tags != null)
                          Positioned(
                            top: 16,
                            left: 16,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => _navigateToTag(context),
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: widget.color.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    widget.article!.tags!.titre!.toUpperCase(),
                                    style: fontFammilyDii(
                                      context,
                                      12,
                                      Colors.white,
                                      FontWeight.bold,
                                      FontStyle.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: GestureDetector(
                        onTap: () => _navigateToArticle(homeUtilisateurBloc),
                        child: HtmlWidget(
                          widget.article?.titre ?? '',
                          customStylesBuilder: (element) {
                            if (element.classes.contains('ql-align-center')) {
                              return {'text-align': 'center'};
                            }
                            if (element.classes.contains('ql-align-justify')) {
                              return {'text-align': 'justify'};
                            }
                            return {
                              'fontSize': '14px',
                              'text-align': 'justify',
                              'line-height': '1.5',
                              'word-wrap': 'break-word',
                              'font-weight': '700',
                            };
                          },
                          textStyle: TextStyle(
                            fontSize: 14,
                            color: noir,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
