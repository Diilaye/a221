import 'package:actu/bloc/administrateur/flash-news-bloc.dart';
import 'package:actu/bloc/administrateur/menu-admin.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/flash-news/add-flash-news.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/flash-news/update-flash-news.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/diallog-dii.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlashNewsScreenMobile extends StatefulWidget {
  const FlashNewsScreenMobile({super.key});

  @override
  State<FlashNewsScreenMobile> createState() => _FlashNewsScreenMobileState();
}

class _FlashNewsScreenMobileState extends State<FlashNewsScreenMobile> {
  int itemsPerPage = 10;
  int currentPage = 1;
  String searchQuery = '';
  String statusFilter = 'all';

  List<dynamic> _getFilteredFlashNews(FlashNewsBloc flashNewsBloc) {
    return flashNewsBloc.flashNews.where((e) {
      bool matchesSearch = searchQuery.isEmpty ||
          e.desc!.toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = statusFilter == 'all' ||
          e.statusOnline! == statusFilter;
      
      return matchesSearch && matchesStatus;
    }).toList();
  }

  List<dynamic> _getPaginatedFlashNews(FlashNewsBloc flashNewsBloc) {
    final filtered = _getFilteredFlashNews(flashNewsBloc);
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    return filtered.sublist(
      startIndex,
      endIndex > filtered.length ? filtered.length : endIndex,
    );
  }

