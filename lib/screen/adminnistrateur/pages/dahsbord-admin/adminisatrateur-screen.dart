import 'package:actu/bloc/administrateur/article-bloc.dart';
import 'package:actu/bloc/administrateur/dashboard-stats-bloc.dart';
import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/bloc/utilisateur/posts-digiteaux.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/articles/add-screen-mobile.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/articles/add-screen.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/articles/journal-screen-mobile.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/flash-news/add-flash-news.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/flash-news/flash-new-mobile.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/flash-news/flash-new.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/params/params-dashbord.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/posts-digiteaux/add-post-digiteaux-mobile.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/posts-digiteaux/add-post-digiteaux.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/posts-digiteaux/posts-digiteaux-mobile.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/posts-digiteaux/posts-digiteaux.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/presse-ecrite/add-presse-ecrite-MOBILE.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/presse-ecrite/add-presse-ecrite.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/presse-ecrite/presse-ecrite-mobile.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/presse-ecrite/presse-ecrite.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/tv/add-emission-mobile.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/tv/add-emission.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/tv/tv-screen-mobile.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/tv/tv-screen.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/articles/journal-screen.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/overview-admin.dart';
import 'package:actu/screen/adminnistrateur/pages/mobile-dashbord-admin/mobile-overview-admin.dart';
import 'package:actu/screen/adminnistrateur/widgets/menu/item-menu.dart';
import 'package:actu/screen/utilisateur/widget/menu/menu-mobile-administrateur.dart';
import 'package:actu/screen/utilisateur/widget/menu/top-bar-menu.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/diallog-dii.dart';
import 'package:actu/utils/responsive-ui.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:actu/bloc/administrateur/menu-admin.dart';

class AdministrateurAscreen extends StatelessWidget {
  const AdministrateurAscreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final menuAdminBloc = Provider.of<MenuAdminBloc>(context);
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    final addArticleBloc = Provider.of<AddArticleBloc>(context);

