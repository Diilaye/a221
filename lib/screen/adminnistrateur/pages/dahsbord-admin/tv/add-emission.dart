import 'package:actu/bloc/administrateur/emission-bloc.dart';
import 'package:actu/bloc/administrateur/menu-admin.dart';
import 'package:actu/screen/adminnistrateur/pages/image-screen/image-sccren-ui.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEmissionScreen extends StatefulWidget {
  const AddEmissionScreen({super.key});

  @override
  State<AddEmissionScreen> createState() => _AddEmissionScreenState();
}

class _AddEmissionScreenState extends State<AddEmissionScreen> 
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
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
    final emissionBloc = Provider.of<EmissionBloc>(context);
    final menuAdminBloc = Provider.of<MenuAdminBloc>(context);

    return Container(
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
      child: emissionBloc.parcourirFile == 0
          ? FadeTransition(
              opacity: _fadeAnimation,
              child: ListView(
                padding: const EdgeInsets.all(32),
                children: [
                  _buildHeader(context, menuAdminBloc),
                  const SizedBox(height: 32),
                  _buildForm(context, emissionBloc),
                  const SizedBox(height: 32),
                  _buildActions(context, emissionBloc, menuAdminBloc),
                  const SizedBox(height: 32),
                ],
              ),
            )
          : _buildMediaBrowser(context, emissionBloc),
    );
  }

  Widget _buildHeader(BuildContext context, MenuAdminBloc menuAdminBloc) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            rouge.withOpacity(0.9),
            const Color(0xFFE31E24),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: rouge.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
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
            child: Icon(CupertinoIcons.add_circled_solid, color: blanc, size: 32),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NOUVELLE ÉMISSION',
                  style: TextStyle(
                    color: blanc,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Créez et configurez une nouvelle émission TV',
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
              onTap: () => menuAdminBloc.setEmission(0),
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


  Widget _buildForm(BuildContext context, EmissionBloc emissionBloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Titre
        _buildTextField(
          context,
          label: 'Titre de l\'émission',
          hint: 'Entrez le titre de l\'émission',
          controller: emissionBloc.titre,
          icon: CupertinoIcons.textformat,
        ),
        const SizedBox(height: 24),
        
        // URL média
        _buildTextField(
          context,
          label: 'URL du média',
          hint: 'https://exemple.com/video.mp4',
          controller: emissionBloc.url,
          icon: CupertinoIcons.link,
        ),
        const SizedBox(height: 24),
        
        // Description
        _buildTextField(
          context,
          label: 'Description',
          hint: 'Décrivez brièvement l\'émission',
          controller: emissionBloc.desc,
          icon: CupertinoIcons.doc_text,
          maxLines: 4,
        ),
        const SizedBox(height: 24),
        
        // Heure
        _buildTextField(
          context,
          label: 'Heure de diffusion',
          hint: '20:00',
          controller: emissionBloc.heure,
          icon: CupertinoIcons.time,
        ),
        const SizedBox(height: 24),
        
        // Image Upload Section
        Text(
          'PHOTO DE COUVERTURE',
          style: TextStyle(
            color: noir,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildImageUploadButton(
                context,
                label: emissionBloc.fileModel == null
                    ? 'Parcourir la bibliothèque'
                    : 'Image sélectionnée ✓',
                icon: CupertinoIcons.photo_on_rectangle,
                onTap: () => emissionBloc.setParcourirFile(1),
                color: rouge,
                isSelected: emissionBloc.fileModel != null,
              ),
            ),
            if (emissionBloc.fileModel == null) ...[
              const SizedBox(width: 16),
              Expanded(
                child: _buildImageUploadButton(
                  context,
                  label: emissionBloc.imagePost[0] == null
                      ? 'Uploader un fichier'
                      : 'Fichier uploadé ✓',
                  icon: CupertinoIcons.cloud_upload,
                  onTap: () => emissionBloc.getImagePost(),
                  color: Colors.blue,
                  isSelected: emissionBloc.imagePost[0] != null,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 24),
        
        // Type d'émission
        Text(
          'TYPE D\'ÉMISSION',
          style: TextStyle(
            color: noir,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildTypeButton(
                context,
                label: 'Invité',
                icon: CupertinoIcons.person_2_fill,
                isSelected: emissionBloc.typeEmission == 0,
                onTap: () => emissionBloc.setTypeEmission(0),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTypeButton(
                context,
                label: 'À suivre',
                icon: CupertinoIcons.play_circle_fill,
                isSelected: emissionBloc.typeEmission == 1,
                onTap: () => emissionBloc.setTypeEmission(1),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            color: noir,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: noir,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: noir.withOpacity(0.4),
                fontSize: 14,
              ),
              prefixIcon: Icon(icon, color: noir.withOpacity(0.5), size: 20),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageUploadButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    required Color color,
    required bool isSelected,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isSelected
                  ? [Colors.green.shade400, Colors.green.shade600]
                  : [color.withOpacity(0.8), color],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSelected ? CupertinoIcons.checkmark_circle_fill : icon,
                color: blanc,
                size: 32,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: blanc,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeButton(
    BuildContext context, {
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
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(
                    colors: [rouge, rouge.withOpacity(0.8)],
                  )
                : null,
            color: isSelected ? null : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? rouge : Colors.grey.shade300,
              width: 2,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: rouge.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? blanc : noir.withOpacity(0.6),
                size: 32,
              ),
              const SizedBox(height: 8),
              Text(
                label.toUpperCase(),
                style: TextStyle(
                  color: isSelected ? blanc : noir,
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActions(
    BuildContext context,
    EmissionBloc emissionBloc,
    MenuAdminBloc menuAdminBloc,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Annuler
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => menuAdminBloc.setEmission(0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Icon(CupertinoIcons.xmark, color: noir, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    'ANNULER',
                    style: TextStyle(
                      color: noir,
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
        
        // Ajouter
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: emissionBloc.chargement ? null : () => emissionBloc.addEmission(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [rouge, rouge.withOpacity(0.8)],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: rouge.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  if (emissionBloc.chargement)
                    SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(blanc),
                      ),
                    )
                  else
                    Icon(CupertinoIcons.add_circled_solid, color: blanc, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    'AJOUTER ÉMISSION',
                    style: TextStyle(
                      color: blanc,
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
    );
  }


  Widget _buildMediaBrowser(BuildContext context, EmissionBloc emissionBloc) {
    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.shade600,
                Colors.blue.shade400,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
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
                child: Icon(CupertinoIcons.photo_on_rectangle, color: blanc, size: 32),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BIBLIOTHÈQUE MÉDIA',
                      style: TextStyle(
                        color: blanc,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Sélectionnez une image de couverture pour votre émission',
                      style: TextStyle(
                        color: blanc.withOpacity(0.9),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        // Search Bar
        Container(
          padding: const EdgeInsets.all(24),
          color: Colors.grey.shade50,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              onChanged: (value) => emissionBloc.setRecherche(value),
              decoration: InputDecoration(
                hintText: 'Rechercher dans la bibliothèque...',
                hintStyle: TextStyle(
                  color: noir.withOpacity(0.4),
                  fontSize: 14,
                ),
                prefixIcon: Icon(CupertinoIcons.search, color: noir.withOpacity(0.5)),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
          ),
        ),
        
        // Media Grid
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(24),
            color: Colors.grey.shade50,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 0.8,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: emissionBloc.filesModel.reversed
                  .where((e) => e.url!
                      .split("/")
                      .last
                      .toLowerCase()
                      .contains(emissionBloc.recherche.toLowerCase()))
                  .length,
              itemBuilder: (context, index) {
                final file = emissionBloc.filesModel.reversed
                    .where((e) => e.url!
                        .split("/")
                        .last
                        .toLowerCase()
                        .contains(emissionBloc.recherche.toLowerCase()))
                    .toList()[index];
                final isSelected = file == emissionBloc.fileModel;
                
                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => emissionBloc.setFileModel(file),
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
                            blurRadius: isSelected ? 15 : 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Image
                          Expanded(
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: BASE_URL_ASSET + file.url!,
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      color: Colors.grey.shade200,
                                      child: Center(
                                        child: SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation<Color>(
                                              Colors.blue,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => Container(
                                      color: Colors.grey.shade200,
                                      child: Icon(
                                        CupertinoIcons.exclamationmark_triangle,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                
                                // Selected Overlay
                                if (isSelected)
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.2),
                                        borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(16),
                                        ),
                                      ),
                                      child: Center(
                                        child: Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.2),
                                                blurRadius: 10,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            CupertinoIcons.checkmark,
                                            color: blanc,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          
                          // Filename
                          Container(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              file.url!
                                  .split("/")
                                  .last
                                  .split(".")[file.url!
                                      .split("/")
                                      .last
                                      .split(".")
                                      .length -
                                  2],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: noir,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        
        // Actions
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Annuler
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => emissionBloc.setParcourirFile(0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      children: [
                        Icon(CupertinoIcons.xmark, color: noir, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          'ANNULER',
                          style: TextStyle(
                            color: noir,
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
              
              // Sélectionner
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: emissionBloc.fileModel != null
                      ? () => emissionBloc.setParcourirFile(0)
                      : null,
                  child: Opacity(
                    opacity: emissionBloc.fileModel != null ? 1.0 : 0.5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.green, Colors.green.shade600],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: emissionBloc.fileModel != null
                            ? [
                                BoxShadow(
                                  color: Colors.green.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : [],
                      ),
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.checkmark_circle_fill, color: blanc, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            'SÉLECTIONNER',
                            style: TextStyle(
                              color: blanc,
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}
