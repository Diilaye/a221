import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/screen/utilisateur/widget/articles/article-revelation-card.dart';
import 'package:actu/screen/utilisateur/widget/articles/article-les-plus-lue.dart';
import 'package:actu/screen/utilisateur/widget/articles/article-les-plus-une-widget.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SectionInvestigationWidget extends StatefulWidget {
  const SectionInvestigationWidget({super.key});

  @override
  State<SectionInvestigationWidget> createState() =>
      _SectionInvestigationWidgetState();
}

class _SectionInvestigationWidgetState extends State<SectionInvestigationWidget>
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
          margin: const EdgeInsets.symmetric(vertical: 40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: rouge.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              _buildHeader(context, homeUtilisateurBloc),
              const SizedBox(height: 0),
              _buildContent(context, homeUtilisateurBloc),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, HomeUtilisateurBloc bloc) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            noir,
            Colors.grey.shade900,
          ],
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  rouge,
                  rouge.withOpacity(0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: rouge.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(Icons.stars, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'RÉVÉLATION',
                    style: fontFammilyDii(
                      context,
                      26,
                      rouge,
                      FontWeight.w900,
                      FontStyle.normal,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          rouge,
                          rouge.withOpacity(0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'EXCLUSIF',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: Colors.black87,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Enquêtes et investigations approfondies',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const Spacer(),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: InkWell(
              onTap: () => _navigateToInvestigation(context, bloc),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      rouge.withOpacity(0.15),
                      rouge.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: rouge.withOpacity(0.3),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'VOIR PLUS',
                      style: fontFammilyDii(
                        context,
                        13,
                        rouge,
                        FontWeight.w700,
                        FontStyle.normal,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward,
                      color: rouge,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, HomeUtilisateurBloc bloc) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SizedBox(
        height: 540,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  // Article principal - Plus grand
                  if (bloc.uneInvestigations != null)
                    Expanded(
                      flex: 2,
                      child: _buildMainArticle(bloc),
                    ),
                  const SizedBox(height: 16),
                  // Cartes secondaires modernes
                  if (bloc.articleInvestigations.isNotEmpty)
                    Expanded(
                      flex: 1,
                      child: _buildSecondaryArticles(bloc),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            // Sidebar - Plus lues
            if (bloc.articleActualites.isNotEmpty)
              Expanded(
                flex: 1,
                child: _buildMostReadSection(context, bloc),
              ),
          ],
        ),
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered
                ? rouge.withOpacity(0.5)
                : Colors.grey.shade300,
            width: _isHovered ? 2 : 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: ArticleLesPlusLueUneWidget(
            article: bloc.uneInvestigations,
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryArticles(HomeUtilisateurBloc bloc) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey.shade50,
            Colors.white,
          ],
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: bloc.articleInvestigations
            .take(3)
            .map(
              (article) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: ArticleRevelationCard(
                    article: article,
                    accentColor: rouge,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildMostReadSection(BuildContext context, HomeUtilisateurBloc bloc) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200, width: 1),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.trending_up, color: rouge, size: 20),
                const SizedBox(width: 10),
                Text(
                  'LES PLUS LUES',
                  style: fontFammilyDii(
                    context,
                    14,
                    noir,
                    FontWeight.w700,
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

  void _navigateToInvestigation(
      BuildContext context, HomeUtilisateurBloc bloc) async {
    try {
      final category =
          bloc.categories.firstWhere((e) => e.titre == "INVESTIGATION");
      await bloc.setCatMenu(category);
      if (mounted) {
        context.go(
            '/categorie/${category.slug?.toLowerCase().replaceAll("é", "e")}');
      }
      await bloc.setCategorieMenu();
    } catch (e) {
      debugPrint('Error navigating to investigation: $e');
    }
  }
}
