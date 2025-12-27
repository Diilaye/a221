import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SectionArticleQuatrenaireWidget extends StatefulWidget {
  final ArticlesModel article;
  
  const SectionArticleQuatrenaireWidget({
    super.key, 
    required this.article,
  });

  @override
  State<SectionArticleQuatrenaireWidget> createState() => _SectionArticleQuatrenaireWidgetState();
}

class _SectionArticleQuatrenaireWidgetState extends State<SectionArticleQuatrenaireWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleArticleClick() {
    if (widget.article.slug == null) return;
    final bloc = Provider.of<HomeUtilisateurBloc>(context, listen: false);
    bloc.setAticle(widget.article);
    context.go('/article/${widget.article.slug!}');
  }

  void _handleTagClick() {
    if (widget.article.tags?.slug == null) return;
    context.go('/tag/${widget.article.tags!.slug!}');
  }

  void _handleHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
    isHovered ? _controller.forward() : _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = widget.article.imageArticle?.url;
    
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MouseRegion(
          onEnter: (_) => _handleHover(true),
          onExit: (_) => _handleHover(false),
          child: AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) => Transform.scale(
              scale: _scaleAnimation.value,
              child: Material(
                elevation: _isHovered ? 4 : 1,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: _handleArticleClick,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: blanc,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        if (imageUrl != null)
                          Hero(
                            tag: 'article-image-${widget.article.slug}',
                            child: Container(
                              decoration: BoxDecoration(
                                color: blanc,
                                image: DecorationImage(
                                  image: NetworkImage(BASE_URL_ASSET + imageUrl),
                                  fit: BoxFit.cover,
                                  onError: (_, __) {},
                                ),
                              ),
                            ),
                          ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.7),
                              ],
                              stops: const [0.6, 1.0],
                            ),
                          ),
                        ),
                        if (widget.article.tags?.titre != null)
                          Positioned(
                            top: 16,
                            left: 0,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: _handleTagClick,
                                child: Container(
                                  height: 32,
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: rouge.withOpacity(0.9),
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      widget.article.tags!.titre!.toUpperCase(),
                                      style: fontFammilyDii(
                                        context, 
                                        13, 
                                        blanc,
                                        FontWeight.bold, 
                                        FontStyle.normal,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if (widget.article.titre != null)
                          Positioned(
                            left: 16,
                            right: 16,
                            bottom: 16,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.article.titre!,
                                  style: fontFammilyDii(
                                    context, 
                                    16, 
                                    blanc,
                                    FontWeight.w600, 
                                    FontStyle.normal,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