  int _getTotalPages(FlashNewsBloc flashNewsBloc) {
    final filtered = _getFilteredFlashNews(flashNewsBloc);
    return (filtered.length / itemsPerPage).ceil();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final menuAdminBloc = Provider.of<MenuAdminBloc>(context);
    final flashNewsBloc = Provider.of<FlashNewsBloc>(context);

    return Stack(
      children: [
        if (menuAdminBloc.addFlashNews == 0 && flashNewsBloc.showUpdate == 0)
          Container(
            color: Colors.grey.shade50,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildHeader(context, size, menuAdminBloc),
                const SizedBox(height: 20),
                _buildFiltersSection(context, size),
                const SizedBox(height: 20),
                _buildFlashNewsList(context, size, flashNewsBloc),
              ],
            ),
          ),
        if (menuAdminBloc.addFlashNews == 1)
          Positioned(
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: const AddFlashNewsScreen(),
            ),
          ),
        if (flashNewsBloc.showUpdate == 1)
          Positioned(
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: const UpdateFlashNewsScreen(),
            ),
          ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, Size size, MenuAdminBloc menuAdminBloc) {
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
                'Flash News',
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
          // Titre avec actions
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: blanc.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  CupertinoIcons.bolt_fill,
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
                      'FLASH NEWS',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: blanc,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Gestion des actualités rapides',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: blanc.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => menuAdminBloc.setFlashNews(1),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: blanc,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 2),
                        blurRadius: 8,
                        color: noir.withOpacity(0.1),
                      ),
                    ],
                  ),
                  child: Icon(
                    CupertinoIcons.add,
                    color: Colors.indigo.shade700,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersSection(BuildContext context, Size size) {
    return Container(
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
          Row(
            children: [
              Icon(CupertinoIcons.slider_horizontal_3, size: 16, color: Colors.indigo.shade700),
              const SizedBox(width: 8),
              Text(
                'FILTRES',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.indigo.shade700,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Dropdown Status
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
                      Icon(CupertinoIcons.check_mark_circled, size: 14, color: gris),
                      const SizedBox(width: 8),
                      Text(
                        'TOUS LES STATUTS',
                        style: TextStyle(fontSize: 12, color: noir, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'on',
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.checkmark_circle_fill, size: 14, color: Colors.green.shade700),
                      const SizedBox(width: 8),
                      Text(
                        'EN LIGNE',
                        style: TextStyle(fontSize: 12, color: noir, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'off',
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.xmark_circle_fill, size: 14, color: Colors.orange.shade700),
                      const SizedBox(width: 8),
                      Text(
                        'HORS LIGNE',
                        style: TextStyle(fontSize: 12, color: noir, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
              value: statusFilter,
              isExpanded: true,
              iconSize: 0.0,
              elevation: 2,
              focusColor: Colors.transparent,
              underline: const SizedBox(),
              padding: const EdgeInsets.all(0),
              onChanged: (v) {
                setState(() {
                  statusFilter = v!;
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
              decoration: InputDecoration(
                hintText: "Rechercher une flash news...",
                hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade400, fontWeight: FontWeight.w500),
                prefixIcon: Icon(CupertinoIcons.search, size: 18, color: Colors.grey.shade400),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                  currentPage = 1;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlashNewsList(BuildContext context, Size size, FlashNewsBloc flashNewsBloc) {
    final filteredFlashNews = _getFilteredFlashNews(flashNewsBloc);
    final paginatedFlashNews = _getPaginatedFlashNews(flashNewsBloc);
    final totalPages = _getTotalPages(flashNewsBloc);

    return Column(
      children: [
        // Liste des flash news en cartes
        if (paginatedFlashNews.isEmpty)
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
                  CupertinoIcons.bolt,
                  size: 48,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 16),
                Text(
                  'Aucune flash news trouvée',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: gris,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Modifiez vos filtres ou créez une nouvelle flash news',
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
          ...paginatedFlashNews.map((flashNews) => _buildFlashNewsCard(
            context,
            flashNews,
            flashNewsBloc,
          )),
        // Pagination
        if (totalPages > 1 && paginatedFlashNews.isNotEmpty) ...[
          const SizedBox(height: 16),
          _buildPagination(context, filteredFlashNews, totalPages),
        ],
      ],
    );
  }

  Widget _buildFlashNewsCard(
    BuildContext context,
    dynamic flashNews,
    FlashNewsBloc flashNewsBloc,
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
                  '${flashNews.author!.prenom!.substring(0, 1)}${flashNews.author!.nom!.substring(0, 1)}',
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
                      '${flashNews.author!.prenom} ${flashNews.author!.nom}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: noir,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: flashNews.statusOnline! == "on"
                                ? Colors.green.shade500
                                : Colors.orange.shade500,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          flashNews.statusOnline! == "on" ? 'En ligne' : 'Hors ligne',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: flashNews.statusOnline! == "on"
                                ? Colors.green.shade700
                                : Colors.orange.shade700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Actions
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      flashNewsBloc.setFlashNews(flashNews);
                      flashNewsBloc.setShowUpdate(1);
                    },
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
                        title: flashNews.statusOnline! == "on"
                            ? 'Voulez-vous mettre cette flash news hors ligne ?'
                            : 'Voulez-vous remettre cette flash news en ligne ?',
                        context: context,
                      );
                      if (result) {
                        flashNewsBloc.setFlashNews(flashNews);
                        flashNewsBloc.active();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: flashNews.statusOnline! == "on"
                            ? Colors.red.shade50
                            : Colors.green.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        flashNews.statusOnline! == "on"
                            ? CupertinoIcons.trash
                            : CupertinoIcons.checkmark_circle,
                        size: 18,
                        color: flashNews.statusOnline! == "on"
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
          // Badge Flash News
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  CupertinoIcons.bolt_fill,
                  size: 12,
                  color: Colors.amber.shade700,
                ),
                const SizedBox(width: 6),
                Text(
                  'FLASH NEWS',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Colors.amber.shade700,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Description
          Text(
            flashNews.desc!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: noir,
              height: 1.4,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildPagination(BuildContext context, List<dynamic> filteredFlashNews, int totalPages) {
    final startIndex = (currentPage - 1) * itemsPerPage + 1;
    final endIndex = (currentPage * itemsPerPage) > filteredFlashNews.length
        ? filteredFlashNews.length
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
                  CupertinoIcons.bolt_fill,
                  size: 16,
                  color: Colors.indigo.shade700,
                ),
                const SizedBox(width: 8),
                Text(
                  'Affichage de $startIndex à $endIndex sur ${filteredFlashNews.length}',
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
}
