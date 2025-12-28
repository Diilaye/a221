import 'package:actu/bloc/administrateur/menu-admin.dart';
import 'package:actu/bloc/administrateur/tags-bloc.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/params/tags/add-tag-screen.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/params/tags/update-tag-screen.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/diallog-dii.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TagScreen extends StatefulWidget {
  const TagScreen({super.key});

  @override
  State<TagScreen> createState() => _TagScreenState();
}

class _TagScreenState extends State<TagScreen> {
  int itemsPerPage = 10;
  String statusFilter = 'Tous les status';
  int currentPage = 1;

  List<dynamic> _getFilteredTags(TagsBloc tagsBloc) {
    List<dynamic> filtered = tagsBloc.tags;

    if (tagsBloc.rechercheT.isNotEmpty) {
      filtered = filtered
          .where((tag) => tag.titre!
              .toLowerCase()
              .contains(tagsBloc.rechercheT.toLowerCase()))
          .toList();
    }

    if (statusFilter == 'En ligne') {
      filtered = filtered.where((tag) => tag.statusOnline == "on").toList();
    } else if (statusFilter == 'Brouillons') {
      filtered = filtered.where((tag) => tag.statusOnline != "on").toList();
    }

    return filtered;
  }

  List<dynamic> _getPaginatedTags(TagsBloc tagsBloc) {
    final filtered = _getFilteredTags(tagsBloc);
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;

    if (startIndex >= filtered.length) return [];
    return filtered.sublist(
      startIndex,
      endIndex > filtered.length ? filtered.length : endIndex,
    );
  }

