import 'package:actu/bloc/administrateur/article-bloc.dart';
import 'package:actu/bloc/administrateur/menu-admin.dart';
import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/diallog-dii.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuMobileAdministratreur extends StatelessWidget {
  const MenuMobileAdministratreur({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    final menuAdminBloc = Provider.of<MenuAdminBloc>(context);
    final addArticleBloc = Provider.of<AddArticleBloc>(context);

    return Container(
      height: size.height - 60,
      width: size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.indigo.shade700,
            Colors.indigo.shade600,
            Colors.purple.shade600,
          ],
        ),
      ),
      child: Column(
        children: [
          // Header avec logo et fermeture
          _buildHeader(context, size, homeUtilisateurBloc),
          
          // Menu scrollable
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: blanc,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 4),
                    blurRadius: 20,
                    color: noir.withOpacity(0.15),
                  ),
                ],
              ),
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                children: [
                  // Section principale
                  _buildSectionTitle('NAVIGATION'),
                  _buildMenuItem(
                    context,
                    icon: CupertinoIcons.square_grid_2x2_fill,
                    title: 'Dashboard',
                    isActive: menuAdminBloc.menu == 0,
                    onTap: () {
                      menuAdminBloc.setMenu(0);
                      homeUtilisateurBloc.setShowMenuMobile();
                    },
                  ),
                  
                  // Journal
                  _buildParentMenuItem(
                    context,
                    icon: CupertinoIcons.doc_text_fill,
                    title: 'Journal',
                    isActive: menuAdminBloc.menu == 1 || menuAdminBloc.menu == 10 || menuAdminBloc.menu == 11,
                  ),
                  if (menuAdminBloc.menu == 1 || menuAdminBloc.menu == 10 || menuAdminBloc.menu == 11)
                    Column(
                      children: [
                        _buildSubMenuItem(
                          context,
                          title: 'Articles',
                          isActive: menuAdminBloc.menu == 10,
                          onTap: () {
                            menuAdminBloc.setMenu(10);
                            homeUtilisateurBloc.setShowMenuMobile();
                          },
                        ),
                        _buildSubMenuItem(
                          context,
                          title: 'Ajouter article',
                          isActive: menuAdminBloc.menu == 11,
                          onTap: () {
                            addArticleBloc.resetAddArticleForm();
                            menuAdminBloc.setMenu(11);
                            homeUtilisateurBloc.setShowMenuMobile();
                          },
                        ),
                      ],
                    ),
                  
                  // TV
                  _buildParentMenuItem(
                    context,
                    icon: CupertinoIcons.tv_fill,
                    title: 'TV',
                    isActive: menuAdminBloc.menu == 2 || menuAdminBloc.menu == 20 || menuAdminBloc.menu == 21,
                  ),
                  if (menuAdminBloc.menu == 2 || menuAdminBloc.menu == 20 || menuAdminBloc.menu == 21)
                    Column(
                      children: [
                        _buildSubMenuItem(
                          context,
                          title: 'Émissions',
                          isActive: menuAdminBloc.menu == 20,
                          onTap: () {
                            menuAdminBloc.setMenu(20);
                            homeUtilisateurBloc.setShowMenuMobile();
                          },
                        ),
                        _buildSubMenuItem(
                          context,
                          title: 'Ajouter émission',
                          isActive: menuAdminBloc.menu == 21,
                          onTap: () {
                            menuAdminBloc.setMenu(21);
                            homeUtilisateurBloc.setShowMenuMobile();
                          },
                        ),
                      ],
                    ),
                  
                  // Flash news
                  _buildParentMenuItem(
                    context,
                    icon: CupertinoIcons.bolt_fill,
                    title: 'Flash news',
                    isActive: menuAdminBloc.menu == 4 || menuAdminBloc.menu == 40 || menuAdminBloc.menu == 41,
                  ),
                  if (menuAdminBloc.menu == 4 || menuAdminBloc.menu == 40 || menuAdminBloc.menu == 41)
                    Column(
                      children: [
                        _buildSubMenuItem(
                          context,
                          title: 'Listes',
                          isActive: menuAdminBloc.menu == 40,
                          onTap: () {
                            menuAdminBloc.setMenu(40);
                            homeUtilisateurBloc.setShowMenuMobile();
                          },
                        ),
                        _buildSubMenuItem(
                          context,
                          title: 'Ajouter flash news',
                          isActive: menuAdminBloc.menu == 41,
                          onTap: () {
                            menuAdminBloc.setMenu(41);
                            homeUtilisateurBloc.setShowMenuMobile();
                          },
                        ),
                      ],
                    ),
                  
                  // Posts digitaux
                  _buildParentMenuItem(
                    context,
                    icon: CupertinoIcons.photo_fill,
                    title: 'Posts digitaux',
                    isActive: menuAdminBloc.menu == 5 || menuAdminBloc.menu == 50 || menuAdminBloc.menu == 51,
                  ),
                  if (menuAdminBloc.menu == 5 || menuAdminBloc.menu == 50 || menuAdminBloc.menu == 51)
                    Column(
                      children: [
                        _buildSubMenuItem(
                          context,
                          title: 'Liste',
                          isActive: menuAdminBloc.menu == 50,
                          onTap: () {
                            menuAdminBloc.setMenu(50);
                            homeUtilisateurBloc.setShowMenuMobile();
                          },
                        ),
                        _buildSubMenuItem(
                          context,
                          title: 'Ajouter post',
                          isActive: menuAdminBloc.menu == 51,
                          onTap: () {
                            menuAdminBloc.setMenu(51);
                            homeUtilisateurBloc.setShowMenuMobile();
                          },
                        ),
                      ],
                    ),
                  
                  const SizedBox(height: 8),
                  _buildDivider(),
                  
                  // Section paramètres
                  _buildSectionTitle('PARAMÈTRES'),
                  _buildMenuItem(
                    context,
                    icon: CupertinoIcons.settings_solid,
                    title: 'Paramètres',
                    isActive: menuAdminBloc.menu == 7,
                    onTap: () {
                      menuAdminBloc.setMenu(7);
                      homeUtilisateurBloc.setShowMenuMobile();
                    },
                  ),
                  
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
          
          // Bouton déconnexion
          _buildLogoutButton(context, size),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Size size, HomeUtilisateurBloc bloc) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Logo
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: blanc.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: blanc.withOpacity(0.3), width: 1),
            ),
            child: Row(
              children: [
                Icon(CupertinoIcons.square_grid_2x2_fill, color: blanc, size: 18),
                const SizedBox(width: 8),
                Text(
                  'Dashboard',
                  style: TextStyle(
                    color: blanc,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  'A221',
                  style: TextStyle(
                    color: jaune,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          // Bouton fermeture
          GestureDetector(
            onTap: () => bloc.setShowMenuMobile(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: blanc.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: blanc.withOpacity(0.3), width: 1),
              ),
              child: Icon(
                CupertinoIcons.xmark,
                color: blanc,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: gris.withOpacity(0.6),
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 1,
      color: Colors.grey.shade200,
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: isActive
              ? LinearGradient(
                  colors: [
                    Colors.indigo.shade700,
                    Colors.indigo.shade500,
                    Colors.purple.shade600,
                  ],
                )
              : null,
          color: isActive ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isActive
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
          children: [
            Icon(
              icon,
              size: 18,
              color: isActive ? blanc : gris,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive ? blanc : noir,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParentMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required bool isActive,
  }) {
    return GestureDetector(
      onTap: () {
        final menuAdminBloc = Provider.of<MenuAdminBloc>(context, listen: false);
        
        // Toggle logic pour les menus parents
        if (title == 'Journal') {
          menuAdminBloc.setMenu(isActive ? 0 : 1);
        } else if (title == 'TV') {
          menuAdminBloc.setMenu(isActive ? 0 : 2);
        } else if (title == 'Flash news') {
          menuAdminBloc.setMenu(isActive ? 0 : 4);
        } else if (title == 'Posts digitaux') {
          menuAdminBloc.setMenu(isActive ? 0 : 5);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? Colors.indigo.shade50 : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: isActive
              ? Border.all(color: Colors.indigo.shade200, width: 1)
              : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: isActive ? Colors.indigo.shade700 : gris,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  color: isActive ? Colors.indigo.shade700 : noir,
                  letterSpacing: 0.3,
                ),
              ),
            ),
            Icon(
              isActive ? CupertinoIcons.chevron_down : CupertinoIcons.chevron_right,
              size: 14,
              color: isActive ? Colors.indigo.shade700 : gris,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubMenuItem(
    BuildContext context, {
    required String title,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(left: 44, right: 12, top: 2, bottom: 2),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          gradient: isActive
              ? LinearGradient(
                  colors: [
                    Colors.indigo.shade700,
                    Colors.indigo.shade500,
                    Colors.purple.shade600,
                  ],
                )
              : null,
          color: isActive ? null : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    offset: const Offset(0, 2),
                    blurRadius: 8,
                    color: Colors.indigo.withOpacity(0.3),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? blanc : gris.withOpacity(0.5),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                color: isActive ? blanc : noir.withOpacity(0.8),
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          dialogRequest(
            context: context,
            title: "Voulez-vous vous déconnecter ?",
          ).then((value) {
            if (value) {
              SharedPreferences.getInstance().then((prefs) {
                prefs.clear();
                context.go("/");
              });
            }
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                rouge.withOpacity(0.9),
                rouge,
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 12,
                color: rouge.withOpacity(0.4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.logout_rounded,
                size: 18,
                color: blanc,
              ),
              const SizedBox(width: 10),
              Text(
                'DÉCONNEXION',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: blanc,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
