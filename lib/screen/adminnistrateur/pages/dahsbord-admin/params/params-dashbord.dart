import 'package:actu/bloc/administrateur/menu-admin.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/params/categories/categories-screen.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/params/mots-cles/key-word-screen.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/params/profile-sccren.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/params/tags/tags-screen.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/params/users/users-screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ParamsDashbord extends StatelessWidget {
  const ParamsDashbord({super.key});

  @override
  Widget build(BuildContext context) {
    final menuAdminBloc = Provider.of<MenuAdminBloc>(context);

    return Container(
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
      child: Row(
        children: [
          Container(
            width: 280,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(2, 0),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildSidebarHeader(context),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    children: [
                      _buildMenuItem(
                        context: context,
                        icon: CupertinoIcons.square_grid_2x2_fill,
                        title: 'Catégories',
                        isActive: menuAdminBloc.sousMenu == 0,
                        onTap: () => menuAdminBloc.setSousMenu(0),
                      ),
                      const SizedBox(height: 8),
                      _buildMenuItem(
                        context: context,
                        icon: CupertinoIcons.tag_fill,
                        title: 'Tags',
                        isActive: menuAdminBloc.sousMenu == 1,
                        onTap: () => menuAdminBloc.setSousMenu(1),
                      ),
                      const SizedBox(height: 8),
                      _buildMenuItem(
                        context: context,
                        icon: CupertinoIcons.textformat_alt,
                        title: 'Mots clés',
                        isActive: menuAdminBloc.sousMenu == 2,
                        onTap: () => menuAdminBloc.setSousMenu(2),
                      ),
                      const SizedBox(height: 8),
                      _buildMenuItem(
                        context: context,
                        icon: CupertinoIcons.person_2_fill,
                        title: 'Utilisateurs',
                        isActive: menuAdminBloc.sousMenu == 3,
                        onTap: () => menuAdminBloc.setSousMenu(3),
                      ),
                      const SizedBox(height: 8),
                      _buildMenuItem(
                        context: context,
                        icon: CupertinoIcons.lock_shield_fill,
                        title: 'Mot de passe',
                        isActive: menuAdminBloc.sousMenu == 4,
                        onTap: () => menuAdminBloc.setSousMenu(4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(24),
              child: menuAdminBloc.sousMenu == 0
                  ? const CategorieScreen()
                  : menuAdminBloc.sousMenu == 1
                      ? const TagScreen()
                      : menuAdminBloc.sousMenu == 2
                          ? const KeyWorlScreen()
                          : menuAdminBloc.sousMenu == 3
                              ? const UserScreen()
                              : menuAdminBloc.sousMenu == 4
                                  ? const ProfileUserScreen()
                                  : const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              CupertinoIcons.settings_solid,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'PARAMÈTRES',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Configuration du système',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              gradient: isActive
                  ? LinearGradient(
                      colors: [
                        Colors.indigo.shade700,
                        Colors.indigo.shade500,
                      ],
                    )
                  : null,
              color: isActive ? null : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: Colors.indigo.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [],
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isActive ? Colors.white : Colors.grey.shade600,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: isActive ? Colors.white : Colors.grey.shade800,
                      fontSize: 14,
                      fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                if (isActive)
                  Icon(
                    CupertinoIcons.chevron_right,
                    color: Colors.white,
                    size: 16,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
