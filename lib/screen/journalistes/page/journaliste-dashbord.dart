import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/articles/add-screen.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/flash-news/add-flash-news.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/flash-news/flash-new.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/posts-digiteaux/add-post-digiteaux.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/posts-digiteaux/posts-digiteaux.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/presse-ecrite/add-presse-ecrite.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/presse-ecrite/presse-ecrite.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/tv/add-emission.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/tv/tv-screen.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/articles/journal-screen.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/overview-admin.dart';
import 'package:actu/screen/adminnistrateur/widgets/menu/item-menu.dart';
import 'package:actu/screen/journalistes/page/params-dashbord-journaliste.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/diallog-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:actu/bloc/administrateur/menu-admin.dart';

import '../../../bloc/utilisateur/home-bloc.dart';
import '../../../utils/responsive-ui.dart';
import '../../adminnistrateur/pages/dahsbord-admin/articles/add-screen-mobile.dart';
import '../../adminnistrateur/pages/dahsbord-admin/articles/journal-screen-mobile.dart';
import '../../adminnistrateur/pages/dahsbord-admin/flash-news/flash-new-mobile.dart';
import '../../adminnistrateur/pages/dahsbord-admin/params/params-dashbord-other.dart';
import '../../adminnistrateur/pages/dahsbord-admin/posts-digiteaux/add-post-digiteaux-mobile.dart';
import '../../adminnistrateur/pages/dahsbord-admin/posts-digiteaux/posts-digiteaux-mobile.dart';
import '../../adminnistrateur/pages/dahsbord-admin/presse-ecrite/add-presse-ecrite-MOBILE.dart';
import '../../adminnistrateur/pages/dahsbord-admin/presse-ecrite/presse-ecrite-mobile.dart';
import '../../adminnistrateur/pages/dahsbord-admin/tv/add-emission-mobile.dart';
import '../../adminnistrateur/pages/dahsbord-admin/tv/tv-screen-mobile.dart';
import '../../adminnistrateur/pages/mobile-dashbord-admin/mobile-overview-admin.dart';
import '../../utilisateur/widget/menu/menu-mobile-administrateur.dart';
import '../../utilisateur/widget/menu/menu-mobile-journaliste.dart';
import '../../utilisateur/widget/menu/top-bar-menu.dart';

