import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/htm-to-string-dii.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'dart:js' as js;

class ArticleLesPlusLueUneWidget extends StatefulWidget {
  final ArticlesModel? article;
  const ArticleLesPlusLueUneWidget({super.key, this.article});

  @override
  State<ArticleLesPlusLueUneWidget> createState() => _ArticleLesPlusLueUneWidgetState();
}

class _ArticleLesPlusLueUneWidgetState extends State<ArticleLesPlusLueUneWidget> 
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

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

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
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
    final size = MediaQuery.of(context).size;

    return Expanded(
      flex: 2,
      child: MouseRegion(
        onEnter: (_) => _handleHover(true),
        onExit: (_) => _handleHover(false),
        cursor: SystemMouseCursors.click,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(_isHovered ? 0.3 : 0.2),
                blurRadius: _isHovered ? 20 : 15,
                spreadRadius: _isHovered ? 3 : 2,
                offset: Offset(0, _isHovered ? 8 : 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _navigateToArticle(homeUtilisateurBloc),
                    child: AnimatedBuilder(
                      animation: _scaleAnimation,
                      builder: (context, child) => Transform.scale(
                        scale: _scaleAnimation.value,
                        child: child,
                      ),
                      child: Container(
                        height: 300,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              widget.article?.imageArticle?.url != null && 
                              widget.article?.imageArticle?.url != ''
                                  ? BASE_URL_ASSET + widget.article!.imageArticle!.url!
                                  : 'https://cdn.vectorstock.com/i/500p/81/79/no-photo-icon-default-placeholder-vector-41468179.jpg',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () => _navigateToTag(context),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: blanc,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: rouge.withOpacity(0.2),
                                blurRadius: 8,
                                spreadRadius: 1,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            widget.article?.tags?.titre?.toUpperCase() ?? '',
                            style: fontFammilyDii(
                              context,
                              size.width >= 1440
                                  ? 14
                                  : size.width >= 1024
                                      ? 12
                                      : 10,
                              rouge,
                              FontWeight.bold,
                              FontStyle.normal,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () => _navigateToArticle(homeUtilisateurBloc),
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HtmlWidget(
                                widget.article?.titre ?? '',
                                customStylesBuilder: (element) {
                                  if (element.classes.contains('ql-align-center')) {
                                    return {'text-align': 'center'};
                                  }
                                  if (element.classes.contains('ql-align-justify')) {
                                    return {'text-align': 'justify'};
                                  }
                                  return {
                                    'fontSize': '18px',
                                    'text-align': 'justify',
                                    'line-height': '1.5',
                                    'word-wrap': 'break-word',
                                    'font-weight': 'bold',
                                  };
                                },
                                textStyle:  TextStyle(
                                  fontSize: 18,
                                  color: blanc,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 12),
                              HtmlWidget(
                                extractFirstTwoSentences(
                                  widget.article?.description ?? '',
                                  1,
                                ),
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
                                    'line-height': '1.6',
                                    'word-wrap': 'break-word',
                                  };
                                },
                                textStyle: TextStyle(
                                  fontSize: 14,
                                  color: blanc.withOpacity(0.9),
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
              ],
            ),
          ),
        ),
      ),
    );
  } 
  } 