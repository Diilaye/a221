import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/screen/utilisateur/widget/articles/article-bloc-multi-une-lue-widget.dart';
import 'package:actu/screen/utilisateur/widget/articles/article-les-plus-lue.dart';
import 'package:actu/screen/utilisateur/widget/articles/article-les-plus-une-widget.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SectionInvestigationtWidget extends StatefulWidget {
  const SectionInvestigationtWidget({super.key});

  @override
  State<SectionInvestigationtWidget> createState() => _SectionInvestigationtWidgetState();
}

class _SectionInvestigationtWidgetState extends State<SectionInvestigationtWidget> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleHover(bool value) {
    setState(() {
      _isHovered = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          margin: const EdgeInsets.symmetric(vertical: 32),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                rouge,
                rouge.withOpacity(0.9),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: rouge.withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: 5,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                _buildHeader(context, homeUtilisateurBloc),
                const SizedBox(height: 24),
                _buildContent(context, homeUtilisateurBloc),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, HomeUtilisateurBloc bloc) {
    return Row(
      children: [
        const Icon(Icons.search, color: Colors.white, size: 32),
        const SizedBox(width: 16),
        Text(
          'Révélation'.toUpperCase(),
          style: fontFammilyDii(
            context,
            28,
            Colors.white,
            FontWeight.bold,
            FontStyle.normal,
          ),
        ),
        const Spacer(),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: InkWell(
            onTap: () => _navigateToInvestigation(context, bloc),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'voir +'.toUpperCase(),
                    style: fontFammilyDii(
                      context,
                      16,
                      Colors.white,
                      FontWeight.bold,
                      FontStyle.normal,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, HomeUtilisateurBloc bloc) {
    return SizedBox(
      height: 550,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                if (bloc.uneInvestigations != null)
                  Expanded(
                    flex: 3,
                    child: _buildMainArticle(bloc),
                  ),
                const SizedBox(height: 16),
                if (bloc.articleInvestigations.isNotEmpty)
                  Expanded(
                    flex: 2,
                    child: _buildSecondaryArticles(bloc),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          if (bloc.articleActualites.isNotEmpty)
            Expanded(
              flex: 1,
              child: _buildMostReadSection(context, bloc),
            ),
        ],
      ),
    );
  }

  Widget _buildMainArticle(HomeUtilisateurBloc bloc) {
    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_isHovered ? 0.3 : 0.25),
              blurRadius: _isHovered ? 20 : 15,
              spreadRadius: _isHovered ? 3 : 2,
              offset: Offset(0, _isHovered ? 10 : 8),
            ),
            BoxShadow(
              color: rouge.withOpacity(_isHovered ? 0.2 : 0.15),
              blurRadius: _isHovered ? 25 : 20,
              spreadRadius: _isHovered ? 5 : 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Hero(
                tag: 'investigation-main-${bloc.uneInvestigations?.id ?? ""}',
                child: ArticleLesPlusLueUneWidget(
                  article: bloc.uneInvestigations,
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }

  Widget _buildSecondaryArticles(HomeUtilisateurBloc bloc) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.05),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: bloc.articleInvestigations
            .take(3)
            .map(
              (article) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ArticleBlocMultiUneLueWidget(
                    card: 0,
                    color: rouge,
                    article: article,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildMostReadSection(BuildContext context, HomeUtilisateurBloc bloc) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: rouge.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Icon(Icons.trending_up, color: rouge),
                const SizedBox(width: 8),
                Text(
                  'Les plus lues'.toUpperCase(),
                  style: fontFammilyDii(
                    context,
                    16,
                    noir,
                    FontWeight.bold,
                    FontStyle.normal,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: bloc.articleActualites.take(5).length,
              itemBuilder: (context, index) {
                return ArticleLesPlusLue(
                  nombre: index + 1,
                  article: bloc.articleActualites[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToInvestigation(BuildContext context, HomeUtilisateurBloc bloc) async {
    try {
      final category = bloc.categories.firstWhere((e) => e.titre == "INVESTIGATION");
      await bloc.setCatMenu(category);
      if (mounted) {
        context.go('/categorie/${category.slug?.toLowerCase().replaceAll("é", "e")}');
      }
      await bloc.setCategorieMenu();
    } catch (e) {
      debugPrint('Error navigating to investigation: $e');
    }
  }
}