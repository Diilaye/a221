// import 'package:actu/bloc/administrateur/article-bloc.dart';
import 'package:actu/bloc/administrateur/menu-admin.dart';
import 'package:actu/bloc/administrateur/post-digiteaux-bloc.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPostDigiteauxScreen extends StatefulWidget {
  const AddPostDigiteauxScreen({super.key});

  @override
  State<AddPostDigiteauxScreen> createState() => _AddPostDigiteauxScreenState();
}

class _AddPostDigiteauxScreenState extends State<AddPostDigiteauxScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final menuAdminBloc = Provider.of<MenuAdminBloc>(context);
    final postsDigiteauxBloc = Provider.of<PostsDigiteauxBloc>(context);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(-5, 0),
            ),
          ],
        ),
        child: postsDigiteauxBloc.parcourirFile == 0
            ? _buildMainForm(context, postsDigiteauxBloc, menuAdminBloc)
            : _buildMediaBrowser(context, postsDigiteauxBloc),
      ),
    );
  }

  Widget _buildMainForm(BuildContext context, PostsDigiteauxBloc postsDigiteauxBloc, MenuAdminBloc menuAdminBloc) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _buildHeader(context, menuAdminBloc),
        const SizedBox(height: 32),
        _buildFormContent(context, postsDigiteauxBloc),
        const SizedBox(height: 32),
        _buildActions(context, postsDigiteauxBloc, menuAdminBloc),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, MenuAdminBloc menuAdminBloc) {
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
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              CupertinoIcons.photo_fill_on_rectangle_fill,
              color: blanc,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NOUVEAU POST DIGITAL',
                  style: TextStyle(
                    color: blanc,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Créez un nouveau post pour vos réseaux sociaux',
                  style: TextStyle(
                    color: blanc.withOpacity(0.9),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => menuAdminBloc.setPresseEcrite(0),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(CupertinoIcons.xmark, color: blanc, size: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormContent(BuildContext context, PostsDigiteauxBloc postsDigiteauxBloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            context: context,
            label: 'TITRE DU POST',
            hint: 'Entrez le titre du post',
            icon: CupertinoIcons.textformat,
            controller: postsDigiteauxBloc.titre,
          ),
          const SizedBox(height: 24),
          
          _buildImageUploadSection(context, postsDigiteauxBloc),
          const SizedBox(height: 24),
          
          _buildTypeSection(context, postsDigiteauxBloc),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.purple.shade700, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: noir.withOpacity(0.7),
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: TextField(
            controller: controller,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: noir,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.grey.shade400,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageUploadSection(BuildContext context, PostsDigiteauxBloc postsDigiteauxBloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(CupertinoIcons.photo, color: Colors.purple.shade700, size: 18),
            const SizedBox(width: 8),
            Text(
              'IMAGE DU POST',
              style: TextStyle(
                color: noir.withOpacity(0.7),
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        
        Row(
          children: [
            if (postsDigiteauxBloc.imagePost[0] == null)
              Expanded(
                child: _buildImageUploadButton(
                  context: context,
                  label: 'PARCOURIR LA BIBLIOTHÈQUE',
                  icon: CupertinoIcons.folder_fill,
                  onTap: () => postsDigiteauxBloc.setParcourirFile(1),
                  isSelected: postsDigiteauxBloc.fileModel != null,
                  gradient: LinearGradient(
                    colors: [Colors.purple.shade600, Colors.purple.shade400],
                  ),
                  imageUrl: postsDigiteauxBloc.fileModel != null
                      ? BASE_URL_ASSET + postsDigiteauxBloc.fileModel!.url!
                      : null,
                ),
              ),
            if (postsDigiteauxBloc.imagePost[0] == null)
              const SizedBox(width: 16),
            if (postsDigiteauxBloc.fileModel == null)
              Expanded(
                child: _buildImageUploadButton(
                  context: context,
                  label: 'UPLOADER UN FICHIER',
                  icon: CupertinoIcons.cloud_upload_fill,
                  onTap: () => postsDigiteauxBloc.getImagePost(),
                  isSelected: postsDigiteauxBloc.imagePost[0] != null,
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade600, Colors.blue.shade400],
                  ),
                  imageBytes: postsDigiteauxBloc.imagePost[0] != null
                      ? postsDigiteauxBloc.imagePost[1]
                      : null,
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildImageUploadButton({
    required BuildContext context,
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    required bool isSelected,
    required LinearGradient gradient,
    String? imageUrl,
    dynamic imageBytes,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 200,
          decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(
                    colors: [Colors.green.shade600, Colors.green.shade400],
                  )
                : gradient,
            borderRadius: BorderRadius.circular(16),
            image: (imageUrl != null || imageBytes != null)
                ? DecorationImage(
                    image: imageUrl != null
                        ? NetworkImage(imageUrl)
                        : MemoryImage(imageBytes) as ImageProvider,
                    fit: BoxFit.cover,
                  )
                : null,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: (imageUrl == null && imageBytes == null)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, color: blanc, size: 48),
                    const SizedBox(height: 12),
                    Text(
                      label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: blanc,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                )
              : Stack(
                  children: [
                    if (isSelected)
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.green.shade600, Colors.green.shade400],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Icon(
                            CupertinoIcons.checkmark,
                            color: blanc,
                            size: 20,
                          ),
                        ),
                      ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildTypeSection(BuildContext context, PostsDigiteauxBloc postsDigiteauxBloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(CupertinoIcons.tag_fill, color: Colors.purple.shade700, size: 18),
            const SizedBox(width: 8),
            Text(
              'TYPE DE POST',
              style: TextStyle(
                color: noir.withOpacity(0.7),
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        
        Row(
          children: [
            Expanded(
              child: _buildTypeButton(
                context: context,
                label: 'ESSENTIEL DU JOUR',
                icon: CupertinoIcons.star_fill,
                isSelected: postsDigiteauxBloc.typePost == 0,
                onTap: () => postsDigiteauxBloc.settypePost(0),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTypeButton(
                context: context,
                label: 'POST COMMERCIAL',
                icon: CupertinoIcons.briefcase_fill,
                isSelected: postsDigiteauxBloc.typePost == 1,
                onTap: () => postsDigiteauxBloc.settypePost(1),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTypeButton({
    required BuildContext context,
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(
                    colors: [Colors.purple.shade700, Colors.purple.shade500],
                  )
                : null,
            color: isSelected ? null : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? Colors.purple.shade700 : Colors.grey.shade200,
              width: 2,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? blanc : noir.withOpacity(0.6),
                size: 24,
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected ? blanc : noir.withOpacity(0.8),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActions(BuildContext context, PostsDigiteauxBloc postsDigiteauxBloc, MenuAdminBloc menuAdminBloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => menuAdminBloc.setPresseEcrite(0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    Icon(CupertinoIcons.xmark, color: noir.withOpacity(0.7), size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'ANNULER',
                      style: TextStyle(
                        color: noir.withOpacity(0.8),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => postsDigiteauxBloc.addPost(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple.shade700, Colors.purple.shade500],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    if (postsDigiteauxBloc.chargement)
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(blanc),
                        ),
                      )
                    else
                      Icon(CupertinoIcons.add_circled_solid, color: blanc, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      postsDigiteauxBloc.chargement ? 'AJOUT EN COURS...' : 'AJOUTER LE POST',
                      style: TextStyle(
                        color: blanc,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
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
    );
  }

  Widget _buildMediaBrowser(BuildContext context, PostsDigiteauxBloc postsDigiteauxBloc) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade700, Colors.blue.shade500],
            ),
          ),
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
                    child: Icon(CupertinoIcons.photo_fill, color: blanc, size: 32),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'BIBLIOTHÈQUE MÉDIA',
                      style: TextStyle(
                        color: blanc,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        postsDigiteauxBloc.setFileModel(null);
                        postsDigiteauxBloc.setParcourirFile(0);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(CupertinoIcons.xmark, color: blanc, size: 24),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  onChanged: (value) => postsDigiteauxBloc.setRecherche(value),
                  style: TextStyle(fontSize: 14, color: noir),
                  decoration: InputDecoration(
                    hintText: 'Rechercher un média...',
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    prefixIcon: Icon(CupertinoIcons.search, color: Colors.grey.shade600),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
        
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: GridView.count(
              crossAxisCount: 5,
              childAspectRatio: 0.8,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: postsDigiteauxBloc.filesModel.reversed
                  .where((e) => e.url!
                      .split("/")
                      .last
                      .toLowerCase()
                      .contains(postsDigiteauxBloc.recherche.toLowerCase()))
                  .map((e) {
                final isSelected = e == postsDigiteauxBloc.fileModel;
                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => postsDigiteauxBloc.setFileModel(e),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? Colors.green : Colors.grey.shade200,
                          width: isSelected ? 3 : 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isSelected
                                ? Colors.green.withOpacity(0.3)
                                : Colors.black.withOpacity(0.05),
                            blurRadius: isSelected ? 15 : 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Column(
                              children: [
                                Expanded(
                                  child: CachedNetworkImage(
                                    imageUrl: BASE_URL_ASSET + e.url!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.purple.shade700,
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => const Center(
                                      child: Icon(CupertinoIcons.exclamationmark_triangle),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  color: Colors.grey.shade50,
                                  child: Center(
                                    child: Text(
                                      e.url!.split("/").last.split(".")[
                                          e.url!.split("/").last.split(".").length - 2],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: noir.withOpacity(0.7),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.green.shade600, Colors.green.shade400],
                                  ),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  CupertinoIcons.checkmark,
                                  color: blanc,
                                  size: 16,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    postsDigiteauxBloc.setFileModel(null);
                    postsDigiteauxBloc.setParcourirFile(0);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      children: [
                        Icon(CupertinoIcons.xmark, color: noir.withOpacity(0.7), size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'ANNULER',
                          style: TextStyle(
                            color: noir.withOpacity(0.8),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              
              MouseRegion(
                cursor: postsDigiteauxBloc.fileModel != null
                    ? SystemMouseCursors.click
                    : SystemMouseCursors.basic,
                child: GestureDetector(
                  onTap: postsDigiteauxBloc.fileModel != null
                      ? () => postsDigiteauxBloc.setParcourirFile(0)
                      : null,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    decoration: BoxDecoration(
                      gradient: postsDigiteauxBloc.fileModel != null
                          ? LinearGradient(
                              colors: [Colors.green.shade600, Colors.green.shade400],
                            )
                          : LinearGradient(
                              colors: [Colors.grey.shade300, Colors.grey.shade300],
                            ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: postsDigiteauxBloc.fileModel != null
                          ? [
                              BoxShadow(
                                color: Colors.green.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ]
                          : [],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.checkmark_circle_fill,
                          color: blanc,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'SÉLECTIONNER',
                          style: TextStyle(
                            color: blanc,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
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
        ),
      ],
    );
  }}