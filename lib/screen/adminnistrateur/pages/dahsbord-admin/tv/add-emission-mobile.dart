import 'package:actu/bloc/administrateur/emission-bloc.dart';
import 'package:actu/bloc/administrateur/menu-admin.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEmissionScreenMobile extends StatefulWidget {
  const AddEmissionScreenMobile({super.key});

  @override
  State<AddEmissionScreenMobile> createState() =>
      _AddEmissionScreenMobileState();
}

class _AddEmissionScreenMobileState extends State<AddEmissionScreenMobile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final emissionBloc = Provider.of<EmissionBloc>(context);
    final menuAdminBloc = Provider.of<MenuAdminBloc>(context);

    return Container(
      color: Colors.grey.shade50,
      child: emissionBloc.parcourirFile == 0
          ? _buildMainForm(context, size, emissionBloc, menuAdminBloc)
          : _buildMediaSelector(context, size, emissionBloc),
    );
  }

  Widget _buildMainForm(BuildContext context, Size size, EmissionBloc emissionBloc, MenuAdminBloc menuAdminBloc) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildHeader(context, menuAdminBloc),
        const SizedBox(height: 24),
        _buildFormCard(context, emissionBloc),
        const SizedBox(height: 16),
        _buildImageSection(context, emissionBloc),
        const SizedBox(height: 16),
        _buildTypeSelector(context, emissionBloc),
        const SizedBox(height: 24),
        _buildActionButtons(context, emissionBloc, menuAdminBloc),
        const SizedBox(height: 64),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, MenuAdminBloc menuAdminBloc) {
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
      child: Row(
        children: [
          GestureDetector(
            onTap: () => menuAdminBloc.setEmission(0),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: blanc.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                CupertinoIcons.back,
                color: blanc,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NOUVELLE ÉMISSION',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: blanc,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Ajoutez une nouvelle émission TV',
                  style: TextStyle(
                    fontSize: 12,
                    color: blanc.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            CupertinoIcons.tv,
            color: blanc.withOpacity(0.9),
            size: 28,
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard(BuildContext context, EmissionBloc emissionBloc) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(CupertinoIcons.doc_text, size: 16, color: Colors.indigo.shade700),
              const SizedBox(width: 8),
              Text(
                'INFORMATIONS',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.indigo.shade700,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Titre
          _buildLabel('TITRE DE L\'ÉMISSION'),
          const SizedBox(height: 8),
          _buildTextField(
            controller: emissionBloc.titre,
            hint: 'Ex: Journal Télévisé',
            icon: CupertinoIcons.textformat,
          ),
          const SizedBox(height: 16),
          // URL média
          _buildLabel('URL MÉDIA'),
          const SizedBox(height: 8),
          _buildTextField(
            controller: emissionBloc.url,
            hint: 'https://exemple.com/video',
            icon: CupertinoIcons.link,
          ),
          const SizedBox(height: 16),
          // Description
          _buildLabel('DESCRIPTION'),
          const SizedBox(height: 8),
          _buildTextField(
            controller: emissionBloc.desc,
            hint: 'Décrivez l\'émission...',
            icon: CupertinoIcons.text_alignleft,
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          // Heure
          _buildLabel('HEURE DE DIFFUSION'),
          const SizedBox(height: 8),
          _buildTextField(
            controller: emissionBloc.heure,
            hint: 'Ex: 20:00',
            icon: CupertinoIcons.clock,
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: noir.withOpacity(0.7),
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade400,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Icon(icon, size: 18, color: Colors.grey.shade400),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context, EmissionBloc emissionBloc) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(CupertinoIcons.photo, size: 16, color: Colors.indigo.shade700),
              const SizedBox(width: 8),
              Text(
                'IMAGE DE COUVERTURE',
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
          Row(
            children: [
              // Parcourir fichiers
              Expanded(
                child: GestureDetector(
                  onTap: () => emissionBloc.setParcourirFile(1),
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: emissionBloc.fileModel == null
                          ? LinearGradient(
                              colors: [
                                Colors.indigo.shade600,
                                Colors.indigo.shade400,
                              ],
                            )
                          : LinearGradient(
                              colors: [
                                Colors.green.shade600,
                                Colors.green.shade400,
                              ],
                            ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 2),
                          blurRadius: 8,
                          color: (emissionBloc.fileModel == null
                                  ? Colors.indigo
                                  : Colors.green)
                              .withOpacity(0.3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          emissionBloc.fileModel == null
                              ? CupertinoIcons.folder
                              : CupertinoIcons.checkmark_circle_fill,
                          color: blanc,
                          size: 32,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          emissionBloc.fileModel == null
                              ? 'Parcourir\nles fichiers'
                              : 'Image\nsélectionnée',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: blanc,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (emissionBloc.fileModel == null) ...[
                const SizedBox(width: 12),
                // Uploader image
                Expanded(
                  child: GestureDetector(
                    onTap: () => emissionBloc.getImagePost(),
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        gradient: emissionBloc.imagePost[0] == null
                            ? LinearGradient(
                                colors: [
                                  Colors.grey.shade700,
                                  Colors.grey.shade500,
                                ],
                              )
                            : LinearGradient(
                                colors: [
                                  Colors.green.shade600,
                                  Colors.green.shade400,
                                ],
                              ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 2),
                            blurRadius: 8,
                            color: (emissionBloc.imagePost[0] == null
                                    ? Colors.grey
                                    : Colors.green)
                                .withOpacity(0.3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            emissionBloc.imagePost[0] == null
                                ? CupertinoIcons.cloud_upload
                                : CupertinoIcons.checkmark_circle_fill,
                            color: blanc,
                            size: 32,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            emissionBloc.imagePost[0] == null
                                ? 'Uploader\nune image'
                                : 'Image\nuploa dée',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: blanc,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTypeSelector(BuildContext context, EmissionBloc emissionBloc) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(CupertinoIcons.tag, size: 16, color: Colors.indigo.shade700),
              const SizedBox(width: 8),
              Text(
                'TYPE D\'ÉMISSION',
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
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => emissionBloc.setTypeEmission(0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      gradient: emissionBloc.typeEmission == 0
                          ? LinearGradient(
                              colors: [
                                Colors.green.shade600,
                                Colors.green.shade400,
                              ],
                            )
                          : null,
                      color: emissionBloc.typeEmission == 0
                          ? null
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: emissionBloc.typeEmission == 0
                            ? Colors.transparent
                            : Colors.grey.shade300,
                        width: 1,
                      ),
                      boxShadow: emissionBloc.typeEmission == 0
                          ? [
                              BoxShadow(
                                offset: const Offset(0, 4),
                                blurRadius: 12,
                                color: Colors.green.withOpacity(0.3),
                              ),
                            ]
                          : null,
                    ),
                    child: Column(
                      children: [
                        Icon(
                          CupertinoIcons.person_2_fill,
                          size: 28,
                          color: emissionBloc.typeEmission == 0
                              ? blanc
                              : Colors.grey.shade600,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'INVITÉ',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: emissionBloc.typeEmission == 0
                                ? blanc
                                : Colors.grey.shade700,
                            letterSpacing: 0.5,
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
                  onTap: () => emissionBloc.setTypeEmission(1),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      gradient: emissionBloc.typeEmission == 1
                          ? LinearGradient(
                              colors: [
                                Colors.red.shade600,
                                Colors.red.shade400,
                              ],
                            )
                          : null,
                      color: emissionBloc.typeEmission == 1
                          ? null
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: emissionBloc.typeEmission == 1
                            ? Colors.transparent
                            : Colors.grey.shade300,
                        width: 1,
                      ),
                      boxShadow: emissionBloc.typeEmission == 1
                          ? [
                              BoxShadow(
                                offset: const Offset(0, 4),
                                blurRadius: 12,
                                color: Colors.red.withOpacity(0.3),
                              ),
                            ]
                          : null,
                    ),
                    child: Column(
                      children: [
                        Icon(
                          CupertinoIcons.eye_fill,
                          size: 28,
                          color: emissionBloc.typeEmission == 1
                              ? blanc
                              : Colors.grey.shade600,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'À SUIVRE',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: emissionBloc.typeEmission == 1
                                ? blanc
                                : Colors.grey.shade700,
                            letterSpacing: 0.5,
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

  Widget _buildActionButtons(BuildContext context, EmissionBloc emissionBloc, MenuAdminBloc menuAdminBloc) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => menuAdminBloc.setEmission(0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300, width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.xmark, size: 18, color: Colors.grey.shade700),
                  const SizedBox(width: 8),
                  Text(
                    'ANNULER',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade700,
                      letterSpacing: 0.5,
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
            onTap: () => emissionBloc.addEmission(),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.indigo.shade700,
                    Colors.indigo.shade500,
                    Colors.purple.shade600,
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 4),
                    blurRadius: 12,
                    color: Colors.indigo.withOpacity(0.3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (emissionBloc.chargement)
                    SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(blanc),
                      ),
                    )
                  else ...[
                    Icon(CupertinoIcons.add_circled_solid, size: 18, color: blanc),
                    const SizedBox(width: 8),
                    Text(
                      'AJOUTER L\'ÉMISSION',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: blanc,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMediaSelector(BuildContext context, Size size, EmissionBloc emissionBloc) {
    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(16),
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
          ),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => emissionBloc.setParcourirFile(0),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: blanc.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        CupertinoIcons.back,
                        color: blanc,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'SÉLECTIONNER UN MÉDIA',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: blanc,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  Icon(CupertinoIcons.photo_fill, color: blanc, size: 24),
                ],
              ),
              const SizedBox(height: 16),
              // Recherche
              Container(
                decoration: BoxDecoration(
                  color: blanc,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  onChanged: (value) => emissionBloc.setRecherche(value),
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    hintText: 'Rechercher un fichier...',
                    hintStyle: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w500,
                    ),
                    prefixIcon: Icon(CupertinoIcons.search, size: 18, color: Colors.grey.shade400),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Grid
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade50,
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: emissionBloc.filesModel.reversed
                  .where((e) => e.url!
                      .split("/")
                      .last
                      .toLowerCase()
                      .contains(emissionBloc.recherche.toLowerCase()))
                  .map((e) => GestureDetector(
                        onTap: () => emissionBloc.setFileModel(e),
                        child: Container(
                          decoration: BoxDecoration(
                            color: blanc,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: e == emissionBloc.fileModel
                                  ? Colors.green.shade500
                                  : Colors.grey.shade200,
                              width: e == emissionBloc.fileModel ? 3 : 1,
                            ),
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
                              Expanded(
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: BASE_URL_ASSET + e.url!,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation<Color>(
                                                Colors.indigo.shade400),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) => Center(
                                          child: Icon(
                                            CupertinoIcons.photo,
                                            size: 32,
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (e == emissionBloc.fileModel)
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: Colors.green.shade500,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                offset: const Offset(0, 2),
                                                blurRadius: 8,
                                                color: Colors.green.withOpacity(0.4),
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            CupertinoIcons.checkmark,
                                            size: 16,
                                            color: blanc,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  e.url!.split("/").last.split(".")[
                                      e.url!.split("/").last.split(".").length - 2],
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: noir,
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
        // Actions
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: blanc,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, -2),
                blurRadius: 8,
                color: noir.withOpacity(0.04),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => emissionBloc.setParcourirFile(0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                    ),
                    child: Center(
                      child: Text(
                        'ANNULER',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey.shade700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: emissionBloc.fileModel != null
                      ? () => emissionBloc.setParcourirFile(0)
                      : null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      gradient: emissionBloc.fileModel != null
                          ? LinearGradient(
                              colors: [
                                Colors.indigo.shade700,
                                Colors.indigo.shade500,
                                Colors.purple.shade600,
                              ],
                            )
                          : null,
                      color: emissionBloc.fileModel != null
                          ? null
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: emissionBloc.fileModel != null
                          ? [
                              BoxShadow(
                                offset: const Offset(0, 4),
                                blurRadius: 12,
                                color: Colors.indigo.withOpacity(0.3),
                              ),
                            ]
                          : null,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.checkmark_circle_fill,
                          size: 18,
                          color: emissionBloc.fileModel != null
                              ? blanc
                              : Colors.grey.shade500,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'SÉLECTIONNER',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: emissionBloc.fileModel != null
                                ? blanc
                                : Colors.grey.shade500,
                            letterSpacing: 0.5,
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
  }
}
