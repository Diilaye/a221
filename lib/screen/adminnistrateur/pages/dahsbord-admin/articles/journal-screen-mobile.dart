import 'package:actu/bloc/administrateur/article-bloc.dart';
import 'package:actu/bloc/administrateur/categorie-bloc.dart';
import 'package:actu/bloc/administrateur/menu-admin.dart';
import 'package:actu/bloc/administrateur/tags-bloc.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/articles/add-screen-mobile.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/articles/update-screen-mobile.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/diallog-dii.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JournalScreenMobile extends StatefulWidget {
  const JournalScreenMobile({super.key});

  @override
  State<JournalScreenMobile> createState() => _JournalScreenMobileState();
}

class _JournalScreenMobileState extends State<JournalScreenMobile> {
  int itemsPerPage = 1000; // Afficher tous les articles
  int currentPage = 1;

  List<dynamic> _getFilteredArticles(AddArticleBloc addArticleBloc, CategorieBloc categorieBloc) {
    return addArticleBloc.articles.where((e) {
      bool matchesSearch = addArticleBloc.rechercheT.isEmpty ||
          (e.titre?.toLowerCase().contains(addArticleBloc.rechercheT.toLowerCase()) ?? false);
      
      bool matchesCategory = categorieBloc.categorie == null ||
          e.categorie?.id == categorieBloc.categorie!.id!;
      
      bool matchesStatus = addArticleBloc.statusNews == 'all' ||
          e.statusOnline == addArticleBloc.statusNews;
      
      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();
  }

  List<dynamic> _getPaginatedArticles(AddArticleBloc addArticleBloc, CategorieBloc categorieBloc) {
    final filtered = _getFilteredArticles(addArticleBloc, categorieBloc);
    if (filtered.isEmpty) return [];
    final startIndex = (currentPage - 1) * itemsPerPage;
    if (startIndex >= filtered.length) return [];
    final endIndex = startIndex + itemsPerPage;
    return filtered.sublist(
      startIndex,
      endIndex > filtered.length ? filtered.length : endIndex,
    );
  }

  int _getTotalPages(AddArticleBloc addArticleBloc, CategorieBloc categorieBloc) {
    final filtered = _getFilteredArticles(addArticleBloc, categorieBloc);
    return (filtered.length / itemsPerPage).ceil();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final menuAdminBloc = Provider.of<MenuAdminBloc>(context);
    final addArticleBloc = Provider.of<AddArticleBloc>(context);
    final categorieBloc = Provider.of<CategorieBloc>(context);
    final tagsBloc = Provider.of<TagsBloc>(context);

    return Stack(
      children: [
        if (addArticleBloc.showUpdate == 0)
          Container(
            color: Colors.grey.shade50,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildHeader(context, size, menuAdminBloc, addArticleBloc),
                const SizedBox(height: 20),
                _buildFiltersSection(context, size, categorieBloc, addArticleBloc),
                const SizedBox(height: 20),
                _buildArticlesCard(context, size, addArticleBloc, categorieBloc, tagsBloc),
              ],
            ),
          ),
        if (addArticleBloc.showUpdate == 1)
          Positioned(
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: const UpdateArticleScreenMobile(),
            ),
          ),
        if (menuAdminBloc.addArticle == 1)
          Positioned(
            top: 0,
            right: 0,
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: const AddArticleScreenMobile(),
            ),
          ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, Size size, MenuAdminBloc menuAdminBloc, AddArticleBloc addArticleBloc) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.indigo.shade700,
            Colors.indigo.shade500,
            Colors.purple.shade600,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 20,
            color: Colors.indigo.withOpacity(0.3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Breadcrumb
          Row(
            children: [
              Icon(CupertinoIcons.home, color: blanc.withOpacity(0.8), size: 12),
              const SizedBox(width: 6),
              Icon(CupertinoIcons.chevron_forward, color: blanc.withOpacity(0.5), size: 10),
              const SizedBox(width: 6),
              Text(
                'Journal',
                style: TextStyle(
                  fontSize: 11,
                  color: blanc.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 6),
              Icon(CupertinoIcons.chevron_forward, color: blanc.withOpacity(0.5), size: 10),
              const SizedBox(width: 6),
              Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: 11,
                  color: blanc,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Titre avec icône
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: blanc.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  CupertinoIcons.doc_text_fill,
                  color: blanc,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'JOURNAL',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: blanc,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Gestion des articles',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: blanc.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Stats badges
          Row(
            children: [
              _buildStatBadge(
                context,
                icon: CupertinoIcons.doc_text,
                value: '${addArticleBloc.articles.length}',
                label: 'Total',
              ),
              const SizedBox(width: 12),
              _buildStatBadge(
                context,
                icon: CupertinoIcons.checkmark_circle_fill,
                value: '${addArticleBloc.articles.where((e) => e.statusOnline == "on").length}',
                label: 'Publiés',
              ),
              const SizedBox(width: 12),
              _buildStatBadge(
                context,
                icon: CupertinoIcons.doc,
                value: '${addArticleBloc.articles.where((e) => e.statusOnline == "brouillon").length}',
                label: 'Brouillons',
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Bouton ajouter
          GestureDetector(
            onTap: () {
              addArticleBloc.resetAddArticleForm();
              menuAdminBloc.setAddArticle(1);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: blanc,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 4),
                    blurRadius: 12,
                    color: noir.withOpacity(0.2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.indigo.shade700,
                          Colors.indigo.shade500,
                          Colors.purple.shade600,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      CupertinoIcons.add,
                      color: blanc,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'NOUVEL ARTICLE',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.indigo.shade700,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatBadge(BuildContext context, {required IconData icon, required String value, required String label}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: blanc.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: blanc.withOpacity(0.3), width: 1),
        ),
        child: Column(
          children: [
            Icon(icon, color: blanc, size: 16),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: blanc,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: blanc.withOpacity(0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFiltersSection(BuildContext context, Size size, CategorieBloc categorieBloc, AddArticleBloc addArticleBloc) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: blanc,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 10,
            color: noir.withOpacity(0.05),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(CupertinoIcons.slider_horizontal_3, color: Colors.indigo.shade700, size: 18),
              const SizedBox(width: 8),
              Text(
                'FILTRES',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.indigo.shade700,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Dropdown items per page
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300, width: 1),
            ),
            child: DropdownButton<int>(
              items: [10, 15, 20, 25, 50, 100, 1000].map((value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.list_bullet, size: 14, color: gris),
                      const SizedBox(width: 8),
                      Text(
                        value == 1000 ? 'Tous les articles' : '$value par page',
                        style: TextStyle(fontSize: 12, color: noir, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                );
              }).toList(),
              value: itemsPerPage,
              isExpanded: true,
              iconSize: 0.0,
              elevation: 2,
              focusColor: Colors.transparent,
              underline: const SizedBox(),
              padding: const EdgeInsets.all(0),
              onChanged: (value) {
                setState(() {
                  itemsPerPage = value!;
                  currentPage = 1;
                });
              },
            ),
          ),
          // Dropdown catégories
          if (categorieBloc.categories.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300, width: 1),
              ),
              child: DropdownButton(
                items: [
                  DropdownMenuItem(
                    value: null,
                    child: Row(
                      children: [
                        Icon(CupertinoIcons.square_grid_2x2, size: 14, color: gris),
                        const SizedBox(width: 8),
                        Text(
                          'TOUTES LES CATÉGORIES',
                          style: TextStyle(fontSize: 12, color: noir, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  ...categorieBloc.categories.map((e) => DropdownMenuItem(
                    value: e,
                    child: Row(
                      children: [
                        Icon(CupertinoIcons.square_grid_2x2_fill, size: 14, color: Colors.indigo.shade700),
                        const SizedBox(width: 8),
                        Text(
                          e.titre!,
                          style: TextStyle(fontSize: 12, color: noir, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  )),
                ],
                value: categorieBloc.categorie,
                isExpanded: true,
                iconSize: 0.0,
                elevation: 2,
                focusColor: Colors.transparent,
                underline: const SizedBox(),
                padding: const EdgeInsets.all(0),
                onChanged: (v) {
                  categorieBloc.setCategorie(v);
                  setState(() {
                    currentPage = 1;
                  });
                },
              ),
            ),
          // Dropdown status
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300, width: 1),
            ),
            child: DropdownButton<String>(
              items: [
                DropdownMenuItem(
                  value: 'all',
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.list_bullet, size: 14, color: gris),
                      const SizedBox(width: 8),
                      Text('Tous', style: TextStyle(fontSize: 12, color: noir, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'on',
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.checkmark_circle, size: 14, color: vert),
                      const SizedBox(width: 8),
                      Text('Publiés', style: TextStyle(fontSize: 12, color: noir, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'brouillon',
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.doc, size: 14, color: Colors.orange),
                      const SizedBox(width: 8),
                      Text('Brouillons', style: TextStyle(fontSize: 12, color: noir, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'archive',
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.archivebox, size: 14, color: gris),
                      const SizedBox(width: 8),
                      Text('Archivés', style: TextStyle(fontSize: 12, color: noir, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ],
              value: addArticleBloc.statusNews,
              isExpanded: true,
              iconSize: 0.0,
              elevation: 2,
              focusColor: Colors.transparent,
              underline: const SizedBox(),
              padding: const EdgeInsets.all(0),
              onChanged: (v) {
                addArticleBloc.setStatusNews(v!);
                setState(() {
                  currentPage = 1;
                });
              },
            ),
          ),
          // Champ de recherche
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300, width: 1),
            ),
            child: TextField(
              controller: addArticleBloc.recherche,
              decoration: InputDecoration(
                hintText: "Rechercher un article...",
                hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade400, fontWeight: FontWeight.w500),
                prefixIcon: Icon(CupertinoIcons.search, size: 18, color: Colors.grey.shade400),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              onChanged: (value) {
                addArticleBloc.setRecherche(value);
                setState(() {
                  currentPage = 1;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticlesCard(BuildContext context, Size size, AddArticleBloc addArticleBloc, CategorieBloc categorieBloc, TagsBloc tagsBloc) {
    final filteredArticles = _getFilteredArticles(addArticleBloc, categorieBloc);
    final paginatedArticles = _getPaginatedArticles(addArticleBloc, categorieBloc);
    final totalPages = _getTotalPages(addArticleBloc, categorieBloc);

    return Column(
      children: [
        // Liste des articles en cartes
        if (paginatedArticles.isEmpty)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: blanc,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200, width: 1),
            ),
            child: Column(
              children: [
                Icon(
                  CupertinoIcons.doc_text,
                  size: 48,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 16),
                Text(
                  'Aucun article trouvé',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: gris,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Modifiez vos filtres ou créez un nouvel article',
                  style: TextStyle(
                    fontSize: 12,
                    color: gris.withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        else
          ...paginatedArticles.map((article) => _buildArticleCard(
            context,
            article,
            addArticleBloc,
            categorieBloc,
            tagsBloc,
          )),
        // Pagination
        if (totalPages > 1 && paginatedArticles.isNotEmpty) ...[
          const SizedBox(height: 16),
          _buildPagination(context, filteredArticles, totalPages),
        ],
      ],
    );
  }


  Widget _buildPagination(BuildContext context, List<dynamic> filteredArticles, int totalPages) {
    final startIndex = (currentPage - 1) * itemsPerPage + 1;
    final endIndex = (currentPage * itemsPerPage) > filteredArticles.length
        ? filteredArticles.length
        : currentPage * itemsPerPage;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: blanc,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 8,
            color: noir.withOpacity(0.04),
          ),
        ],
      ),
      child: Column(
        children: [
          // Counter
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  CupertinoIcons.doc_text_fill,
                  size: 16,
                  color: Colors.indigo.shade700,
                ),
                const SizedBox(width: 8),
                Text(
                  'Affichage de $startIndex à $endIndex sur ${filteredArticles.length}',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.indigo.shade700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Pagination buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Previous button
              _buildPaginationButton(
                icon: CupertinoIcons.chevron_left,
                enabled: currentPage > 1,
                onTap: () {
                  if (currentPage > 1) {
                    setState(() {
                      currentPage--;
                    });
                  }
                },
              ),
              const SizedBox(width: 12),
              // Page numbers
              ..._buildPageNumbers(totalPages),
              const SizedBox(width: 12),
              // Next button
              _buildPaginationButton(
                icon: CupertinoIcons.chevron_right,
                enabled: currentPage < totalPages,
                onTap: () {
                  if (currentPage < totalPages) {
                    setState(() {
                      currentPage++;
                    });
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageNumbers(int totalPages) {
    List<Widget> pages = [];
    int startPage = currentPage - 2;
    int endPage = currentPage + 2;

    if (startPage < 1) {
      startPage = 1;
      endPage = totalPages < 5 ? totalPages : 5;
    }

    if (endPage > totalPages) {
      endPage = totalPages;
      startPage = totalPages - 4 > 0 ? totalPages - 4 : 1;
    }

    for (int i = startPage; i <= endPage; i++) {
      pages.add(
        GestureDetector(
          onTap: () {
            setState(() {
              currentPage = i;
            });
          },
          child: Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              gradient: currentPage == i
                  ? LinearGradient(
                      colors: [
                        Colors.indigo.shade700,
                        Colors.indigo.shade500,
                        Colors.purple.shade600,
                      ],
                    )
                  : null,
              color: currentPage == i ? null : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: currentPage == i ? Colors.transparent : Colors.grey.shade300,
                width: 1,
              ),
              boxShadow: currentPage == i
                  ? [
                      BoxShadow(
                        offset: const Offset(0, 4),
                        blurRadius: 12,
                        color: Colors.indigo.withOpacity(0.3),
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: Text(
                '$i',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: currentPage == i ? FontWeight.w700 : FontWeight.w600,
                  color: currentPage == i ? blanc : noir,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return pages;
  }

  Widget _buildPaginationButton({
    required IconData icon,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: enabled ? Colors.grey.shade100 : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: enabled ? Colors.grey.shade300 : Colors.grey.shade200,
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          size: 16,
          color: enabled ? noir : Colors.grey.shade400,
        ),
      ),
    );
  }

  Widget _buildArticleCard(
    BuildContext context,
    dynamic article,
    AddArticleBloc addArticleBloc,
    CategorieBloc categorieBloc,
    TagsBloc tagsBloc,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: blanc,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 8,
            color: noir.withOpacity(0.04),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête avec auteur et actions
          Row(
            children: [
              // Avatar auteur
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.indigo.shade700,
                      Colors.indigo.shade500,
                      Colors.purple.shade600,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${article.author?.prenom?.substring(0, 1) ?? 'A'}${article.author?.nom?.substring(0, 1) ?? 'U'}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: blanc,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Nom auteur
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${article.author?.prenom ?? 'Auteur'} ${article.author?.nom ?? 'Inconnu'}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: noir,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      article.date != null
                          ? _formatDate(article.date!)
                          : '',
                      style: TextStyle(
                        fontSize: 11,
                        color: gris,
                      ),
                    ),
                  ],
                ),
              ),
              // Actions
              Row(
                children: [
                  GestureDetector(
                    onTap: () => addArticleBloc.setArticle(
                      article,
                      1,
                      categorieBloc: categorieBloc,
                      tagsBloc: tagsBloc,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        CupertinoIcons.pencil,
                        size: 18,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () async {
                      final result = await dialogRequest(
                        title: 'Voulez-vous ${article.statusOnline! == "on" ? "supprimer" : "publier"} cet article ?',
                        context: context,
                      );
                      if (result) {
                        addArticleBloc.setArticle(
                          article,
                          0,
                          categorieBloc: categorieBloc,
                          tagsBloc: tagsBloc,
                        );
                        addArticleBloc.activeArticle();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: article.statusOnline! == "on"
                            ? Colors.red.shade50
                            : Colors.green.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        article.statusOnline! == "on"
                            ? CupertinoIcons.trash
                            : CupertinoIcons.checkmark_circle,
                        size: 18,
                        color: article.statusOnline! == "on"
                            ? Colors.red.shade700
                            : Colors.green.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Catégorie
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              article.categorie!.titre! != "CHOIX DE LA REDACTION"
                  ? article.categorie!.titre!
                  : 'CHOIX DE LA RÉDACTION',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.indigo.shade700,
                letterSpacing: 0.3,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Titre
          Text(
            article.titre!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: noir,
              height: 1.4,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          // Statut
          if (article.statusOnline != null) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: article.statusOnline! == "on"
                        ? Colors.green.shade500
                        : Colors.orange.shade500,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  article.statusOnline! == "on" ? 'Publié' : 'Brouillon',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: article.statusOnline! == "on"
                        ? Colors.green.shade700
                        : Colors.orange.shade700,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays == 0) {
        if (difference.inHours == 0) {
          return 'Il y a ${difference.inMinutes}min';
        }
        return 'Il y a ${difference.inHours}h';
      } else if (difference.inDays < 7) {
        return 'Il y a ${difference.inDays}j';
      } else {
        return '${date.day}/${date.month}/${date.year}';
      }
    } catch (e) {
      return '';
    }
  }
}
