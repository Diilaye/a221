// FICHIER NETTOYÉ - VERSION MODERNE
import 'package:actu/bloc/administrateur/article-bloc.dart';
import 'package:actu/bloc/administrateur/categorie-bloc.dart';
import 'package:actu/bloc/administrateur/menu-admin.dart';
import 'package:actu/bloc/administrateur/tags-bloc.dart';
import 'package:actu/models/administrateur/categorie-model.dart';
import 'package:actu/models/administrateur/file-model.dart';
import 'package:actu/models/administrateur/tags-model.dart';
// import 'package:actu/models/administrateur/tags-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class AddArticleScreen extends StatefulWidget {
  const AddArticleScreen({super.key});

  @override
  State<AddArticleScreen> createState() => _AddArticleScreenState();
}

class _AddArticleScreenState extends State<AddArticleScreen> with AutomaticKeepAliveClientMixin {
  ///[customToolBarList] pass the custom toolbarList to show only selected styles in the editor

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

  final _toolbarColor = Colors.grey.shade200;
  // final _backgroundColor = Colors.white70;
  // final _toolbarIconColor = Colors.black87;
  final _editorTextStyle = const TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontFamily: 'Roboto');
  final _hintTextStyle = const TextStyle(
      fontSize: 18, color: Colors.black38, fontWeight: FontWeight.normal);

  bool _hasFocus = false;

  late StateSetter _setState;
  late StateSetter _setStateTags;
  String rechercheTags = "";

  int showTags = 0;

  TagsModel? tagsRecherche = null;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Important pour AutomaticKeepAliveClientMixin
    Size size = MediaQuery.of(context).size;
    final addArticleBloc = Provider.of<AddArticleBloc>(context);
    final menuAdminBloc = Provider.of<MenuAdminBloc>(context);
    final categorieBloc = Provider.of<CategorieBloc>(context);
    final tagsBloc = Provider.of<TagsBloc>(context);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey[50]!,
            Colors.white,
            Colors.grey[50]!,
          ],
        ),
      ),
      child: Stack(
        children: [
          //if (showTags == 0)
          Positioned(
            top: 0,
            child: SizedBox(
              height: size.height,
              width: size.width * .8,
              child: Column(
                children: [
                  // Header moderne avec gradient
                  Container(
                    margin: const EdgeInsets.all(24),
                    padding: const EdgeInsets.all(24),
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
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF06b6d4).withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            CupertinoIcons.doc_text_fill,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'NOUVEL ARTICLE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Créez et publiez un nouvel article',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Contenu du formulaire
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                        // Section Titre
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [Color(0xFF06b6d4), Color(0xFF0891b2)],
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      CupertinoIcons.textformat,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    'TITRE DE L\'ARTICLE',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                      color: Color(0xFF1e293b),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.grey[200]!,
                                    width: 2,
                                  ),
                                ),
                                child: TextField(
                                  controller: addArticleBloc.titre,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF1e293b),
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Saisissez le titre de votre article...',
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                      fontWeight: FontWeight.w500,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.all(16),
                                    prefixIcon: Icon(
                                      CupertinoIcons.pencil,
                                      color: Colors.grey[400],
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Section Image
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [Color(0xFFef4444), Color(0xFFdc2626)],
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      CupertinoIcons.photo_fill,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    'IMAGE DE L\'ARTICLE',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                      color: Color(0xFF1e293b),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              if (addArticleBloc.fileModel != null || addArticleBloc.imageAticle[0] != null) ...[
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.grey[300]!,
                                      width: 2,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: addArticleBloc.fileModel != null
                                        ? Image.network(
                                            BASE_URL_ASSET + addArticleBloc.fileModel!.url!,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          )
                                        : addArticleBloc.imageAticle[1].runtimeType == String
                                            ? Image.network(
                                                addArticleBloc.imageAticle[1],
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                              )
                                            : Image.memory(
                                                addArticleBloc.imageAticle[1],
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                              ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                              ],
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () => addArticleBloc.setParcourirFile(1),
                                      icon: const Icon(CupertinoIcons.folder, size: 20),
                                      label: Text(
                                        addArticleBloc.fileModel == null ? 'Parcourir' : 'Changer',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF06b6d4),
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        elevation: 0,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () => addArticleBloc.getImageArticle(),
                                      icon: const Icon(CupertinoIcons.cloud_upload, size: 20),
                                      label: Text(
                                        addArticleBloc.imageAticle[0] == null ? 'Uploader' : 'Changé',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: addArticleBloc.imageAticle[0] == null 
                                            ? const Color(0xFFef4444) 
                                            : const Color(0xFF10b981),
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        elevation: 0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Section Éditeur
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [Color(0xFF06b6d4), Color(0xFF0891b2)],
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      CupertinoIcons.doc_richtext,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    'CONTENU DE L\'ARTICLE',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                      color: Color(0xFF1e293b),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              const SizedBox(height: 16),
                              // Toolbar moderne
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.grey[300]!,
                                    width: 1,
                                  ),
                                ),
                                child: ToolBar(
                                  toolBarColor: Colors.grey[100]!,
                                  padding: const EdgeInsets.all(12),
                                  iconSize: 22,
                                  iconColor: noir,
                                  activeIconColor: const Color(0xFF06b6d4),
                                  controller: addArticleBloc.controllerProduct,
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  direction: Axis.horizontal,
                                  customButtons: [
                                    Container(
                                      width: 22,
                                      height: 22,
                                      decoration: BoxDecoration(
                                        color: _hasFocus ? const Color(0xFF06b6d4) : Colors.grey,
                                        borderRadius: BorderRadius.circular(11),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        var selectedText = await addArticleBloc
                                            .controllerProduct
                                            .getSelectedText();
                                        debugPrint('selectedText $selectedText');
                                        var selectedHtmlText = await addArticleBloc
                                            .controllerProduct
                                            .getSelectedHtmlText();
                                        debugPrint('selectedHtmlText $selectedHtmlText');
                                      },
                                      child: const Icon(
                                        Icons.add_circle,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                height: 300,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.grey[300]!,
                                    width: 2,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: QuillHtmlEditor(
                                    controller: addArticleBloc.controllerProduct,
                                    isEnabled: true,
                                    minHeight: 300,
                                    textStyle: _editorTextStyle,
                                    hintText: 'Rédigez le contenu de votre article...',
                                    hintTextStyle: _hintTextStyle,
                                    hintTextAlign: TextAlign.start,
                                    padding: const EdgeInsets.all(16),
                                    hintTextPadding: EdgeInsets.zero,
                                    backgroundColor: Colors.white,
                                    onTextChanged: (text) {
                                      // Toujours mettre à jour le body sans condition
                                      addArticleBloc.setBody(text);
                                    },
                                    onEditorCreated: () {
                                      // Restaurer le contenu quand l'éditeur est créé
                                      if (addArticleBloc.body.isNotEmpty) {
                                        addArticleBloc.controllerProduct.setText(addArticleBloc.body);
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Section Options d'affichage
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [Color(0xFF8b5cf6), Color(0xFF7c3aed)],
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      CupertinoIcons.eye_fill,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    'OPTIONS D\'AFFICHAGE',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                      color: Color(0xFF1e293b),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              const SizedBox(height: 20),
                              // Options modernes avec cards
                              _buildOptionCard(
                                icon: CupertinoIcons.xmark_circle,
                                title: 'Ne rien afficher',
                                isSelected: addArticleBloc.typeArticle == 0,
                                onTap: () => addArticleBloc.setTypeArticle(0),
                              ),
                              const SizedBox(height: 12),
                              _buildOptionCard(
                                icon: CupertinoIcons.star_fill,
                                title: 'Afficher sur Top article',
                                isSelected: addArticleBloc.typeArticle == 1,
                                onTap: () => addArticleBloc.setTypeArticle(1),
                              ),
                              const SizedBox(height: 12),
                              _buildOptionCard(
                                icon: CupertinoIcons.rocket_fill,
                                title: 'Afficher à la une',
                                isSelected: addArticleBloc.typeArticle == 2,
                                onTap: () => addArticleBloc.setTypeArticle(2),
                              ),
                              const SizedBox(height: 12),
                              _buildOptionCard(
                                icon: CupertinoIcons.tag_fill,
                                title: 'Afficher sur la une de sa rubrique',
                                isSelected: addArticleBloc.typeArticle == 3,
                                onTap: () => addArticleBloc.setTypeArticle(3),
                              ),
                              const SizedBox(height: 12),
                              _buildOptionCard(
                                icon: CupertinoIcons.hand_thumbsup_fill,
                                title: 'Afficher comme choix de la rédaction',
                                isSelected: addArticleBloc.typeArticle == 4,
                                onTap: () => addArticleBloc.setTypeArticle(4),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Section Catégorie et Tags
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [Color(0xFF10b981), Color(0xFF059669)],
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      CupertinoIcons.folder_fill,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    'CATÉGORIE & TAGS',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                      color: Color(0xFF1e293b),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              const SizedBox(height: 20),
                              // Dropdown Catégorie moderne
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.grey[200]!,
                                    width: 2,
                                  ),
                                ),
                                child: DropdownSearch<String>(
                                  popupProps: PopupProps.menu(
                                    showSearchBox: true,
                                    searchFieldProps: TextFieldProps(
                                      decoration: InputDecoration(
                                        labelText: 'Recherche',
                                        enabledBorder: const OutlineInputBorder(),
                                        disabledBorder: const OutlineInputBorder(),
                                        border: const OutlineInputBorder(),
                                        filled: true,
                                        fillColor: Colors.grey[50],
                                      ),
                                    ),
                                    showSelectedItems: true,
                                  ),
                                  items: (String? filter, LoadProps? props) async {
                                    return categorieBloc.categories
                                        .map((e) => e.titre!)
                                        .toList();
                                  },
                                  decoratorProps: DropDownDecoratorProps(
                                    decoration: InputDecoration(
                                      labelText: 'Sélectionnez une catégorie',
                                      labelStyle: TextStyle(
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w500,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.all(16),
                                      prefixIcon: Icon(
                                        CupertinoIcons.folder,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                  ),
                                  onChanged: (v) {
                                    print(v);
                                    categorieBloc.setCategorie(
                                      categorieBloc.categories.firstWhere(
                                        (e) => e.titre!.toLowerCase() == v!.toLowerCase(),
                                      ),
                                    );
                                    addArticleBloc.setCategorie(
                                      categorieBloc.categories.firstWhere(
                                        (e) => e.titre!.toLowerCase() == v!.toLowerCase(),
                                      ),
                                    );
                                  },
                                  selectedItem: categorieBloc.categorie == null
                                      ? ""
                                      : categorieBloc.categorie!.titre!,
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Dropdown Tags moderne
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.grey[200]!,
                                    width: 2,
                                  ),
                                ),
                                child: DropdownSearch<String>(
                                  popupProps: PopupProps.menu(
                                    showSearchBox: true,
                                    searchFieldProps: TextFieldProps(
                                      decoration: InputDecoration(
                                        labelText: 'Recherche',
                                        enabledBorder: const OutlineInputBorder(),
                                        disabledBorder: const OutlineInputBorder(),
                                        border: const OutlineInputBorder(),
                                        filled: true,
                                        fillColor: Colors.grey[50],
                                      ),
                                    ),
                                    showSelectedItems: true,
                                  ),
                                  items: (String? filter, LoadProps? props) async {
                                    return tagsBloc.tags.map((e) => e.titre!).toList();
                                  },
                                  decoratorProps: DropDownDecoratorProps(
                                    decoration: InputDecoration(
                                      labelText: 'Sélectionnez un tag',
                                      labelStyle: TextStyle(
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w500,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.all(16),
                                      prefixIcon: Icon(
                                        CupertinoIcons.tag,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                  ),
                                  onChanged: (v) {
                                    addArticleBloc.setTags(
                                      tagsBloc.tags.firstWhere(
                                        (e) => e.titre!.toLowerCase() == v!.toLowerCase(),
                                      ),
                                    );
                                  },
                                  selectedItem: addArticleBloc.tag == null
                                      ? ""
                                      : addArticleBloc.tag!.titre,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Section Mots-clés
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [Color(0xFFf59e0b), Color(0xFFd97706)],
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      CupertinoIcons.tag_fill,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    'MOTS-CLÉS',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                      color: Color(0xFF1e293b),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.grey[200]!,
                                    width: 2,
                                  ),
                                ),
                                child: KeyboardListener(
                                  focusNode: addArticleBloc.focusNode,
                                  onKeyEvent: (value) {
                                    if (value.logicalKey.keyLabel == "Enter" ||
                                        value.logicalKey.keyLabel == "Tab") {
                                      addArticleBloc.setContainer();
                                    }
                                  },
                                  child: TextField(
                                    controller: addArticleBloc.motCles,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF1e293b),
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Ajouter un mot-clé (Entrée pour valider)',
                                      hintStyle: TextStyle(
                                        color: Colors.grey[400],
                                        fontWeight: FontWeight.w500,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.all(16),
                                      prefixIcon: Icon(
                                        CupertinoIcons.plus_circle,
                                        color: Colors.grey[400],
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              if (addArticleBloc.keyWorld.isNotEmpty) ...[
                                const SizedBox(height: 16),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: addArticleBloc.keyWorld.map((e) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [Color(0xFFf59e0b), Color(0xFFd97706)],
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            e,
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          GestureDetector(
                                            onTap: () => addArticleBloc.removeContainer(e),
                                            child: const Icon(
                                              CupertinoIcons.xmark_circle_fill,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Bouton de validation
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () => addArticleBloc.addArticleWithStatut('brouillon'),
                                icon: const Icon(Icons.save, size: 22),
                                label: const Text(
                                  'Sauvegarder en brouillon',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 0,
                                ),
                              ),
                              const SizedBox(width: 16),
                              ElevatedButton.icon(
                                onPressed: () => addArticleBloc.addArticle(),
                                icon: addArticleBloc.chargement
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                        ),
                                      )
                                    : const Icon(CupertinoIcons.check_mark_circled, size: 22),
                                label: Text(
                                  addArticleBloc.chargement ? 'Publication...' : 'Publier l\'article',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF10b981),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 0,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
                ],
              ),
            ),
          ),
          // Galerie de fichiers (comme dans update-screen)
          if (addArticleBloc.parcourirFile == 1)
            Positioned.fill(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    // Header
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF06b6d4), Color(0xFF0891b2)],
                        ),
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
                          const Icon(
                            CupertinoIcons.folder_fill,
                            color: Colors.white,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'RECHERCHER MÉDIA',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Barre de recherche
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey[200]!,
                            width: 1,
                          ),
                        ),
                      ),
                      child: TextField(
                        onChanged: (value) => addArticleBloc.setRechercheFile(value),
                        decoration: InputDecoration(
                          hintText: 'Rechercher une image...',
                          prefixIcon: const Icon(CupertinoIcons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF06b6d4), width: 2),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    // Grille d'images
                    Expanded(
                      child: GridView.count(
                        padding: const EdgeInsets.all(16),
                        crossAxisCount: 5,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        children: addArticleBloc.filesModel.reversed
                            .where((e) => e.url!
                                .split("/")
                                .last
                                .toLowerCase()
                                .contains(addArticleBloc.rechercheFile.toLowerCase()))
                            .map((e) => GestureDetector(
                                  onTap: () => addArticleBloc.setFileModel(e),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: e == addArticleBloc.fileModel
                                            ? const Color(0xFF06b6d4)
                                            : Colors.grey[300]!,
                                        width: e == addArticleBloc.fileModel ? 3 : 1,
                                      ),
                                      boxShadow: [
                                        if (e == addArticleBloc.fileModel)
                                          BoxShadow(
                                            color: const Color(0xFF06b6d4).withOpacity(0.3),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        if (e == addArticleBloc.fileModel)
                                          Container(
                                            height: 30,
                                            alignment: Alignment.topRight,
                                            padding: const EdgeInsets.all(6),
                                            child: Container(
                                              height: 24,
                                              width: 24,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF10b981),
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: const Icon(
                                                CupertinoIcons.check_mark,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                            ),
                                          ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                              child: CachedNetworkImage(
                                                imageUrl: BASE_URL_ASSET + e.url!,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) => Center(
                                                  child: CircularProgressIndicator(
                                                    color: const Color(0xFF06b6d4),
                                                  ),
                                                ),
                                                errorWidget: (context, url, error) => Icon(
                                                  CupertinoIcons.photo,
                                                  color: Colors.grey[400],
                                                  size: 40,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          child: Text(
                                            e.url!.split("/").last.split(".")[
                                                e.url!.split("/").last.split(".").length - 2],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[700],
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    // Boutons d'action
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(
                            color: Colors.grey[200]!,
                            width: 1,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, -2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              addArticleBloc.setParcourirFile(0);
                            },
                            icon: const Icon(CupertinoIcons.xmark, size: 20),
                            label: const Text(
                              'Annuler',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[200],
                              foregroundColor: Colors.grey[800],
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton.icon(
                            onPressed: addArticleBloc.fileModel != null
                                ? () => addArticleBloc.setParcourirFile(0)
                                : null,
                            icon: const Icon(CupertinoIcons.check_mark, size: 20),
                            label: const Text(
                              'Sélectionner',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF06b6d4),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                              disabledBackgroundColor: Colors.grey[300],
                              disabledForegroundColor: Colors.grey[500],
                            ),
                          ),
                        ],
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

  Widget _buildOptionCard({
    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Color(0xFF8b5cf6), Color(0xFF7c3aed)],
                )
              : null,
          color: isSelected ? null : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF8b5cf6) : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.2)
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : const Color(0xFF64748b),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : const Color(0xFF1e293b),
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                CupertinoIcons.checkmark_circle_fill,
                color: Colors.white,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
