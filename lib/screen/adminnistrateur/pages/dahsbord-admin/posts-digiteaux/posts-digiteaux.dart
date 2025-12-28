import 'package:actu/bloc/administrateur/menu-admin.dart';
import 'package:actu/bloc/administrateur/post-digiteaux-bloc.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/posts-digiteaux/add-post-digiteaux.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/posts-digiteaux/update-post-digiteaux.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/diallog-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostDigiteauxScreen extends StatefulWidget {
  const PostDigiteauxScreen({super.key});

  @override
  State<PostDigiteauxScreen> createState() => _PostDigiteauxScreenState();
}

class _PostDigiteauxScreenState extends State<PostDigiteauxScreen> {
  int itemsPerPage = 10;
  String statusFilter = 'Tous les status';
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final menuAdminBloc = Provider.of<MenuAdminBloc>(context);
    final postsDigiteauxBloc = Provider.of<PostsDigiteauxBloc>(context);

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.grey.shade50,
                Colors.white,
                Colors.grey.shade50,
              ],
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              _buildHeroHeader(context, postsDigiteauxBloc, menuAdminBloc),
              const SizedBox(height: 32),
              _buildFiltersSection(context, size),
              const SizedBox(height: 32),
              _buildPostsGrid(context, size, postsDigiteauxBloc),
              const SizedBox(height: 32),
              _buildPagination(context, postsDigiteauxBloc),
              const SizedBox(height: 32),
            ],
          ),
        ),
        if (menuAdminBloc.addPresseEcrite == 1)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: size.width * .8,
              height: size.height,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(-5, 0),
                  ),
                ],
              ),
              child: const AddPostDigiteauxScreen(),
            ),
          ),
        if (postsDigiteauxBloc.showUpdate == 1)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: size.width * .8,
              height: size.height,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(-5, 0),
                  ),
                ],
              ),
              child: const UpdatePostDigiteauxScreen(),
            ),
          ),
      ],
    );
  }

  Widget _buildHeroHeader(BuildContext context, PostsDigiteauxBloc postsDigiteauxBloc, MenuAdminBloc menuAdminBloc) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.purple.shade700,
            Colors.purple.shade500,
            Colors.deepPurple.shade600,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.3),
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
                    Text('Posts Digitaux', style: TextStyle(color: blanc, fontSize: 12, fontWeight: FontWeight.w500)),
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
                          child: Icon(CupertinoIcons.photo_fill_on_rectangle_fill, color: blanc, size: 32),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'POSTS DIGITAUX',
                              style: TextStyle(
                                color: blanc,
                                fontSize: 32,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Gérez vos publications sur les réseaux sociaux',
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
                          icon: CupertinoIcons.photo_fill,
                          label: 'Total',
                          value: '${postsDigiteauxBloc.posts.length}',
                        ),
                        const SizedBox(width: 16),
                        _buildStatCard(
                          icon: CupertinoIcons.checkmark_circle_fill,
                          label: 'En ligne',
                          value: '${postsDigiteauxBloc.posts.where((e) => e.statusOnline == "on").length}',
                          color: vert,
                        ),
                        const SizedBox(width: 16),
                        _buildStatCard(
                          icon: CupertinoIcons.doc_text,
                          label: 'Brouillons',
                          value: '${postsDigiteauxBloc.posts.where((e) => e.statusOnline != "on").length}',
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
                  onTap: () => menuAdminBloc.setPresseEcrite(1),
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
                        Icon(CupertinoIcons.add_circled_solid, color: Colors.purple.shade700, size: 24),
                        const SizedBox(width: 12),
                        Text(
                          'NOUVEAU POST',
                          style: TextStyle(
                            color: Colors.purple.shade700,
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

  Widget _buildFiltersSection(BuildContext context, Size size) {
    return Container(
      padding: const EdgeInsets.all(24),
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
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
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
                  currentPage = 1; // Retour à la première page
                });
              },
            ),
          ),
          const SizedBox(width: 24),
          
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
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
                  currentPage = 1; // Retour à la première page
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  List<dynamic> _getFilteredPosts(PostsDigiteauxBloc postsDigiteauxBloc) {
    List<dynamic> filtered = postsDigiteauxBloc.posts;

    // Appliquer le filtre de statut
    if (statusFilter == 'En ligne') {
      filtered = filtered.where((post) => post.statusOnline == "on").toList();
    } else if (statusFilter == 'Brouillons') {
      filtered = filtered.where((post) => post.statusOnline != "on").toList();
    }

    return filtered;
  }

  List<dynamic> _getPaginatedPosts(PostsDigiteauxBloc postsDigiteauxBloc) {
    final filtered = _getFilteredPosts(postsDigiteauxBloc);
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    
    if (startIndex >= filtered.length) return [];
    return filtered.sublist(
      startIndex,
      endIndex > filtered.length ? filtered.length : endIndex,
    );
  }

  int _getTotalPages(PostsDigiteauxBloc postsDigiteauxBloc) {
    final filtered = _getFilteredPosts(postsDigiteauxBloc);
    return (filtered.length / itemsPerPage).ceil();
  }

  Widget _buildPostsGrid(BuildContext context, Size size, PostsDigiteauxBloc postsDigiteauxBloc) {
    final paginatedPosts = _getPaginatedPosts(postsDigiteauxBloc);
    
    if (paginatedPosts.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Column(
            children: [
              Icon(
                CupertinoIcons.photo,
                size: 64,
                color: Colors.grey.shade300,
              ),
              const SizedBox(height: 16),
              Text(
                'Aucun post trouvé',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.8,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
      ),
      itemCount: paginatedPosts.length,
      itemBuilder: (context, index) {
        final post = paginatedPosts[index];
        return _buildPostCard(context, post, postsDigiteauxBloc);
      },
    );
  }

  Widget _buildPostCard(BuildContext context, dynamic post, PostsDigiteauxBloc postsDigiteauxBloc) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: Image.network(
                    BASE_URL_ASSET + post.image!.url!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.purple.shade600, Colors.deepPurple.shade400],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(CupertinoIcons.share, color: blanc, size: 12),
                        const SizedBox(width: 6),
                        Text(
                          post.type!.toUpperCase(),
                          style: TextStyle(
                            color: blanc,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: post.statusOnline == "on" 
                        ? vert.withOpacity(0.9)
                        : Colors.orange.withOpacity(0.9),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      post.statusOnline == "on"
                        ? CupertinoIcons.checkmark
                        : CupertinoIcons.doc_text,
                      color: blanc,
                      size: 14,
                    ),
                  ),
                ),
              ],
            ),
            
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(CupertinoIcons.calendar, color: noir.withOpacity(0.5), size: 14),
                        const SizedBox(width: 6),
                        Text(
                          post.date!.split("T")[0].split("-").reversed.join('/'),
                          style: TextStyle(
                            color: noir.withOpacity(0.6),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    
                    Row(
                      children: [
                        Expanded(
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                postsDigiteauxBloc.setPost(post);
                                postsDigiteauxBloc.setShowUpdate(1);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8),
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
                        ),
                        const SizedBox(width: 8),
                        
                        Expanded(
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () async {
                                final confirm = await dialogRequest(
                                  title: post.statusOnline == "on"
                                    ? 'Supprimer ce post ?'
                                    : 'Publier ce post ?',
                                  context: context,
                                );
                                if (confirm) {
                                  postsDigiteauxBloc.setPost(post);
                                  postsDigiteauxBloc.activePost();
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: post.statusOnline == "on"
                                    ? Colors.red.shade50
                                    : Colors.green.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  post.statusOnline == "on"
                                    ? CupertinoIcons.delete
                                    : CupertinoIcons.arrow_up_circle,
                                  color: post.statusOnline == "on"
                                    ? Colors.red
                                    : Colors.green,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildPagination(BuildContext context, PostsDigiteauxBloc postsDigiteauxBloc) {
    final filteredPosts = _getFilteredPosts(postsDigiteauxBloc);
    final totalPages = _getTotalPages(postsDigiteauxBloc);
    final startIndex = (currentPage - 1) * itemsPerPage + 1;
    final endIndex = (currentPage * itemsPerPage) > filteredPosts.length
        ? filteredPosts.length
        : currentPage * itemsPerPage;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            "Affichage de $startIndex à $endIndex sur ${filteredPosts.length} posts",
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
                              colors: [Colors.purple.shade700, Colors.purple.shade500],
                            )
                          : null,
                        color: isActive ? null : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isActive ? Colors.purple.shade700 : Colors.grey.shade300,
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
