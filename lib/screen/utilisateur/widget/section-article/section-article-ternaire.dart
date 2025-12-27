import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SectionArticleTernaireWidget extends StatefulWidget {
  final int tagShowRigth;
  final int showRigth;
  final double sizeTags;
  final double sizeTitle;
  final ArticlesModel articlesModel;
  
  const SectionArticleTernaireWidget({
    super.key,
    this.tagShowRigth = 0,
    this.showRigth = 0,
    this.sizeTags = 14,
    this.sizeTitle = 14,
    required this.articlesModel,
  });

  @override
  State<SectionArticleTernaireWidget> createState() => _SectionArticleTernaireWidgetState();
}

class _SectionArticleTernaireWidgetState extends State<SectionArticleTernaireWidget>
    with SingleTickerProviderStateMixin {
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

  void _handleHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
    isHovered ? _controller.forward() : _controller.reverse();
  }

  void _handleArticleClick(BuildContext context, HomeUtilisateurBloc bloc) {
    if (widget.articlesModel.slug == null) return;
    bloc.setAticle(widget.articlesModel);
    context.go('/article/${widget.articlesModel.slug!}');
  }

  void _handleTagClick(BuildContext context) {
    if (widget.articlesModel.tags?.slug == null) return;
    context.go('/tag/${widget.articlesModel.tags!.slug!}');
  }

  Widget _buildTag(BuildContext context) {
    if (widget.articlesModel.tags?.titre == null) return const SizedBox.shrink();
    
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: () => _handleTagClick(context),
        child: Container(
          height: 28,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: rouge.withOpacity(0.9),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              widget.articlesModel.tags!.titre!.toUpperCase(),
              style: fontFammilyDii(
                context,
                widget.sizeTags,
                blanc,
                FontWeight.bold,
                FontStyle.normal,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    return Container(
      height: 120,
      width: 120,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
      ),
      child: Hero(
        tag: 'article-image-${widget.articlesModel.slug}',
        child: Image.network(
          BASE_URL_ASSET + imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Center(
            child: Icon(
              Icons.image_not_supported_outlined,
              color: Colors.black26,
              size: 32,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    final imageUrl = widget.articlesModel.imageArticle?.url;

    return Expanded(
      flex: 1,
      child: MouseRegion(
        onEnter: (_) => _handleHover(true),
        onExit: (_) => _handleHover(false),
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) => Transform.scale(
            scale: _scaleAnimation.value,
            child: Card(
              elevation: _isHovered ? 4 : 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => _handleArticleClick(context, homeUtilisateurBloc),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (imageUrl != null && widget.showRigth == 0)
                          _buildImage(imageUrl),
                        if (imageUrl != null && widget.showRigth == 0)
                          const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: widget.tagShowRigth == 0
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.end,
                            children: [
                              _buildTag(context),
                              const SizedBox(height: 8),
                              Text(
                                widget.articlesModel.titre ?? '',
                                style: fontFammilyDii(
                                  context,
                                  widget.sizeTitle,
                                  noir,
                                  FontWeight.w600,
                                  FontStyle.normal,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ],
                          ),
                        ),
                        if (imageUrl != null && widget.showRigth == 1)
                          const SizedBox(width: 16),
                        if (imageUrl != null && widget.showRigth == 1)
                          _buildImage(imageUrl),
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
