import 'package:actu/bloc/administrateur/menu-admin.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/params/profile-sccren.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/params/tags/tags-screen.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/params/users/users-screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ParamsDashbordRedacteur extends StatelessWidget {
  const ParamsDashbordRedacteur({super.key});

  @override
  Widget build(BuildContext context) {
    final menuAdminBloc = Provider.of<MenuAdminBloc>(context);

    return Container(
      color: Colors.grey[50],
      child: Row(
        children: [
          // Menu latéral des paramètres
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.indigo.shade600,
                        Colors.purple.shade600,
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          CupertinoIcons.settings,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'PARAMÈTRES',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Menu items
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    children: [
                      _buildMenuSection(
                        title: 'GÉNÉRAL',
                        items: [
                          _ParamMenuItem(
                            title: 'Tags',
                            subtitle: 'Gérer les tags',
                            icon: CupertinoIcons.tag,
                            menuId: 2,
                            currentMenu: menuAdminBloc.sousMenu,
                            onTap: () => menuAdminBloc.setSousMenu(2),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildMenuSection(
                        title: 'COMPTE',
                        items: [
                          _ParamMenuItem(
                            title: 'Utilisateur',
                            subtitle: 'Informations personnelles',
                            icon: CupertinoIcons.person_circle,
                            menuId: 4,
                            currentMenu: menuAdminBloc.sousMenu,
                            onTap: () => menuAdminBloc.setSousMenu(4),
                          ),
                          _ParamMenuItem(
                            title: 'Mot de passe',
                            subtitle: 'Sécurité du compte',
                            icon: CupertinoIcons.lock_shield,
                            menuId: 5,
                            currentMenu: menuAdminBloc.sousMenu,
                            onTap: () => menuAdminBloc.setSousMenu(5),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Content area
          Expanded(
            child: menuAdminBloc.sousMenu == 2
                ? const TagScreen()
                : menuAdminBloc.sousMenu == 4
                    ? const UserScreen()
                    : menuAdminBloc.sousMenu == 5
                        ? const ProfileUserScreen()
                        : _buildWelcomeScreen(),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection({required String title, required List<Widget> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade600,
              letterSpacing: 1.2,
            ),
          ),
        ),
        ...items,
      ],
    );
  }

  Widget _buildWelcomeScreen() {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.indigo.shade100,
                    Colors.purple.shade100,
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                CupertinoIcons.settings,
                size: 64,
                color: Colors.indigo.shade700,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Paramètres du compte',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Sélectionnez une option dans le menu',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ParamMenuItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final int menuId;
  final int currentMenu;
  final VoidCallback onTap;

  const _ParamMenuItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.menuId,
    required this.currentMenu,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = menuId == currentMenu;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isActive ? Colors.indigo.shade50 : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: isActive
                ? Border.all(
                    color: Colors.indigo.shade300,
                    width: 2,
                  )
                : null,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: isActive
                      ? LinearGradient(
                          colors: [
                            Colors.indigo.shade600,
                            Colors.purple.shade600,
                          ],
                        )
                      : null,
                  color: isActive ? null : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: isActive ? Colors.white : Colors.grey.shade700,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isActive ? Colors.indigo.shade900 : Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: isActive ? Colors.indigo.shade700 : Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              if (isActive)
                Icon(
                  CupertinoIcons.chevron_right,
                  color: Colors.indigo.shade600,
                  size: 16,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
