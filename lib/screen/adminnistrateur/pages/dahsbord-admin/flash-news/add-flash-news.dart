import 'package:actu/bloc/administrateur/flash-news-bloc.dart';
import 'package:actu/bloc/administrateur/menu-admin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddFlashNewsScreen extends StatefulWidget {
  const AddFlashNewsScreen({super.key});

  @override
  State<AddFlashNewsScreen> createState() => _AddFlashNewsScreenState();
}

class _AddFlashNewsScreenState extends State<AddFlashNewsScreen> {
  final List<String> _flashTypes = [
    'URGENT',
    'BREAKING',
    'INFO',
    'ALERTE',
    'DERNIÈRE MINUTE',
  ];

  @override
  Widget build(BuildContext context) {
    final flashNewsBloc = Provider.of<FlashNewsBloc>(context);
    final menuAdminBloc = Provider.of<MenuAdminBloc>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, menuAdminBloc),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFormCard(flashNewsBloc),
                    const SizedBox(height: 24),
                    _buildActionButtons(flashNewsBloc, menuAdminBloc),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, MenuAdminBloc menuAdminBloc) {
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
                  onTap: () => menuAdminBloc.setFlashNews(0),
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
                      const Text(
                        'NOUVELLE FLASH NEWS',
                        style: TextStyle(
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
                            'Flash News',
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
                          const Expanded(
                            child: Text(
                              'Nouveau',
                              style: TextStyle(
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

  Widget _buildFormCard(FlashNewsBloc flashNewsBloc) {
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
            // En-tête de section
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
                    CupertinoIcons.bolt_fill,
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

            // Type de Flash
            _buildLabel('TYPE DE FLASH', CupertinoIcons.tag_fill),
            const SizedBox(height: 12),
            
            // Sélection rapide de type
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _flashTypes.map((type) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      flashNewsBloc.type.text = type;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      gradient: flashNewsBloc.type.text == type
                          ? LinearGradient(
                              colors: [
                                Colors.indigo.shade600,
                                Colors.purple.shade600,
                              ],
                            )
                          : null,
                      color: flashNewsBloc.type.text != type
                          ? Colors.grey[100]
                          : null,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: flashNewsBloc.type.text == type
                            ? Colors.indigo.shade600
                            : Colors.grey[300]!,
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          CupertinoIcons.bolt_fill,
                          size: 14,
                          color: flashNewsBloc.type.text == type
                              ? Colors.white
                              : Colors.grey[600],
                        ),
                        const SizedBox(width: 6),
                        Text(
                          type,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: flashNewsBloc.type.text == type
                                ? Colors.white
                                : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 12),

            // Champ texte personnalisé
            _buildTextField(
              controller: flashNewsBloc.type,
              hint: 'Ou saisissez un type personnalisé...',
              icon: CupertinoIcons.pencil,
              maxLines: 1,
            ),

            const SizedBox(height: 24),

            // Description
            _buildLabel('CONTENU', CupertinoIcons.doc_text_fill),
            const SizedBox(height: 12),
            _buildTextField(
              controller: flashNewsBloc.desc,
              hint: 'Rédigez le contenu de votre flash news...',
              icon: CupertinoIcons.text_alignleft,
              maxLines: 5,
            ),

            const SizedBox(height: 8),

            // Compteur de caractères
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  CupertinoIcons.info_circle,
                  size: 14,
                  color: Colors.grey[400],
                ),
                const SizedBox(width: 6),
                Text(
                  '${flashNewsBloc.desc.text.length} caractères',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
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
    required int maxLines,
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
        maxLines: maxLines,
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

  Widget _buildActionButtons(FlashNewsBloc flashNewsBloc, MenuAdminBloc menuAdminBloc) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => menuAdminBloc.setFlashNews(0),
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
            onTap: flashNewsBloc.chargement ? null : () => flashNewsBloc.add(),
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
                  if (flashNewsBloc.chargement)
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
                      CupertinoIcons.checkmark_alt,
                      color: Colors.white,
                      size: 20,
                    ),
                  const SizedBox(width: 8),
                  Text(
                    flashNewsBloc.chargement ? 'Publication...' : 'Publier',
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
}
