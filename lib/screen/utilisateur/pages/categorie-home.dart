import 'package:actu/bloc/utilisateur/emission-user-bloc.dart';
import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/screen/utilisateur/pages/mobiles/categorie-mobile-screen.dart';
import 'package:actu/screen/utilisateur/widget/articles/article-bloc-multi-widget.dart';
import 'package:actu/screen/utilisateur/widget/emissions/article-top-bar.dart';
import 'package:actu/screen/utilisateur/widget/emissions/emission-top-bar.dart';
import 'package:actu/screen/utilisateur/widget/footer/section-footer.dart';
import 'package:actu/screen/utilisateur/widget/menu/exit-menu-rubrique.dart';
import 'package:actu/screen/utilisateur/widget/menu/menu-bar.dart';
import 'package:actu/screen/utilisateur/widget/menu/menu-rubrique.dart';
import 'package:actu/screen/utilisateur/widget/menu/top-bar-menu.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/responsive-ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../bloc/administrateur/post-digiteaux-bloc.dart';
import '../../../utils/requette-by-dii.dart';

class CategorieHome extends StatefulWidget {
  const CategorieHome({super.key});

  @override
  State<CategorieHome> createState() => _CategorieHomeState();
}

class _CategorieHomeState extends State<CategorieHome> {
  int currentPage = 1;
  final int articlesPerPage = 12;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    final emissionUserBloc = Provider.of<EmissionUserBloc>(context);
    final postsDigiteauxBloc = Provider.of<PostsDigiteauxBloc>(context);

    if (deviceName(size) == ScreenType.Mobile) {
      return const CategorieMobileScreen();
    }