class JournalisteScreen extends StatelessWidget {
  const JournalisteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final menuAdminBloc = Provider.of<MenuAdminBloc>(context);
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: .0,
          elevation: .0,
        ),
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: deviceName(size) == ScreenType.Desktop
              ? Row(
            children: [
              // Menu latéral moderne
              Container(
                width: 280,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xff1a1a2e),
                      Color(0xff16213e),
                      Color(0xff0f3460),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(4, 0),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // En-tête du menu
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            rouge.withOpacity(0.2),
                            Colors.transparent,
                          ],
                        ),
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.white.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                      ),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => context.go('/'),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [rouge, rouge.withOpacity(0.7)],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: rouge.withOpacity(0.4),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  CupertinoIcons.news,
                                  color: blanc,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Dashboard',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: rouge,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  Text(
                                    'Actu221',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    // Contenu du menu
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                        children: [
                          // Section Dashboard
                          _buildMenuSection('TABLEAU DE BORD'),
                          const SizedBox(height: 12),
                          _buildModernMenuItem(
                            context: context,
                            title: 'Vue d\'ensemble',
                            icon: CupertinoIcons.square_grid_2x2,
                            isActive: menuAdminBloc.menu == 0,
                            onTap: () => menuAdminBloc.setMenu(0),
                          ),
                          
                          const SizedBox(height: 24),
                          
                          // Section Articles
                          _buildMenuSection('ARTICLES'),
                          const SizedBox(height: 12),
                          _buildModernMenuItem(
                            context: context,
                            title: 'Tous les articles',
                            icon: CupertinoIcons.doc_text,
                            isActive: menuAdminBloc.menu == 1 || menuAdminBloc.menu == 10,
                            onTap: () => menuAdminBloc.setMenu(1),
                          ),
                          const SizedBox(height: 8),
                          _buildModernMenuItem(
                            context: context,
                            title: 'Nouvel article',
                            icon: CupertinoIcons.add_circled,
                            isActive: menuAdminBloc.menu == 11,
                            onTap: () => menuAdminBloc.setMenu(11),
                            isSubItem: true,
                          ),
                          
                          const SizedBox(height: 24),
                          
                          // Section Flash News
                          _buildMenuSection('FLASH NEWS'),
                          const SizedBox(height: 12),
                          _buildModernMenuItem(
                            context: context,
                            title: 'Toutes les infos',
                            icon: CupertinoIcons.bolt,
                            isActive: menuAdminBloc.menu == 4 || menuAdminBloc.menu == 40,
                            onTap: () => menuAdminBloc.setMenu(4),
                          ),
                          const SizedBox(height: 8),
                          _buildModernMenuItem(
                            context: context,
                            title: 'Ajouter un flash',
                            icon: CupertinoIcons.add_circled,
                            isActive: menuAdminBloc.menu == 41,
                            onTap: () => menuAdminBloc.setMenu(41),
                            isSubItem: true,
                          ),
                        ],
                      ),
                    ),
                    
                    // Bas du menu
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.white.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          _buildModernMenuItem(
                            context: context,
                            title: 'Paramètres',
                            icon: CupertinoIcons.settings,
                            isActive: menuAdminBloc.menu == 7,
                            onTap: () => menuAdminBloc.setMenu(7),
                          ),
                          const SizedBox(height: 8),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () => dialogRequest(
                                context: context,
                                title: "Voulez-vous vous déconnecter ?",
                              ).then((value) {
                                if (value) {
                                  SharedPreferences.getInstance().then((prefs) {
                                    prefs.clear();
                                    context.go("/");
                                  });
                                }
                              }),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                decoration: BoxDecoration(
                                  color: rouge.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: rouge.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.arrow_right_square,
                                      color: rouge,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      'Déconnexion',
                                      style: TextStyle(
                                        color: rouge,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
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
                ),
              
              ),
              // Zone de contenu principale
              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.grey[50]!,
                        Colors.white,
                        Colors.grey[50]!,
                      ],
                    ),
                  ),
                  child: menuAdminBloc.menu == 0
                      ? const OverViewAdmin()
                      : menuAdminBloc.menu == 1
                          ? const JournalScreen()
                          : menuAdminBloc.menu == 10
                              ? const JournalScreen()
                              : menuAdminBloc.menu == 11
                                  ? const AddArticleScreen()
                                  : menuAdminBloc.menu == 2
                                      ? const TvScreen()
                                      : menuAdminBloc.menu == 20
                                          ? const TvScreen()
                                          : menuAdminBloc.menu == 21
                                              ? const AddEmissionScreen()
                                              : menuAdminBloc.menu == 3
                                                  ? const PresseEcriteScreen()
                                                  : menuAdminBloc.menu == 30
                                                      ? const PresseEcriteScreen()
                                                      : menuAdminBloc.menu == 31
                                                          ? const AddPresseEcriteScreen()
                                                          : menuAdminBloc
                                                                      .menu ==
                                                                  4
                                                              ? const FlashNewsScreen()
                                                              : menuAdminBloc
                                                                          .menu ==
                                                                      40
                                                                  ? const FlashNewsScreen()
                                                                  : menuAdminBloc
                                                                              .menu ==
                                                                          41
                                                                      ? const AddFlashNewsScreen()
                                                                      : menuAdminBloc.menu ==
                                                                              5
                                                                          ? const PostDigiteauxScreen()
                                                                          : menuAdminBloc.menu == 50
                                                                              ? const PostDigiteauxScreen()
                                                                              : menuAdminBloc.menu == 51
                                                                                  ? const AddPostDigiteauxScreen()
                                                                                  : menuAdminBloc.menu == 7
                                                                                      ? const ParamsDashbordJournaliste()
                                                                                          : Container(),
                ),
              ),
            ],
          ) : Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                // Contenu principal avec animation
                Positioned(
                  top: 60,
                  bottom: 70, // Espace pour le bottom nav
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    switchInCurve: Curves.easeInOut,
                    switchOutCurve: Curves.easeInOut,
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.02, 0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: Container(
                      key: ValueKey<int>(menuAdminBloc.menu),
                      width: size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.grey[50]!,
                            Colors.white,
                            Colors.grey[50]!,
                          ],
                        ),
                      ),
                      child: _buildMobileScreen(menuAdminBloc.menu),
                    ),
                  ),
                ),
                
                // Top bar avec ombre
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const TopBarMenu(),
                  ),
                ),
                
                // Bottom Navigation Bar moderne
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xff1a1a2e),
                          Color(0xff16213e),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: SafeArea(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildNavItem(
                            context: context,
                            icon: CupertinoIcons.home,
                            label: 'Accueil',
                            isActive: menuAdminBloc.menu == 0,
                            onTap: () => menuAdminBloc.setMenu(0),
                          ),
                          _buildNavItem(
                            context: context,
                            icon: CupertinoIcons.doc_text,
                            label: 'Articles',
                            isActive: menuAdminBloc.menu == 1 || menuAdminBloc.menu == 10,
                            onTap: () => menuAdminBloc.setMenu(1),
                          ),
                          _buildAddButton(
                            context: context,
                            menuBloc: menuAdminBloc,
                          ),
                          _buildNavItem(
                            context: context,
                            icon: CupertinoIcons.bolt,
                            label: 'Flash',
                            isActive: menuAdminBloc.menu == 4 || menuAdminBloc.menu == 40,
                            onTap: () => menuAdminBloc.setMenu(4),
                          ),
                          _buildNavItem(
                            context: context,
                            icon: CupertinoIcons.settings,
                            label: 'Plus',
                            isActive: menuAdminBloc.menu == 7,
                            onTap: () => _showMoreMenu(context, menuAdminBloc),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  // Fonction helper pour gérer l'affichage des écrans mobiles
  Widget _buildMobileScreen(int menuIndex) {
    switch (menuIndex) {
      case 0:
        return const MobileOverViewAdmin();
      case 1:
      case 10:
        return const JournalScreenMobile();
      case 11:
        return const AddArticleScreenMobile();
      case 2:
      case 20:
        return const TvScreenMobile();
      case 21:
        return const AddEmissionScreenMobile();
      case 3:
      case 30:
        return const PresseEcriteScreenMobile();
      case 31:
        return const AddPresseEcriteScreenMobile();
      case 4:
      case 40:
        return const FlashNewsScreenMobile();
      case 41:
        return const AddFlashNewsScreen();
      case 5:
      case 50:
        return const PostDigiteauxScreenMobile();
      case 51:
        return const AddPostDigiteauxScreenMobile();
      case 7:
        return const ParamsDashbord();
      default:
        return Center(
          child: Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue[50]!,
                  Colors.blue[100]!,
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  CupertinoIcons.square_grid_2x2,
                  size: 64,
                  color: Colors.blue[700],
                ),
                const SizedBox(height: 16),
                Text(
                  'Sélectionnez une section',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Utilisez le menu pour naviguer',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue[700],
                  ),
                ),
              ],
            ),
          ),
        );
    }
  }

  // Widget pour les éléments de navigation
  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          gradient: isActive
              ? LinearGradient(
                  colors: [
                    rouge.withOpacity(0.2),
                    rouge.withOpacity(0.1),
                  ],
                )
              : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? rouge : Colors.white70,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                color: isActive ? rouge : Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Bouton d'ajout central
  Widget _buildAddButton({
    required BuildContext context,
    required MenuAdminBloc menuBloc,
  }) {
    return GestureDetector(
      onTap: () => _showAddMenu(context, menuBloc),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              rouge,
              rouge.withOpacity(0.8),
            ],
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: rouge.withOpacity(0.4),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          CupertinoIcons.add,
          color: blanc,
          size: 28,
        ),
      ),
    );
  }

  // Menu d'ajout
  void _showAddMenu(BuildContext context, MenuAdminBloc menuBloc) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff1a1a2e),
              Color(0xff16213e),
            ],
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Ajouter du contenu',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: blanc,
              ),
            ),
            const SizedBox(height: 20),
            _buildAddMenuItem(
              context: context,
              icon: CupertinoIcons.doc_text,
              title: 'Nouvel article',
              subtitle: 'Rédiger un article',
              onTap: () {
                Navigator.pop(context);
                menuBloc.setMenu(11);
              },
            ),
            _buildAddMenuItem(
              context: context,
              icon: CupertinoIcons.bolt,
              title: 'Flash news',
              subtitle: 'Ajouter une info flash',
              onTap: () {
                Navigator.pop(context);
                menuBloc.setMenu(41);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildAddMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              rouge.withOpacity(0.2),
              rouge.withOpacity(0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: rouge, size: 24),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: blanc,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.white70,
          fontSize: 13,
        ),
      ),
      onTap: onTap,
    );
  }

  // Menu "Plus"
  void _showMoreMenu(BuildContext context, MenuAdminBloc menuBloc) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff1a1a2e),
              Color(0xff16213e),
            ],
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Plus d\'options',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: blanc,
              ),
            ),
            const SizedBox(height: 20),
            _buildMoreMenuItem(
              context: context,
              icon: CupertinoIcons.settings,
              title: 'Paramètres',
              onTap: () {
                Navigator.pop(context);
                menuBloc.setMenu(7);
              },
            ),
            _buildMoreMenuItem(
              context: context,
              icon: CupertinoIcons.arrow_right_square,
              title: 'Déconnexion',
              color: rouge,
              onTap: () {
                Navigator.pop(context);
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
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMoreMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    Color? color,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: (color ?? blanc).withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color ?? blanc, size: 24),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: color ?? blanc,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
    );
  }
  
  // Section du menu web
  Widget _buildMenuSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Colors.white.withOpacity(0.5),
          letterSpacing: 1.2,
        ),
      ),
    );
  }
  
  // Item de menu moderne pour web
  Widget _buildModernMenuItem({
    required BuildContext context,
    required String title,
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
    bool isSubItem = false,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.only(left: isSubItem ? 16 : 0),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            gradient: isActive
                ? LinearGradient(
                    colors: [
                      rouge,
                      rouge.withOpacity(0.8),
                    ],
                  )
                : null,
            borderRadius: BorderRadius.circular(12),
            border: isActive
                ? null
                : Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: rouge.withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isActive ? blanc : Colors.white70,
                size: isSubItem ? 18 : 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: isActive ? blanc : Colors.white70,
                    fontSize: isSubItem ? 13 : 14,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (isActive)
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: blanc,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: blanc.withOpacity(0.5),
                        blurRadius: 8,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
