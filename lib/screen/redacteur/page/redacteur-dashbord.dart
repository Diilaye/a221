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
import 'package:actu/screen/redacteur/page/params-dashbord-redacteur.dart';
import 'package:actu/utils/diallog-dii.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:actu/bloc/administrateur/menu-admin.dart';
import 'package:actu/bloc/administrateur/dashboard-stats-bloc.dart';

class RedacteurScreen extends StatefulWidget {
  const RedacteurScreen({super.key});

  @override
  State<RedacteurScreen> createState() => _RedacteurScreenState();
}

class _RedacteurScreenState extends State<RedacteurScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final menuAdminBloc = Provider.of<MenuAdminBloc>(context);
    final isMobile = MediaQuery.of(context).size.width < 900;

    return ChangeNotifierProvider(
      create: (_) => DashboardStatsBloc(),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.grey[100],
        appBar: isMobile ? _buildMobileAppBar(context) : null,
        drawer: isMobile ? _buildDrawer(context, menuAdminBloc) : null,
        body: isMobile
            ? _buildContent(menuAdminBloc)
            : Row(
                children: [
                  // Menu latéral moderne (desktop)
                  _buildSidebar(context, menuAdminBloc),
                  // Content area
                  Expanded(
                    child: _buildContent(menuAdminBloc),
                  ),
                ],
              ),
      ),
    );
  }

  PreferredSizeWidget _buildMobileAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(CupertinoIcons.bars),
        onPressed: () => _scaffoldKey.currentState?.openDrawer(),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.red.shade600,
                  Colors.red.shade800,
                ],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              CupertinoIcons.pencil_circle_fill,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 8),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Rédacteur',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.indigo.shade900,
              Colors.indigo.shade800,
              Colors.purple.shade900,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context, MenuAdminBloc menuAdminBloc) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.indigo.shade900,
              Colors.indigo.shade800,
              Colors.purple.shade900,
            ],
          ),
        ),
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  _buildMenuSection(
                    title: 'PRINCIPAL',
                    items: [
                      _MenuItem(
                        title: 'Dashboard',
                        icon: CupertinoIcons.chart_bar_square,
                        menuId: 0,
                        currentMenu: menuAdminBloc.menu,
                        onTap: () {
                          menuAdminBloc.setMenu(0);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildMenuSection(
                    title: 'CONTENU',
                    items: [
                      _MenuItem(
                        title: 'Journal',
                        icon: CupertinoIcons.news,
                        menuId: 1,
                        currentMenu: menuAdminBloc.menu,
                        onTap: () {
                          menuAdminBloc.setMenu(1);
                          Navigator.pop(context);
                        },
                        subItems: [
                          _SubMenuItem(
                            title: 'Articles',
                            menuId: 10,
                            currentMenu: menuAdminBloc.menu,
                            onTap: () {
                              menuAdminBloc.setMenu(10);
                              Navigator.pop(context);
                            },
                          ),
                          _SubMenuItem(
                            title: 'Ajouter Article',
                            menuId: 11,
                            currentMenu: menuAdminBloc.menu,
                            onTap: () {
                              menuAdminBloc.setMenu(11);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      _MenuItem(
                        title: 'TV',
                        icon: CupertinoIcons.tv,
                        menuId: 2,
                        currentMenu: menuAdminBloc.menu,
                        onTap: () {
                          menuAdminBloc.setMenu(2);
                          Navigator.pop(context);
                        },
                        subItems: [
                          _SubMenuItem(
                            title: 'Émissions',
                            menuId: 20,
                            currentMenu: menuAdminBloc.menu,
                            onTap: () {
                              menuAdminBloc.setMenu(20);
                              Navigator.pop(context);
                            },
                          ),
                          _SubMenuItem(
                            title: 'Ajouter Émission',
                            menuId: 21,
                            currentMenu: menuAdminBloc.menu,
                            onTap: () {
                              menuAdminBloc.setMenu(21);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      _MenuItem(
                        title: 'Posts Digitaux',
                        icon: CupertinoIcons.photo_on_rectangle,
                        menuId: 5,
                        currentMenu: menuAdminBloc.menu,
                        onTap: () {
                          menuAdminBloc.setMenu(5);
                          Navigator.pop(context);
                        },
                        subItems: [
                          _SubMenuItem(
                            title: 'Liste',
                            menuId: 50,
                            currentMenu: menuAdminBloc.menu,
                            onTap: () {
                              menuAdminBloc.setMenu(50);
                              Navigator.pop(context);
                            },
                          ),
                          _SubMenuItem(
                            title: 'Ajouter Post',
                            menuId: 51,
                            currentMenu: menuAdminBloc.menu,
                            onTap: () {
                              menuAdminBloc.setMenu(51);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildMenuSection(
                    title: 'SYSTÈME',
                    items: [
                      _MenuItem(
                        title: 'Paramètres',
                        icon: CupertinoIcons.settings,
                        menuId: 7,
                        currentMenu: menuAdminBloc.menu,
                        onTap: () {
                          menuAdminBloc.setMenu(7);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebar(BuildContext context, MenuAdminBloc menuAdminBloc) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.indigo.shade900,
            Colors.indigo.shade800,
            Colors.purple.shade900,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildHeader(context),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                _buildMenuSection(
                  title: 'PRINCIPAL',
                  items: [
                    _MenuItem(
                      title: 'Dashboard',
                      icon: CupertinoIcons.chart_bar_square,
                      menuId: 0,
                      currentMenu: menuAdminBloc.menu,
                      onTap: () => menuAdminBloc.setMenu(0),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildMenuSection(
                  title: 'CONTENU',
                  items: [
                    _MenuItem(
                      title: 'Journal',
                      icon: CupertinoIcons.news,
                      menuId: 1,
                      currentMenu: menuAdminBloc.menu,
                      onTap: () => menuAdminBloc.setMenu(1),
                      subItems: [
                        _SubMenuItem(
                          title: 'Articles',
                          menuId: 10,
                          currentMenu: menuAdminBloc.menu,
                          onTap: () => menuAdminBloc.setMenu(10),
                        ),
                        _SubMenuItem(
                          title: 'Ajouter Article',
                          menuId: 11,
                          currentMenu: menuAdminBloc.menu,
                          onTap: () => menuAdminBloc.setMenu(11),
                        ),
                      ],
                    ),
                    _MenuItem(
                      title: 'TV',
                      icon: CupertinoIcons.tv,
                      menuId: 2,
                      currentMenu: menuAdminBloc.menu,
                      onTap: () => menuAdminBloc.setMenu(2),
                      subItems: [
                        _SubMenuItem(
                          title: 'Émissions',
                          menuId: 20,
                          currentMenu: menuAdminBloc.menu,
                          onTap: () => menuAdminBloc.setMenu(20),
                        ),
                        _SubMenuItem(
                          title: 'Ajouter Émission',
                          menuId: 21,
                          currentMenu: menuAdminBloc.menu,
                          onTap: () => menuAdminBloc.setMenu(21),
                        ),
                      ],
                    ),
                    _MenuItem(
                      title: 'Posts Digitaux',
                      icon: CupertinoIcons.photo_on_rectangle,
                      menuId: 5,
                      currentMenu: menuAdminBloc.menu,
                      onTap: () => menuAdminBloc.setMenu(5),
                      subItems: [
                        _SubMenuItem(
                          title: 'Liste',
                          menuId: 50,
                          currentMenu: menuAdminBloc.menu,
                          onTap: () => menuAdminBloc.setMenu(50),
                        ),
                        _SubMenuItem(
                          title: 'Ajouter Post',
                          menuId: 51,
                          currentMenu: menuAdminBloc.menu,
                          onTap: () => menuAdminBloc.setMenu(51),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildMenuSection(
                  title: 'SYSTÈME',
                  items: [
                    _MenuItem(
                      title: 'Paramètres',
                      icon: CupertinoIcons.settings,
                      menuId: 7,
                      currentMenu: menuAdminBloc.menu,
                      onTap: () => menuAdminBloc.setMenu(7),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildContent(MenuAdminBloc menuAdminBloc) {
    return menuAdminBloc.menu == 0
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
                                            : menuAdminBloc.menu == 4
                                                ? const FlashNewsScreen()
                                                : menuAdminBloc.menu == 40
                                                    ? const FlashNewsScreen()
                                                    : menuAdminBloc.menu == 41
                                                        ? const AddFlashNewsScreen()
                                                        : menuAdminBloc.menu == 5
                                                            ? const PostDigiteauxScreen()
                                                            : menuAdminBloc.menu == 50
                                                                ? const PostDigiteauxScreen()
                                                                : menuAdminBloc.menu == 51
                                                                    ? const AddPostDigiteauxScreen()
                                                                    : menuAdminBloc.menu == 7
                                                                        ? const ParamsDashbordRedacteur()
                                                                        : Container();
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => context.go('/'),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.red.shade600,
                        Colors.red.shade800,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    CupertinoIcons.pencil_circle_fill,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Dashboard',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      'Rédacteur',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
              color: Colors.white.withOpacity(0.5),
              letterSpacing: 1.2,
            ),
          ),
        ),
        ...items,
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
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
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.red.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.square_arrow_left,
                  color: Colors.red.shade300,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  'Déconnexion',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.red.shade200,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatefulWidget {
  final String title;
  final IconData icon;
  final int menuId;
  final int currentMenu;
  final VoidCallback onTap;
  final List<Widget>? subItems;

  const _MenuItem({
    required this.title,
    required this.icon,
    required this.menuId,
    required this.currentMenu,
    required this.onTap,
    this.subItems,
  });

  @override
  State<_MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<_MenuItem> {
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    // Expand if any submenu is active
    if (widget.subItems != null) {
      isExpanded = widget.subItems!.any((item) {
        if (item is _SubMenuItem) {
          return item.menuId == widget.currentMenu;
        }
        return false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isActive = widget.menuId == widget.currentMenu;
    final hasSubItems = widget.subItems != null && widget.subItems!.isNotEmpty;

    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              if (hasSubItems) {
                setState(() {
                  isExpanded = !isExpanded;
                });
              }
              widget.onTap();
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              margin: const EdgeInsets.only(bottom: 4),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                gradient: isActive
                    ? LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.2),
                          Colors.white.withOpacity(0.1),
                        ],
                      )
                    : null,
                borderRadius: BorderRadius.circular(12),
                border: isActive
                    ? Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      )
                    : null,
              ),
              child: Row(
                children: [
                  Icon(
                    widget.icon,
                    color: isActive ? Colors.white : Colors.white.withOpacity(0.7),
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                        color: isActive ? Colors.white : Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ),
                  if (hasSubItems)
                    Icon(
                      isExpanded
                          ? CupertinoIcons.chevron_up
                          : CupertinoIcons.chevron_down,
                      color: isActive ? Colors.white : Colors.white.withOpacity(0.5),
                      size: 16,
                    ),
                ],
              ),
            ),
          ),
        ),
        if (hasSubItems && isExpanded)
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(children: widget.subItems!),
          ),
      ],
    );
  }
}

class _SubMenuItem extends StatelessWidget {
  final String title;
  final int menuId;
  final int currentMenu;
  final VoidCallback onTap;

  const _SubMenuItem({
    required this.title,
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
        borderRadius: BorderRadius.circular(10),
        child: Container(
          margin: const EdgeInsets.only(bottom: 4),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          decoration: BoxDecoration(
            color: isActive
                ? Colors.white.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: isActive
                      ? Colors.white
                      : Colors.white.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                    color: isActive
                        ? Colors.white
                        : Colors.white.withOpacity(0.6),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
