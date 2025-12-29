import 'package:actu/bloc/administrateur/article-bloc.dart';
import 'package:actu/bloc/administrateur/categorie-bloc.dart';
import 'package:actu/bloc/administrateur/menu-admin.dart';
import 'package:actu/bloc/administrateur/tags-bloc.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class AddArticleScreenMobile extends StatefulWidget {
  const AddArticleScreenMobile({super.key});

  @override
  State<AddArticleScreenMobile> createState() => _AddArticleScreenMobileState();
}

class _AddArticleScreenMobileState extends State<AddArticleScreenMobile> with SingleTickerProviderStateMixin {
  final customToolBarList = [
    ToolBarStyle.bold,
    ToolBarStyle.italic,
    ToolBarStyle.align,
    ToolBarStyle.color,
    ToolBarStyle.background,
    ToolBarStyle.listBullet,
    ToolBarStyle.listOrdered,
    ToolBarStyle.clean,
    ToolBarStyle.addTable,
    ToolBarStyle.editTable,
  ];

  final _toolbarColor = Colors.grey.shade100;
  final _editorTextStyle = const TextStyle(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.normal,
    fontFamily: 'Roboto',
  );
  final _hintTextStyle = const TextStyle(
    fontSize: 16,
    color: Colors.black38,
    fontWeight: FontWeight.normal,
  );

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
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
    Size size = MediaQuery.of(context).size;
    final addArticleBloc = Provider.of<AddArticleBloc>(context);
    final menuAdminBloc = Provider.of<MenuAdminBloc>(context);
    final categorieBloc = Provider.of<CategorieBloc>(context);
    final tagsBloc = Provider.of<TagsBloc>(context);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          color: Colors.grey.shade50,
          child: addArticleBloc.parcourirFile == 0
              ? _buildMainForm(context, size, addArticleBloc, menuAdminBloc, categorieBloc, tagsBloc)
              : _buildMediaBrowser(context, size, addArticleBloc),
        ),
      ),
    );
  }

  Widget _buildMainForm(
    BuildContext context,
    Size size,
    AddArticleBloc addArticleBloc,
    MenuAdminBloc menuAdminBloc,
    CategorieBloc categorieBloc,
    TagsBloc tagsBloc,
  ) {
    return Column(
      children: [
        // Header moderne avec gradient
        _buildHeader(context, size, menuAdminBloc),
        
        // Formulaire
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Section Titre
              _buildSectionCard(
                title: 'TITRE DE L\'ARTICLE',
                icon: CupertinoIcons.textformat,
                child: _buildTitleField(addArticleBloc),
              ),
              const SizedBox(height: 16),
              
              // Section Catégorie et Tags
              _buildSectionCard(
                title: 'CATÉGORIE & TAGS',
                icon: CupertinoIcons.tag_fill,
                child: Column(
                  children: [
                    _buildCategoryDropdown(categorieBloc),
                    const SizedBox(height: 16),
                    _buildTagsSection(addArticleBloc, tagsBloc),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              
              // Section Image
              _buildSectionCard(
                title: 'IMAGE DE COUVERTURE',
                icon: CupertinoIcons.photo_fill,
                child: _buildImageSection(addArticleBloc),
              ),
              const SizedBox(height: 16),
              
              // Section Résumé
              _buildSectionCard(
                title: 'RÉSUMÉ',
                icon: CupertinoIcons.doc_plaintext,
                child: _buildResumeField(addArticleBloc),
              ),
              const SizedBox(height: 16),
              
              // Section Mots-clés
              _buildSectionCard(
                title: 'MOTS-CLÉS',
                icon: CupertinoIcons.number,
                child: _buildKeywordsSection(addArticleBloc),
              ),
              const SizedBox(height: 16),
              
              // Section Contenu
              _buildSectionCard(
                title: 'CONTENU DE L\'ARTICLE',
                icon: CupertinoIcons.doc_text,
                child: _buildContentEditor(addArticleBloc),
              ),
              const SizedBox(height: 16),
              
              // Section Options
              _buildSectionCard(
                title: 'OPTIONS DE PUBLICATION',
                icon: CupertinoIcons.settings,
                child: _buildPublishOptions(addArticleBloc),
              ),
              const SizedBox(height: 24),
              
              // Boutons d'action
              _buildActionButtons(context, addArticleBloc, menuAdminBloc, categorieBloc, tagsBloc),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, Size size, MenuAdminBloc menuAdminBloc) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF06b6d4),
            Color(0xFF0891b2),
            Color(0xFF0e7490),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF06b6d4).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => menuAdminBloc.setAddArticle(0),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: blanc.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: blanc.withOpacity(0.3), width: 1),
                    ),
                    child: Icon(CupertinoIcons.xmark, color: blanc, size: 20),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: blanc.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: blanc.withOpacity(0.3), width: 1),
                  ),
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.doc_text, color: blanc, size: 14),
                      const SizedBox(width: 6),
                      Text(
                        'Nouveau',
                        style: TextStyle(
                          color: blanc,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
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
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'NOUVEL ARTICLE',
                        style: TextStyle(
                          color: blanc,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Créez et publiez un nouvel article',
                        style: TextStyle(
                          color: blanc.withOpacity(0.9),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
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

  Widget _buildSectionCard({required String title, required IconData icon, required Widget child}) {
    return Container(
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
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF06b6d4).withOpacity(0.1),
                  const Color(0xFF0891b2).withOpacity(0.05),
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF06b6d4), Color(0xFF0891b2)],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: blanc, size: 16),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0e7490),
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildTitleField(AddArticleBloc addArticleBloc) {
    return TextField(
      controller: addArticleBloc.titre,
      decoration: InputDecoration(
        hintText: "Saisissez le titre de l'article...",
        hintStyle: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade400,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF06b6d4), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      maxLines: 2,
    );
  }

  Widget _buildCategoryDropdown(CategorieBloc categorieBloc) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: DropdownButton(
        items: categorieBloc.categories
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.square_grid_2x2_fill, size: 14, color: const Color(0xFF06b6d4)),
                      const SizedBox(width: 8),
                      Text(
                        e.titre!,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ))
            .toList(),
        value: categorieBloc.categorie,
        hint: Row(
          children: [
            Icon(CupertinoIcons.square_grid_2x2, size: 14, color: Colors.grey.shade400),
            const SizedBox(width: 8),
            Text(
              'Sélectionner une catégorie',
              style: TextStyle(fontSize: 13, color: Colors.grey.shade400, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        isExpanded: true,
        iconSize: 0.0,
        elevation: 2,
        focusColor: Colors.transparent,
        underline: const SizedBox(),
        padding: const EdgeInsets.all(0),
        onChanged: (v) => categorieBloc.setCategorie(v),
      ),
    );
  }

  Widget _buildTagsSection(AddArticleBloc addArticleBloc, TagsBloc tagsBloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tags sélectionnés
        if (addArticleBloc.tag != null)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [addArticleBloc.tag!].map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF06b6d4), Color(0xFF0891b2)],
                  ),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF06b6d4).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(CupertinoIcons.tag_fill, color: blanc, size: 12),
                    const SizedBox(width: 6),
                    Text(
                      tag.titre!,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: blanc,
                      ),
                    ),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: () => addArticleBloc.setTags(null),
                      child: Icon(CupertinoIcons.xmark, color: blanc, size: 12),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        if (addArticleBloc.tag != null) const SizedBox(height: 12),
        
        // Bouton ajouter tags
        GestureDetector(
          onTap: () => addArticleBloc.setParcourirFile(2),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF06b6d4).withOpacity(0.3), width: 1.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF06b6d4), Color(0xFF0891b2)],
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(CupertinoIcons.add, color: blanc, size: 14),
                ),
                const SizedBox(width: 10),
                const Text(
                  'AJOUTER DES TAGS',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0e7490),
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageSection(AddArticleBloc addArticleBloc) {
    return Column(
      children: [
        if (addArticleBloc.fileModel != null)
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: "${BASE_URL_ASSET}${addArticleBloc.fileModel!.url}",
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    height: 200,
                    color: Colors.grey.shade100,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 200,
                    color: Colors.grey.shade100,
                    child: Icon(Icons.error, color: Colors.grey.shade400),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () => addArticleBloc.setFileModel(null),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: rouge.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: rouge.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(CupertinoIcons.trash, color: blanc, size: 16),
                  ),
                ),
              ),
            ],
          )
        else
          GestureDetector(
            onTap: () => addArticleBloc.setParcourirFile(1),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF06b6d4).withOpacity(0.3),
                  width: 2,
                  style: BorderStyle.solid,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF06b6d4).withOpacity(0.1),
                            const Color(0xFF0891b2).withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        CupertinoIcons.photo,
                        size: 40,
                        color: Color(0xFF06b6d4),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'PARCOURIR LES IMAGES',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0e7490),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Cliquez pour sélectionner',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500,
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

  Widget _buildResumeField(AddArticleBloc addArticleBloc) {
    return TextField(
      controller: addArticleBloc.motCles,
      maxLines: 4,
      decoration: InputDecoration(
        hintText: "Saisissez un résumé de l'article...",
        hintStyle: TextStyle(
          fontSize: 13,
          color: Colors.grey.shade400,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF06b6d4), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }

  Widget _buildKeywordsSection(AddArticleBloc addArticleBloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Mots-clés existants
        if (addArticleBloc.keyWorld.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: addArticleBloc.keyWorld.map((keyword) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0e7490), Color(0xFF0891b2)],
                  ),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0e7490).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(CupertinoIcons.number, color: blanc, size: 12),
                    const SizedBox(width: 6),
                    Text(
                      keyword,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: blanc,
                      ),
                    ),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: () {
                        addArticleBloc.keyWorld.remove(keyword);
                        addArticleBloc.notifyListeners();
                      },
                      child: Icon(CupertinoIcons.xmark, color: blanc, size: 12),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        if (addArticleBloc.keyWorld.isNotEmpty) const SizedBox(height: 12),
        
        // Champ d'ajout de mot-clé
        Row(
          children: [
            Expanded(
              child: TextField(
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty && !addArticleBloc.keyWorld.contains(value.trim())) {
                    addArticleBloc.keyWorld.add(value.trim());
                    addArticleBloc.notifyListeners();
                  }
                },
                decoration: InputDecoration(
                  hintText: "Ajouter un mot-clé et appuyez sur Entrée",
                  hintStyle: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w500,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF06b6d4), width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  prefixIcon: Icon(
                    CupertinoIcons.add_circled,
                    color: const Color(0xFF0e7490),
                    size: 20,
                  ),
                ),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Appuyez sur Entrée pour ajouter chaque mot-clé',
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade500,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildContentEditor(AddArticleBloc addArticleBloc) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: _toolbarColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ToolBar(
            toolBarColor: _toolbarColor,
            padding: const EdgeInsets.all(8),
            iconSize: 20,
            iconColor: const Color(0xFF0e7490),
            activeIconColor: const Color(0xFF06b6d4),
            controller: addArticleBloc.controllerProduct,
            crossAxisAlignment: WrapCrossAlignment.start,
            direction: Axis.horizontal,
            customButtons: [],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 400,
          decoration: BoxDecoration(
            color: blanc,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300, width: 1),
          ),
          child: QuillHtmlEditor(
            text: "",
            hintText: "Rédigez le contenu de votre article...",
            controller: addArticleBloc.controllerProduct,
            isEnabled: true,
            minHeight: 400,
            textStyle: _editorTextStyle,
            hintTextStyle: _hintTextStyle,
            hintTextAlign: TextAlign.start,
            padding: const EdgeInsets.all(16),
            hintTextPadding: const EdgeInsets.all(16),
            backgroundColor: blanc,
            onFocusChanged: (focus) {},
            onTextChanged: (text) {},
            onEditorCreated: () {},
            onSelectionChanged: (sel) {},
          ),
        ),
      ],
    );
  }

  Widget _buildPublishOptions(AddArticleBloc addArticleBloc) {
    return Column(
      children: [
        // Statut
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300, width: 1),
          ),
          child: DropdownButton<String>(
            items: [
              DropdownMenuItem(
                value: 'brouillon',
                child: Row(
                  children: [
                    Icon(CupertinoIcons.doc, size: 14, color: Colors.orange),
                    const SizedBox(width: 8),
                    const Text('Brouillon', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: 'on',
                child: Row(
                  children: [
                    Icon(CupertinoIcons.checkmark_circle, size: 14, color: vert),
                    const SizedBox(width: 8),
                    const Text('Publié', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: 'archive',
                child: Row(
                  children: [
                    Icon(CupertinoIcons.archivebox, size: 14, color: gris),
                    const SizedBox(width: 8),
                    const Text('Archivé', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
            value: ['brouillon', 'on', 'archive'].contains(addArticleBloc.statusNews) 
                ? addArticleBloc.statusNews 
                : 'brouillon',
            isExpanded: true,
            iconSize: 0.0,
            elevation: 2,
            focusColor: Colors.transparent,
            underline: const SizedBox(),
            padding: const EdgeInsets.all(0),
            onChanged: (v) => addArticleBloc.setStatusNews(v!),
          ),
        ),
        const SizedBox(height: 16),
        
        // Options checkboxes
        _buildCheckboxOption(
          label: 'Article à la Une',
          value: addArticleBloc.typeArticle == 2,
          onChanged: (v) => addArticleBloc.setTypeArticle(v! ? 2 : 0),
        ),
      ],
    );
  }

  Widget _buildCheckboxOption({
    required String label,
    required bool value,
    required Function(bool?) onChanged,
  }) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: value ? const Color(0xFF06b6d4).withOpacity(0.1) : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: value ? const Color(0xFF06b6d4).withOpacity(0.3) : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                gradient: value
                    ? const LinearGradient(colors: [Color(0xFF06b6d4), Color(0xFF0891b2)])
                    : null,
                color: value ? null : blanc,
                borderRadius: BorderRadius.circular(6),
                border: value ? null : Border.all(color: Colors.grey.shade400, width: 2),
              ),
              child: value
                  ? Icon(CupertinoIcons.checkmark, color: blanc, size: 14)
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: value ? const Color(0xFF0e7490) : noir,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    AddArticleBloc addArticleBloc,
    MenuAdminBloc menuAdminBloc,
    CategorieBloc categorieBloc,
    TagsBloc tagsBloc,
  ) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => menuAdminBloc.setAddArticle(0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300, width: 1),
              ),
              child: const Center(
                child: Text(
                  'ANNULER',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: () {
              if (!addArticleBloc.chargement) {
                addArticleBloc.addArticle().then((value) {
                  if (value) {
                    menuAdminBloc.setAddArticle(0);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Article créé avec succès !'),
                        backgroundColor: vert,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Erreur lors de la création'),
                        backgroundColor: rouge,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF06b6d4), Color(0xFF0891b2), Color(0xFF0e7490)],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF06b6d4).withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: addArticleBloc.chargement
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(blanc),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(CupertinoIcons.checkmark_circle, color: blanc, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            'PUBLIER L\'ARTICLE',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: blanc,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMediaBrowser(BuildContext context, Size size, AddArticleBloc addArticleBloc) {
    return Container(
      color: blanc,
      child: Column(
        children: [
          // Header du browser
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF06b6d4), Color(0xFF0891b2), Color(0xFF0e7490)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF06b6d4).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          addArticleBloc.setParcourirFile(0);
                          addArticleBloc.setRecherche(''); // Réinitialiser la recherche tags
                          addArticleBloc.setRechercheFile(''); // Réinitialiser la recherche images
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: blanc.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: blanc.withOpacity(0.3), width: 1),
                          ),
                          child: Icon(CupertinoIcons.arrow_left, color: blanc, size: 20),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          addArticleBloc.parcourirFile == 1 ? 'IMAGES' : 'TAGS',
                          style: TextStyle(
                            color: blanc,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Barre de recherche pour les images et tags
                  if (addArticleBloc.parcourirFile == 1 || addArticleBloc.parcourirFile == 2) ...[
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: blanc,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: noir.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: addArticleBloc.parcourirFile == 1 
                            ? TextEditingController(text: addArticleBloc.rechercheFile)
                            : addArticleBloc.recherche,
                        onChanged: (value) => addArticleBloc.parcourirFile == 1
                            ? addArticleBloc.setRechercheFile(value)
                            : addArticleBloc.setRecherche(value),
                        decoration: InputDecoration(
                          hintText: addArticleBloc.parcourirFile == 1 
                              ? 'Rechercher une image...'
                              : 'Rechercher un tag...',
                          hintStyle: TextStyle(
                            color: gris.withOpacity(0.6),
                            fontSize: 14,
                          ),
                          prefixIcon: Icon(
                            CupertinoIcons.search,
                            color: const Color(0xFF06b6d4),
                            size: 20,
                          ),
                          suffixIcon: (addArticleBloc.parcourirFile == 1 
                                  ? addArticleBloc.rechercheFile.isNotEmpty
                                  : addArticleBloc.rechercheT.isNotEmpty)
                              ? GestureDetector(
                                  onTap: () {
                                    if (addArticleBloc.parcourirFile == 1) {
                                      addArticleBloc.setRechercheFile('');
                                    } else {
                                      addArticleBloc.recherche.clear();
                                      addArticleBloc.setRecherche('');
                                    }
                                  },
                                  child: Icon(
                                    CupertinoIcons.xmark_circle_fill,
                                    color: gris.withOpacity(0.6),
                                    size: 20,
                                  ),
                                )
                              : null,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          
          // Contenu du browser
          Expanded(
            child: addArticleBloc.parcourirFile == 1
                ? _buildImageGrid(addArticleBloc)
                : _buildTagsList(addArticleBloc),
          ),
        ],
      ),
    );
  }

  Widget _buildImageGrid(AddArticleBloc addArticleBloc) {
    // Filtrer les images selon la recherche
    final filteredImages = addArticleBloc.filesModel.where((file) {
      if (addArticleBloc.rechercheFile.isEmpty) return true;
      final fileName = file.url?.toLowerCase() ?? '';
      final searchLower = addArticleBloc.rechercheFile.toLowerCase();
      return fileName.contains(searchLower);
    }).toList();
    
    if (addArticleBloc.filesModel.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.photo, size: 64, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text(
              'Aucune image disponible',
              style: TextStyle(fontSize: 16, color: gris, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );
    }
    
    if (filteredImages.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.search, size: 64, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text(
              'Aucune image trouvée',
              style: TextStyle(fontSize: 16, color: gris, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              'pour "${addArticleBloc.rechercheFile}"',
              style: TextStyle(fontSize: 14, color: gris.withOpacity(0.7)),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemCount: filteredImages.length,
      itemBuilder: (context, index) {
        final file = filteredImages[index];
        return GestureDetector(
          onTap: () {
            addArticleBloc.setFileModel(file);
            addArticleBloc.setParcourirFile(0);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300, width: 1),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 2),
                  blurRadius: 8,
                  color: noir.withOpacity(0.1),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: "${BASE_URL_ASSET}${file.url}",
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey.shade100,
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey.shade100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error, color: Colors.grey.shade400),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${BASE_URL_ASSET}${file.url}",
                          style: TextStyle(fontSize: 8, color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        error.toString(),
                        style: TextStyle(fontSize: 7, color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTagsList(AddArticleBloc addArticleBloc) {
    final tagsBloc = Provider.of<TagsBloc>(context);
    
    // Filtrer les tags selon la recherche
    final filteredTags = tagsBloc.tags.where((tag) {
      if (addArticleBloc.rechercheT.isEmpty) return true;
      return tag.titre!.toLowerCase().contains(addArticleBloc.rechercheT.toLowerCase());
    }).toList();
    
    if (tagsBloc.tags.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.tag, size: 64, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text(
              'Aucun tag disponible',
              style: TextStyle(fontSize: 16, color: gris, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );
    }
    
    if (filteredTags.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.search, size: 64, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text(
              'Aucun tag trouvé',
              style: TextStyle(fontSize: 16, color: gris, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              'pour "${addArticleBloc.rechercheT}"',
              style: TextStyle(fontSize: 14, color: gris.withOpacity(0.7)),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredTags.length,
      itemBuilder: (context, index) {
        final tag = filteredTags[index];
        final isSelected = addArticleBloc.tag?.id == tag.id;
        
        return GestureDetector(
          onTap: () {
            if (isSelected) {
              addArticleBloc.setTags(null);
            } else {
              addArticleBloc.setTags(tag);
              addArticleBloc.setParcourirFile(0); // Fermer l'écran de tags
            }
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              gradient: isSelected
                  ? const LinearGradient(colors: [Color(0xFF06b6d4), Color(0xFF0891b2)])
                  : null,
              color: isSelected ? null : blanc,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? Colors.transparent : Colors.grey.shade300,
                width: 1,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: const Color(0xFF06b6d4).withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [
                      BoxShadow(
                        offset: const Offset(0, 2),
                        blurRadius: 8,
                        color: noir.withOpacity(0.05),
                      ),
                    ],
            ),
            child: Row(
              children: [
                Icon(
                  isSelected ? CupertinoIcons.checkmark_circle_fill : CupertinoIcons.tag_fill,
                  color: isSelected ? blanc : const Color(0xFF06b6d4),
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    tag.titre!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? blanc : noir,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