    if (homeUtilisateurBloc.categorieMenuModel == null) {
      return Scaffold(
        backgroundColor: gris,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: rouge),
              const SizedBox(height: 16),
              Text(
                'Chargement de la catégorie...',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: gris,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: Stack(
        children: [
          Container(color: blanc),
          
          Center(
            child: Container(
              height: size.height,
              width: 1024,
              color: blanc,
              child: ListView(
                controller: homeUtilisateurBloc.controllerListHome,
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(height: 220),
                  
                  if (postsDigiteauxBloc.posts.isNotEmpty)
                    _buildTopBanner(postsDigiteauxBloc),
                  
                  const SizedBox(height: 48),
                  
                  _buildCategoryContent(context, homeUtilisateurBloc),
                  
                  const SizedBox(height: 48),
                  
                  const SectionFooter(),
                  const SizedBox(height: 46),
                ],
              ),
            ),
          ),

          _buildRedHeader(size),
          _buildTopEmissionsBar(size, emissionUserBloc, homeUtilisateurBloc),
          
          Positioned(
            top: 20,
            left: (size.width - 1024) / 2,
            right: (size.width - 1024) / 2,
            child: const TopBarMenu(),
          ),

          MenuBarArticle(
            categories: homeUtilisateurBloc.categories
                .where((e) => e.showMenu == "1")
                .toList(),
          ),

          if (homeUtilisateurBloc.hoverMenuClick != 0) ...[
            MenuRubrique(number: homeUtilisateurBloc.hoverMenuClick),
            const ExitMenuRubrique(),
          ],
        ],
      ),
    );
  }

  Widget _buildTopBanner(PostsDigiteauxBloc postsDigiteauxBloc) {
    final topArticle = postsDigiteauxBloc.posts
        .where((e) => e.statusOnline == "on" && e.type == "article-top")
        .firstOrNull;

    if (topArticle?.image?.url == null) {
      return const SizedBox.shrink();
    }

    return Container(
      height: 200,
      width: 1024,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          BASE_URL_ASSET + topArticle!.image!.url!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey.shade200,
              child: Center(
                child: Icon(
                  CupertinoIcons.photo,
                  size: 48,
                  color: Colors.grey.shade400,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategoryContent(
    BuildContext context,
    HomeUtilisateurBloc homeUtilisateurBloc,
  ) {
    final allArticles = homeUtilisateurBloc.categorieMenuModel!.articles ?? [];
    final categoryTitle = homeUtilisateurBloc
        .categorieMenuModel!.categorie!.titre!.toUpperCase();

    // Calculer la pagination
    final totalPages = (allArticles.length / articlesPerPage).ceil();
    final startIndex = (currentPage - 1) * articlesPerPage;
    final endIndex = (startIndex + articlesPerPage).clamp(0, allArticles.length);
    final paginatedArticles = allArticles.sublist(
      startIndex,
      endIndex,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeroSection(context, categoryTitle, allArticles.length, totalPages),
          
          const SizedBox(height: 48),
          
          if (allArticles.isEmpty)
            _buildEmptyState(context)
          else ...[
            _buildModernArticlesLayout(paginatedArticles),
            
            if (totalPages > 1) ...[
              const SizedBox(height: 48),
              _buildPagination(totalPages, allArticles.length),
            ],
          ],
        ],
      ),
    );
  }

  Widget _buildHeroSection(
    BuildContext context,
    String title, 
    int articleCount,
    int totalPages,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            rouge,
            rouge.withOpacity(0.85),
            const Color(0xFFB71C1C),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: rouge.withOpacity(0.3),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      CupertinoIcons.folder_fill,
                      color: blanc,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'CATÉGORIE',
                      style: TextStyle(
                        color: blanc,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(
                      CupertinoIcons.square_grid_2x2,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Page $currentPage / $totalPages',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          Text(
            title,
            style: const TextStyle(
              fontSize: 52,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 1.5,
              height: 1.1,
            ),
          ),
          
          const SizedBox(height: 16),
          
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      CupertinoIcons.doc_text_fill,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$articleCount article${articleCount > 1 ? "s" : ""} disponible${articleCount > 1 ? "s" : ""}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildModernArticlesLayout(List articles) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.75,
        crossAxisSpacing: 24,
        mainAxisSpacing: 32,
      ),
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return _buildArticleCard(articles[index]);
      },
    );
  }

  Widget _buildArticleCard(dynamic article) {
    return Container(
      decoration: BoxDecoration(
        color: blanc,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ArticleBlocMultiWidget(article: article),
    );
  }

  Widget _buildPagination(int totalPages, int totalArticles) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.info_circle_fill,
                size: 16,
                color: Colors.grey.shade600,
              ),
              const SizedBox(width: 8),
              Text(
                'Articles ${(currentPage - 1) * articlesPerPage + 1} - ${((currentPage) * articlesPerPage).clamp(0, totalArticles)} sur $totalArticles',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Bouton Précédent
              _buildPaginationButton(
                icon: CupertinoIcons.chevron_left,
                label: 'PRÉCÉDENT',
                onTap: currentPage > 1
                    ? () {
                        setState(() {
                          currentPage--;
                        });
                        // Scroll vers le haut
                        Scrollable.ensureVisible(
                          context,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    : null,
                isEnabled: currentPage > 1,
              ),
              
              const SizedBox(width: 24),
              
              // Numéros de pages
              ..._buildPageNumbers(totalPages),
              
              const SizedBox(width: 24),
              
              // Bouton Suivant
              _buildPaginationButton(
                icon: CupertinoIcons.chevron_right,
                label: 'SUIVANT',
                iconRight: true,
                onTap: currentPage < totalPages
                    ? () {
                        setState(() {
                          currentPage++;
                        });
                        // Scroll vers le haut
                        Scrollable.ensureVisible(
                          context,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    : null,
                isEnabled: currentPage < totalPages,
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageNumbers(int totalPages) {
    List<Widget> pages = [];
    
    // Logique pour afficher max 7 numéros de page
    int start = 1;
    int end = totalPages;
    
    if (totalPages > 7) {
      if (currentPage <= 4) {
        end = 7;
      } else if (currentPage >= totalPages - 3) {
        start = totalPages - 6;
      } else {
        start = currentPage - 3;
        end = currentPage + 3;
      }
    }
    
    // Première page si nécessaire
    if (start > 1) {
      pages.add(_buildPageNumber(1));
      if (start > 2) {
        pages.add(_buildEllipsis());
      }
    }
    
    // Numéros de pages visibles
    for (int i = start; i <= end; i++) {
      pages.add(_buildPageNumber(i));
    }
    
    // Dernière page si nécessaire
    if (end < totalPages) {
      if (end < totalPages - 1) {
        pages.add(_buildEllipsis());
      }
      pages.add(_buildPageNumber(totalPages));
    }
    
    return pages;
  }

  Widget _buildPageNumber(int pageNumber) {
    final isActive = pageNumber == currentPage;
    
    return InkWell(
      onTap: () {
        setState(() {
          currentPage = pageNumber;
        });
        // Scroll vers le haut
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: isActive ? rouge : blanc,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive ? rouge : Colors.grey.shade300,
            width: isActive ? 2 : 1,
          ),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: rouge.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            '$pageNumber',
            style: TextStyle(
              fontSize: 15,
              fontWeight: isActive ? FontWeight.w900 : FontWeight.w600,
              color: isActive ? blanc : Colors.grey.shade700,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEllipsis() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 44,
      height: 44,
      child: Center(
        child: Text(
          '...',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade600,
          ),
        ),
      ),
    );
  }

  Widget _buildPaginationButton({
    required IconData icon,
    required String label,
    required VoidCallback? onTap,
    required bool isEnabled,
    bool iconRight = false,
  }) {
    return InkWell(
      onTap: isEnabled ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isEnabled ? rouge : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isEnabled
              ? [
                  BoxShadow(
                    color: rouge.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!iconRight) ...[
              Icon(
                icon,
                color: isEnabled ? blanc : Colors.grey.shade500,
                size: 16,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: TextStyle(
                color: isEnabled ? blanc : Colors.grey.shade500,
                fontSize: 13,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            if (iconRight) ...[
              const SizedBox(width: 8),
              Icon(
                icon,
                color: isEnabled ? blanc : Colors.grey.shade500,
                size: 16,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedArticleCard(dynamic article) {
    return Container(
      height: 380,
      decoration: BoxDecoration(
        color: blanc,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ArticleBlocMultiWidget(article: article),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(64),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 2,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: blanc,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                CupertinoIcons.doc_text_search,
                size: 80,
                color: Colors.grey.shade400,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Aucun article disponible',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Les articles seront publiés prochainement',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 32),
            InkWell(
              onTap: () => context.go('/'),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: rouge.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: rouge.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      CupertinoIcons.home,
                      size: 18,
                      color: rouge,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Retour à l\'accueil',
                      style: TextStyle(
                        color: rouge,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRedHeader(Size size) {
    return Positioned(
      top: 0,
      child: Container(
        height: 215,
        width: size.width,
        color: rouge,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(height: 5, color: blanc),
          ],
        ),
      ),
    );
  }

  Widget _buildTopEmissionsBar(
    Size size,
    EmissionUserBloc emissionUserBloc,
    HomeUtilisateurBloc homeUtilisateurBloc,
  ) {
    return Positioned(
      top: 84,
      left: (size.width - 1024) / 2,
      right: (size.width - 1024) / 2,
      child: Container(
        height: 75,
        width: 1024,
        decoration: BoxDecoration(
          color: blanc,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            if (emissionUserBloc.emissions.isNotEmpty) ...[
              Expanded(
                child: EmissionTopBarWidget(
                  emissionModel: emissionUserBloc.suivreEmission!,
                ),
              ),
              Container(width: 2, height: 60, color: rouge.withOpacity(0.3)),
            ],
            
            if (homeUtilisateurBloc.topArticle != null) ...[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ArticleTopBarWidget(
                    articlesModel: homeUtilisateurBloc.topArticle!,
                  ),
                ),
              ),
              Container(width: 2, height: 60, color: rouge.withOpacity(0.3)),
            ],
            
            if (emissionUserBloc.emissions.isNotEmpty)
              Expanded(
                child: EmissionTopBarWidget(
                  emissionModel: emissionUserBloc.inviteEmission!,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
