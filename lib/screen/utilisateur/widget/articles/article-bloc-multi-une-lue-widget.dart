import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:flutter/material.dart';
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
  State<ArticleBlocMultiUneLueWidget> createState() => _ArticleBlocMultiUneLueWidgetState();
}

class _ArticleBlocMultiUneLueWidgetState extends State<ArticleBlocMultiUneLueWidget>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _overlayAnimation;
  late Animation<double> _titleOpacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _overlayAnimation = Tween<double>(
      begin: 0.5,
      end: 0.7,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _titleOpacityAnimation = Tween<double>(
      begin: 0.9,
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

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return Expanded(
      flex: 4,
      child: MouseRegion(
        onEnter: (_) => _handleHover(true),
        onExit: (_) => _handleHover(false),
        cursor: SystemMouseCursors.click,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: widget.color.withOpacity(0.2),
                    blurRadius: _isHovered ? 25 : 15,
                    spreadRadius: _isHovered ? 5 : 2,
                    offset: Offset(0, _isHovered ? 10 : 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: 'article-${widget.article?.id ?? ""}',
                      child: GestureDetector(
                        onTap: () => _navigateToArticle(homeUtilisateurBloc),
                        child: Image.network(
                          widget.article?.imageArticle?.url != null &&
                                  widget.article?.imageArticle?.url != ''
                              ? BASE_URL_ASSET + widget.article!.imageArticle!.url!
                              : 'https://cdn.vectorstock.com/i/500p/81/79/no-photo-icon-default-placeholder-vector-41468179.jpg',
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                color: widget.color,
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.3),
                          ],
                        ),
                      ),
                    ),
                    AnimatedBuilder(
                      animation: _overlayAnimation,
                      builder: (context, child) => Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              widget.color.withOpacity(_overlayAnimation.value),
                              widget.color.withOpacity(_overlayAnimation.value * 0.5),
                            ],
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.article?.titre != null)
                              Expanded(
                                child: Container(
                                  alignment: Alignment.bottomLeft,
                                  child: AnimatedOpacity(
                                    duration: const Duration(milliseconds: 200),
                                    opacity: _titleOpacityAnimation.value,
                                    child: Text(
                                      widget.article!.titre!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(0, 1),
                                            blurRadius: 3,
                                            color: Colors.black45,
                                          ),
                                        ],
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

   
  }
}