  int _getTotalPages(TagsBloc tagsBloc) {
    final filtered = _getFilteredTags(tagsBloc);
    return (filtered.length / itemsPerPage).ceil();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final menuAdminBloc = Provider.of<MenuAdminBloc>(context);
    final tagsBloc = Provider.of<TagsBloc>(context);

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              _buildHeader(context, tagsBloc, menuAdminBloc),
              const SizedBox(height: 32),
              _buildFiltersSection(context, tagsBloc),
              const SizedBox(height: 32),
              _buildTagsTable(context, tagsBloc),
              const SizedBox(height: 32),
              if (_getFilteredTags(tagsBloc).isNotEmpty)
                _buildPagination(context, tagsBloc),
              const SizedBox(height: 32),
            ],
          ),
        ),
        if (menuAdminBloc.addTag == 1)
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: size.width * 0.64,
              decoration: BoxDecoration(
                color: blanc,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(-5, 0),
                  ),
                ],
              ),
              child: const AddTagScreen(),
            ),
          ),
        if (tagsBloc.showUpdate == 1)
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: size.width * 0.64,
              decoration: BoxDecoration(
                color: blanc,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(-5, 0),
                  ),
                ],
              ),
              child: const UpdateTagScreen(),
            ),
          ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, TagsBloc tagsBloc, MenuAdminBloc menuAdminBloc) {
    return Container(
      padding: const EdgeInsets.all(32),
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
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.3),
            blurRadius: 20,
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
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(CupertinoIcons.home, color: blanc, size: 14),
                    const SizedBox(width: 6),
                    Icon(CupertinoIcons.chevron_forward, color: blanc.withOpacity(0.7), size: 10),
                    const SizedBox(width: 6),
                    Text('Tags', style: TextStyle(color: blanc, fontSize: 12, fontWeight: FontWeight.w500)),
                    const SizedBox(width: 6),
                    Icon(CupertinoIcons.chevron_forward, color: blanc.withOpacity(0.7), size: 10),
                    const SizedBox(width: 6),
                    Text('Dashboard', style: TextStyle(color: blanc.withOpacity(0.9), fontSize: 12)),
                  ],
                ),
              ),
              const Spacer(),
              _buildHeaderAction(CupertinoIcons.printer, 'Imprimer'),
              const SizedBox(width: 12),
              _buildHeaderAction(CupertinoIcons.folder, 'Archives'),
            ],
          ),
          const SizedBox(height: 24),
          
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(CupertinoIcons.tag_fill, color: blanc, size: 32),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'TAGS',
                              style: TextStyle(
                                color: blanc,
                                fontSize: 32,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Gérez vos tags d\'articles',
                              style: TextStyle(
                                color: blanc.withOpacity(0.9),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    Row(
                      children: [
                        _buildStatCard(
                          icon: CupertinoIcons.tag,
                          label: 'Total',
                          value: '${tagsBloc.tags.length}',
                        ),
                        const SizedBox(width: 16),
                        _buildStatCard(
                          icon: CupertinoIcons.checkmark_circle_fill,
                          label: 'En ligne',
                          value: '${tagsBloc.tags.where((e) => e.statusOnline == "on").length}',
                          color: vert,
                        ),
                        const SizedBox(width: 16),
                        _buildStatCard(
                          icon: CupertinoIcons.doc_text,
                          label: 'Brouillons',
                          value: '${tagsBloc.tags.where((e) => e.statusOnline != "on").length}',
                          color: Colors.orange,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => menuAdminBloc.setTag(1),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      color: blanc,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(CupertinoIcons.add_circled_solid, color: Colors.indigo.shade700, size: 24),
                        const SizedBox(width: 12),
                        Text(
                          'NOUVEAU TAG',
                          style: TextStyle(
                            color: Colors.indigo.shade700,
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderAction(IconData icon, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: blanc, size: 20),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    Color? color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, color: color ?? blanc, size: 20),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: blanc,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  color: blanc.withOpacity(0.8),
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersSection(BuildContext context, TagsBloc tagsBloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Text(
              'Afficher',
              style: TextStyle(
                color: noir.withOpacity(0.7),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButton<int>(
                value: itemsPerPage,
                items: [10, 15, 20, 25, 50].map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text('$e', style: TextStyle(fontWeight: FontWeight.w600)),
                  );
                }).toList(),
                underline: const SizedBox(),
                onChanged: (v) {
                  setState(() {
                    itemsPerPage = v!;
                    currentPage = 1;
                  });
                },
              ),
            ),
            const SizedBox(width: 24),
            
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButton<String>(
                value: statusFilter,
                items: ['Tous les status', 'En ligne', 'Brouillons'].map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e, style: TextStyle(fontWeight: FontWeight.w600)),
                  );
                }).toList(),
                underline: const SizedBox(),
                onChanged: (v) {
                  setState(() {
                    statusFilter = v!;
                    currentPage = 1;
                  });
                },
              ),
            ),
            const SizedBox(width: 24),
            
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  onChanged: (value) {
                    tagsBloc.setRecherche(value);
                    setState(() {
                      currentPage = 1;
                    });
                  },
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    hintText: 'Rechercher un tag...',
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    prefixIcon: Icon(CupertinoIcons.search, color: Colors.grey.shade600, size: 20),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTagsTable(BuildContext context, TagsBloc tagsBloc) {
    final paginatedTags = _getPaginatedTags(tagsBloc);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'ID',
                      style: TextStyle(
                        color: noir.withOpacity(0.7),
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'DATE',
                      style: TextStyle(
                        color: noir.withOpacity(0.7),
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'TAG',
                      style: TextStyle(
                        color: noir.withOpacity(0.7),
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'STATUS',
                      style: TextStyle(
                        color: noir.withOpacity(0.7),
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'ACTIONS',
                      style: TextStyle(
                        color: noir.withOpacity(0.7),
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            if (paginatedTags.isEmpty)
              Container(
                padding: const EdgeInsets.all(48),
                child: Column(
                  children: [
                    Icon(
                      CupertinoIcons.tag,
                      size: 64,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Aucun tag trouvé',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...paginatedTags.map((e) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        '#${e.id!.substring(0, 8)}',
                        style: TextStyle(
                          color: Colors.indigo.shade700,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.calendar, color: Colors.grey.shade600, size: 14),
                          const SizedBox(width: 6),
                          Text(
                            e.date!.split("T")[0].split("-").reversed.join('/'),
                            style: TextStyle(
                              color: noir.withOpacity(0.7),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        e.titre!,
                        style: TextStyle(
                          color: noir,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: e.statusOnline! == "on"
                              ? Colors.green.shade50
                              : Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              CupertinoIcons.circle_fill,
                              size: 8,
                              color: e.statusOnline! == "on" ? vert : Colors.orange,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              e.statusOnline! == "on" ? "En ligne" : "Brouillon",
                              style: TextStyle(
                                color: e.statusOnline! == "on" ? vert : Colors.orange,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                tagsBloc.setTage(e);
                                tagsBloc.setShowUpdate(1);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  CupertinoIcons.pencil,
                                  color: Colors.blue,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () async {
                                final confirm = await dialogRequest(
                                  title: e.statusOnline! == "on"
                                      ? 'Supprimer ce tag ?'
                                      : 'Publier ce tag ?',
                                  context: context,
                                );
                                if (confirm) {
                                  tagsBloc.setTage(e);
                                  tagsBloc.activeTags();
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: e.statusOnline! == "on"
                                      ? Colors.red.shade50
                                      : Colors.green.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  e.statusOnline! == "on"
                                      ? CupertinoIcons.delete
                                      : CupertinoIcons.arrow_up_circle,
                                  color: e.statusOnline! == "on"
                                      ? Colors.red
                                      : Colors.green,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPagination(BuildContext context, TagsBloc tagsBloc) {
    final filteredTags = _getFilteredTags(tagsBloc);
    final totalPages = _getTotalPages(tagsBloc);
    final startIndex = (currentPage - 1) * itemsPerPage + 1;
    final endIndex = (currentPage * itemsPerPage) > filteredTags.length
        ? filteredTags.length
        : currentPage * itemsPerPage;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Text(
              "Affichage de $startIndex à $endIndex sur ${filteredTags.length} tags",
              style: TextStyle(
                color: noir.withOpacity(0.7),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            
            _buildPaginationButton(
              icon: CupertinoIcons.chevron_left,
              onTap: currentPage > 1
                  ? () {
                      setState(() {
                        currentPage--;
                      });
                    }
                  : null,
              isDisabled: currentPage <= 1,
            ),
            const SizedBox(width: 12),
            
            ...List.generate(
              totalPages > 5 ? 5 : totalPages,
              (index) {
                int pageNumber;
                if (totalPages <= 5) {
                  pageNumber = index + 1;
                } else {
                  if (currentPage <= 3) {
                    pageNumber = index + 1;
                  } else if (currentPage >= totalPages - 2) {
                    pageNumber = totalPages - 4 + index;
                  } else {
                    pageNumber = currentPage - 2 + index;
                  }
                }
                
                final isActive = pageNumber == currentPage;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentPage = pageNumber;
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: isActive
                            ? LinearGradient(
                                colors: [Colors.indigo.shade700, Colors.indigo.shade500],
                              )
                            : null,
                          color: isActive ? null : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isActive ? Colors.indigo.shade700 : Colors.grey.shade300,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '$pageNumber',
                            style: TextStyle(
                              color: isActive ? blanc : noir,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(width: 12),
            
            _buildPaginationButton(
              icon: CupertinoIcons.chevron_right,
              onTap: currentPage < totalPages
                  ? () {
                      setState(() {
                        currentPage++;
                      });
                    }
                  : null,
              isDisabled: currentPage >= totalPages,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaginationButton({
    required IconData icon,
    required VoidCallback? onTap,
    bool isDisabled = false,
  }) {
    return MouseRegion(
      cursor: isDisabled ? SystemMouseCursors.basic : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: isDisabled ? null : onTap,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isDisabled ? Colors.grey.shade200 : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isDisabled ? Colors.grey.shade300 : Colors.grey.shade400,
            ),
          ),
          child: Icon(
            icon,
            color: isDisabled ? Colors.grey.shade400 : noir,
            size: 18,
          ),
        ),
      ),
    );
  }
}