    return ChangeNotifierProvider(
      create: (_) => DashboardStatsBloc(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: .0,
          elevation: .0,
        ),
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: deviceName(size) == ScreenType.Desktop
              ? SizedBox(
                  height: size.height - 60,
                  width: size.width,
                  child: Row(
                    children: [
                      // Menu latéral modernisé
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xff1a1a2e), // Bleu nuit profond
                              Color(0xff16213e), // Bleu nuit
                              Color(0xff0f3460), // Bleu foncé
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(2, 0),
                              blurRadius: 20,
                              color: noir.withOpacity(.3),
                              spreadRadius: 2,
                            )
                          ],
                        ),
                        child: ListView(
                          children: [
                            SizedBox(
                              height: size.height * .03,
                            ),
                            // Logo modernisé
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () => context.go('/'),
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: size.width * .02),
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        rouge.withOpacity(0.2),
                                        rouge.withOpacity(0.1),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: rouge.withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        CupertinoIcons.square_grid_2x2_fill,
                                        color: rouge,
                                        size: 20,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Dashboard',
                                        style: fontFammilyDii(context, 16, blanc,
                                            FontWeight.w800, FontStyle.normal),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        'A221',
                                        style: fontFammilyDii(context, 16, rouge,
                                            FontWeight.w800, FontStyle.normal),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * .03,
                            ),
                            // Séparateur avec texte
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: size.width * .02),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.transparent,
                                            blanc.withOpacity(0.2),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8),
                                    child: Text(
                                      'MENU',
                                      style: fontFammilyDii(
                                        context,
                                        10,
                                        blanc.withOpacity(0.5),
                                        FontWeight.w600,
                                        FontStyle.normal,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            blanc.withOpacity(0.2),
                                            Colors.transparent,
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.height * .02,
                            ),
                            ItemMenu(
                              titre: 'Dashbord',
                              icons: CupertinoIcons.circle_fill,
                              haveIcon: false,
                              isActive: menuAdminBloc.menu == 0,
                              ontap: () => menuAdminBloc.setMenu(0),
                            ),
                            SizedBox(
                              height: size.height * .02,
                            ),
                            ItemMenu(
                              titre: 'Journal',
                              icons: CupertinoIcons.circle_fill,
                              haveIcon: false,
                              isActive: menuAdminBloc.menu == 1,
                              ontap: () => menuAdminBloc.setMenu(1),
                            ),
                            ItemMenu(
                              titre: 'Article',
                              icons: CupertinoIcons.circle,
                              isActive: menuAdminBloc.menu == 10,
                              ontap: () => menuAdminBloc.setMenu(10),
                            ),
                            ItemMenu(
                              titre: 'Ajouter Article',
                              icons: CupertinoIcons.circle,
                              isActive: menuAdminBloc.menu == 11,
                              ontap: () {
                                addArticleBloc.resetAddArticleForm();
                                menuAdminBloc.setMenu(11);
                              },
                            ),
                            ItemMenu(
                              titre: 'TV',
                              icons: CupertinoIcons.circle_fill,
                              haveIcon: false,
                              isActive: menuAdminBloc.menu == 2,
                              ontap: () => menuAdminBloc.setMenu(2),
                            ),
                            ItemMenu(
                              titre: 'Emissions',
                              icons: CupertinoIcons.circle,
                              isActive: menuAdminBloc.menu == 20,
                              ontap: () => menuAdminBloc.setMenu(20),
                            ),
                            ItemMenu(
                              titre: 'Ajouter une emission',
                              icons: CupertinoIcons.circle,
                              isActive: menuAdminBloc.menu == 21,
                              ontap: () => menuAdminBloc.setMenu(21),
                            ),
                            ItemMenu(
                              titre: 'Presse écrite',
                              icons: CupertinoIcons.circle_fill,
                              haveIcon: false,
                              isActive: menuAdminBloc.menu == 3,
                              ontap: () => menuAdminBloc.setMenu(3),
                            ),
                            ItemMenu(
                              titre: 'Journal papier',
                              icons: CupertinoIcons.circle,
                              isActive: menuAdminBloc.menu == 30,
                              ontap: () => menuAdminBloc.setMenu(30),
                            ),
                            ItemMenu(
                              titre: 'Ajouter journal papier',
                              icons: CupertinoIcons.circle,
                              isActive: menuAdminBloc.menu == 31,
                              ontap: () => menuAdminBloc.setMenu(31),
                            ),
                            ItemMenu(
                              titre: 'Flash news',
                              icons: CupertinoIcons.circle_fill,
                              haveIcon: false,
                              isActive: menuAdminBloc.menu == 4,
                              ontap: () => menuAdminBloc.setMenu(4),
                            ),
                            ItemMenu(
                              titre: 'Listes',
                              icons: CupertinoIcons.circle,
                              isActive: menuAdminBloc.menu == 40,
                              ontap: () => menuAdminBloc.setMenu(40),
                            ),
                            ItemMenu(
                              titre: 'Ajouter flash news',
                              icons: CupertinoIcons.circle,
                              isActive: menuAdminBloc.menu == 41,
                              ontap: () => menuAdminBloc.setMenu(41),
                            ),
                            ItemMenu(
                              titre: 'Post digitaux',
                              icons: CupertinoIcons.circle_fill,
                              haveIcon: false,
                              isActive: menuAdminBloc.menu == 5,
                              ontap: () => menuAdminBloc.setMenu(5),
                            ),
                            ItemMenu(
                              titre: 'Liste',
                              icons: CupertinoIcons.circle,
                              isActive: menuAdminBloc.menu == 50,
                              ontap: () => menuAdminBloc.setMenu(50),
                            ),
                            ItemMenu(
                              titre: 'Ajouter post',
                              icons: CupertinoIcons.circle,
                              isActive: menuAdminBloc.menu == 51,
                              ontap: () => menuAdminBloc.setMenu(51),
                            ),
                            SizedBox(
                              height: size.height * .02,
                            ),
                            // Séparateur avant paramètres
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: size.width * .02),
                              child: Container(
                                height: 1,
                                color: blanc.withOpacity(0.1),
                              ),
                            ),
                            SizedBox(
                              height: size.height * .02,
                            ),
                            ItemMenu(
                              titre: 'Help & Support',
                              icons: CupertinoIcons.headphones,
                              isActive: menuAdminBloc.menu == 6,
                              ontap: () => menuAdminBloc.setMenu(6),
                            ),
                            SizedBox(
                              height: size.height * .01,
                            ),
                            ItemMenu(
                              titre: 'Paramètres',
                              icons: CupertinoIcons.settings,
                              isActive: menuAdminBloc.menu == 7,
                              ontap: () => menuAdminBloc.setMenu(7),
                            ),
                            SizedBox(
                              height: size.height * .02,
                            ),
                            // Bouton déconnexion modernisé
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () => dialogRequest(
                                        context: context,
                                        title: "Voullez-vous vous déconectez ?")
                                    .then((value) {
                                  if (value) {
                                    SharedPreferences.getInstance().then((prefs) {
                                      prefs.clear();
                                      context.go("/");
                                    });
                                  }
                                }),
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: size.width * .015,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width * .015,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        rouge.withOpacity(0.2),
                                        rouge.withOpacity(0.1),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: rouge.withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.logout_rounded,
                                        size: 16,
                                        color: rouge,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Déconnexion',
                                        style: fontFammilyDii(
                                          context,
                                          14,
                                          blanc,
                                          FontWeight.w700,
                                          FontStyle.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * .02,
                            ),
                          ],
                        ),
                      )),
                      Expanded(
                          flex: 4,
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
                                                          : menuAdminBloc
                                                                      .menu ==
                                                                  30
                                                              ? const PresseEcriteScreen()
                                                              : menuAdminBloc
                                                                          .menu ==
                                                                      31
                                                                  ? const AddPresseEcriteScreen()
                                                                  : menuAdminBloc
                                                                              .menu ==
                                                                          4
                                                                      ? const FlashNewsScreen()
                                                                      : menuAdminBloc.menu ==
                                                                              40
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
                                                                                              ? const ParamsDashbord()
                                                                                              : Container()),
                    ],
                  ),
                )
              : Stack(
                  children: [
                    Positioned(
                        top: 60,
                        child: SizedBox(
                            height: size.height - 60,
                            width: size.width,
                            child: menuAdminBloc.menu == 0
                                ? const MobileOverViewAdmin()
                                : menuAdminBloc.menu == 1
                                    ? const JournalScreenMobile()
                                    : menuAdminBloc.menu == 10
                                        ? const JournalScreenMobile()
                                        : menuAdminBloc.menu == 11
                                            ? const AddArticleScreenMobile()
                                            : menuAdminBloc.menu == 2
                                                ? const TvScreenMobile()
                                                : menuAdminBloc.menu == 20
                                                    ? const TvScreenMobile()
                                                    : menuAdminBloc.menu == 21
                                                        ? const AddEmissionScreenMobile()
                                                        : menuAdminBloc.menu ==
                                                                3
                                                            ? const PresseEcriteScreenMobile()
                                                            : menuAdminBloc
                                                                        .menu ==
                                                                    30
                                                                ? const PresseEcriteScreenMobile()
                                                                : menuAdminBloc
                                                                            .menu ==
                                                                        31
                                                                    ? const AddPresseEcriteScreenMobile()
                                                                    : menuAdminBloc.menu ==
                                                                            4
                                                                        ? const FlashNewsScreenMobile()
                                                                        : menuAdminBloc.menu ==
                                                                                40
                                                                            ? const FlashNewsScreenMobile()
                                                                            : menuAdminBloc.menu == 41
                                                                                ? const AddFlashNewsScreen()
                                                                                : menuAdminBloc.menu == 5
                                                                                    ? const PostDigiteauxScreenMobile()
                                                                                    : menuAdminBloc.menu == 50
                                                                                        ? const PostDigiteauxScreenMobile()
                                                                                        : menuAdminBloc.menu == 51
                                                                                            ? const AddPostDigiteauxScreenMobile()
                                                                                            : menuAdminBloc.menu == 7
                                                                                                ? const ParamsDashbord()
                                                                                                : Container())),
                    if (homeUtilisateurBloc.showMenuMobile == 1)
                      const Positioned(
                          top: 60, child: MenuMobileAdministratreur()),
                    const Positioned(
                        top: 0,
                        child: TopBarMenu())
                  ],
                ),
        ),
      ),
    );
  }
}
  
