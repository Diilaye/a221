import 'package:actu/bloc/administrateur/menu-admin.dart';
import 'package:actu/bloc/administrateur/post-digiteaux-bloc.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPostDigiteauxScreenMobile extends StatefulWidget {
  const AddPostDigiteauxScreenMobile({super.key});

  @override
  State<AddPostDigiteauxScreenMobile> createState() =>
      _AddPostDigiteauxScreenMobileState();
}

class _AddPostDigiteauxScreenMobileState
    extends State<AddPostDigiteauxScreenMobile> {

  @override
  Widget build(BuildContext context) {
    final menuAdminBloc = Provider.of<MenuAdminBloc>(context);
    final postsDigiteauxBloc = Provider.of<PostsDigiteauxBloc>(context);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, menuAdminBloc, postsDigiteauxBloc),
            Expanded(
              child: postsDigiteauxBloc.parcourirFile == 0
                  ? _buildMainForm(postsDigiteauxBloc, menuAdminBloc)
                  : _buildMediaSelector(postsDigiteauxBloc),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, MenuAdminBloc menuAdminBloc, PostsDigiteauxBloc postsDigiteauxBloc) {
    return Container(
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
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (postsDigiteauxBloc.parcourirFile == 1) {
                      postsDigiteauxBloc.setFileModel(null);
                      postsDigiteauxBloc.setParcourirFile(0);
                    } else {
                      menuAdminBloc.setPresseEcrite(0);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      CupertinoIcons.back,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        postsDigiteauxBloc.parcourirFile == 0 
                            ? 'NOUVEAU POST DIGITAL'
                            : 'SÉLECTIONNER UN MÉDIA',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            CupertinoIcons.home,
                            color: Colors.white70,
                            size: 12,
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'Admin',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            CupertinoIcons.chevron_right,
                            color: Colors.white70,
                            size: 12,
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'Posts Digitaux',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            CupertinoIcons.chevron_right,
                            color: Colors.white70,
                            size: 12,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              postsDigiteauxBloc.parcourirFile == 0 ? 'Nouveau' : 'Média',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainForm(PostsDigiteauxBloc postsDigiteauxBloc, MenuAdminBloc menuAdminBloc) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFormCard(postsDigiteauxBloc),
          const SizedBox(height: 20),
          _buildImageSection(postsDigiteauxBloc),
          const SizedBox(height: 20),
          _buildTypeSelector(postsDigiteauxBloc),
          const SizedBox(height: 24),
          _buildActionButtons(postsDigiteauxBloc, menuAdminBloc),
        ],
      ),
    );
  }

  Widget _buildFormCard(PostsDigiteauxBloc postsDigiteauxBloc) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.indigo.shade600,
                        Colors.purple.shade600,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    CupertinoIcons.doc_text_fill,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'INFORMATIONS',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1e293b),
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildLabel('TITRE DU POST', CupertinoIcons.textformat),
            const SizedBox(height: 12),
            _buildTextField(
              controller: postsDigiteauxBloc.titre,
              hint: 'Entrez le titre du post...',
              icon: CupertinoIcons.pencil,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String label, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.indigo.shade600,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1.5,
        ),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFF1e293b),
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 13,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(14),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(
              icon,
              color: Colors.grey[400],
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection(PostsDigiteauxBloc postsDigiteauxBloc) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.indigo.shade600,
                        Colors.purple.shade600,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    CupertinoIcons.photo_fill,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'IMAGE DU POST',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1e293b),
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Prévisualisation de l'image
            if (postsDigiteauxBloc.fileModel != null || postsDigiteauxBloc.imagePost[0] != null)
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[100],
                  border: Border.all(
                    color: Colors.grey[300]!,
                    width: 1.5,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: postsDigiteauxBloc.fileModel != null
                      ? CachedNetworkImage(
                          imageUrl: BASE_URL_ASSET + postsDigiteauxBloc.fileModel!.url!,
                          fit: BoxFit.contain,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        )
                      : Image.memory(
                          postsDigiteauxBloc.imagePost[1],
                          fit: BoxFit.contain,
                        ),
                ),
              ),
            if (postsDigiteauxBloc.fileModel != null || postsDigiteauxBloc.imagePost[0] != null)
              const SizedBox(height: 16),
            // Boutons d'upload
            Row(
              children: [
                if (postsDigiteauxBloc.imagePost[0] == null)
                  Expanded(
                    child: GestureDetector(
                      onTap: () => postsDigiteauxBloc.setParcourirFile(1),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.indigo.shade600,
                              Colors.purple.shade600,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.indigo.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.folder,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Parcourir',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                if (postsDigiteauxBloc.fileModel == null && postsDigiteauxBloc.imagePost[0] == null)
                  const SizedBox(width: 12),
                if (postsDigiteauxBloc.fileModel == null)
                  Expanded(
                    child: GestureDetector(
                      onTap: () => postsDigiteauxBloc.getImagePost(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.indigo.shade600,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.cloud_upload,
                              color: Colors.indigo.shade600,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Uploader',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo.shade600,
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
      ),
    );
  }

  Widget _buildTypeSelector(PostsDigiteauxBloc postsDigiteauxBloc) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.indigo.shade600,
                        Colors.purple.shade600,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    CupertinoIcons.tag_fill,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'TYPE DE POST',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1e293b),
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => postsDigiteauxBloc.settypePost(0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        gradient: postsDigiteauxBloc.typePost == 0
                            ? LinearGradient(
                                colors: [
                                  Colors.indigo.shade600,
                                  Colors.purple.shade600,
                                ],
                              )
                            : null,
                        color: postsDigiteauxBloc.typePost == 0 ? null : Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: postsDigiteauxBloc.typePost == 0
                              ? Colors.transparent
                              : Colors.grey[300]!,
                          width: 1.5,
                        ),
                        boxShadow: postsDigiteauxBloc.typePost == 0
                            ? [
                                BoxShadow(
                                  color: Colors.indigo.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : null,
                      ),
                      child: Column(
                        children: [
                          Icon(
                            CupertinoIcons.star_fill,
                            color: postsDigiteauxBloc.typePost == 0
                                ? Colors.white
                                : Colors.grey[600],
                            size: 28,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'ESSENTIEL DU JOUR',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: postsDigiteauxBloc.typePost == 0
                                  ? Colors.white
                                  : Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => postsDigiteauxBloc.settypePost(1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        gradient: postsDigiteauxBloc.typePost == 1
                            ? LinearGradient(
                                colors: [
                                  Colors.indigo.shade600,
                                  Colors.purple.shade600,
                                ],
                              )
                            : null,
                        color: postsDigiteauxBloc.typePost == 1 ? null : Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: postsDigiteauxBloc.typePost == 1
                              ? Colors.transparent
                              : Colors.grey[300]!,
                          width: 1.5,
                        ),
                        boxShadow: postsDigiteauxBloc.typePost == 1
                            ? [
                                BoxShadow(
                                  color: Colors.indigo.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : null,
                      ),
                      child: Column(
                        children: [
                          Icon(
                            CupertinoIcons.briefcase_fill,
                            color: postsDigiteauxBloc.typePost == 1
                                ? Colors.white
                                : Colors.grey[600],
                            size: 28,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'POST COMMERCIAL',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: postsDigiteauxBloc.typePost == 1
                                  ? Colors.white
                                  : Colors.grey[600],
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
      ),
    );
  }

  Widget _buildActionButtons(PostsDigiteauxBloc postsDigiteauxBloc, MenuAdminBloc menuAdminBloc) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => menuAdminBloc.setPresseEcrite(0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.xmark,
                    color: Colors.grey[700],
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Annuler',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: postsDigiteauxBloc.chargement ? null : () => postsDigiteauxBloc.addPost(),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.indigo.shade600,
                    Colors.purple.shade600,
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (postsDigiteauxBloc.chargement)
                    const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  else
                    const Icon(
                      CupertinoIcons.add_circled,
                      color: Colors.white,
                      size: 20,
                    ),
                  const SizedBox(width: 8),
                  Text(
                    postsDigiteauxBloc.chargement ? 'Ajout...' : 'Ajouter le post',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMediaSelector(PostsDigiteauxBloc postsDigiteauxBloc) {
    return Column(
      children: [
        // Barre de recherche
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey[300]!,
                width: 1.5,
              ),
            ),
            child: TextField(
              onChanged: (value) => postsDigiteauxBloc.setRecherche(value),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: 'Rechercher un média...',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 13,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(14),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Icon(
                    CupertinoIcons.search,
                    color: Colors.grey[400],
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
        // Grille de médias
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: postsDigiteauxBloc.filesModel.reversed
                  .where((e) => e.url!
                      .split("/")
                      .last
                      .toLowerCase()
                      .contains(postsDigiteauxBloc.recherche.toLowerCase()))
                  .map((e) => GestureDetector(
                        onTap: () => postsDigiteauxBloc.setFileModel(e),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: e == postsDigiteauxBloc.fileModel
                                  ? Colors.indigo.shade600
                                  : Colors.grey[300]!,
                              width: e == postsDigiteauxBloc.fileModel ? 2.5 : 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Badge de sélection
                              if (e == postsDigiteauxBloc.fileModel)
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.indigo.shade600,
                                              Colors.purple.shade600,
                                            ],
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          CupertinoIcons.check_mark,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              // Image
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: CachedNetworkImage(
                                    imageUrl: BASE_URL_ASSET + e.url!,
                                    fit: BoxFit.contain,
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  ),
                                ),
                              ),
                              // Nom du fichier
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  e.url!.split("/").last.split(".")[
                                      e.url!.split("/").last.split(".").length - 2],
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[700],
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
        // Bouton de sélection
        Padding(
          padding: const EdgeInsets.all(16),
          child: GestureDetector(
            onTap: postsDigiteauxBloc.fileModel != null
                ? () => postsDigiteauxBloc.setParcourirFile(0)
                : null,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                gradient: postsDigiteauxBloc.fileModel != null
                    ? LinearGradient(
                        colors: [
                          Colors.indigo.shade600,
                          Colors.purple.shade600,
                        ],
                      )
                    : null,
                color: postsDigiteauxBloc.fileModel == null ? Colors.grey[300] : null,
                borderRadius: BorderRadius.circular(12),
                boxShadow: postsDigiteauxBloc.fileModel != null
                    ? [
                        BoxShadow(
                          color: Colors.indigo.withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.checkmark_alt,
                    color: postsDigiteauxBloc.fileModel != null
                        ? Colors.white
                        : Colors.grey[500],
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Sélectionner ce média',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: postsDigiteauxBloc.fileModel != null
                          ? Colors.white
                          : Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
