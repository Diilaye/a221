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
import 'package:actu/screen/utilisateur/widget/menu/menu-mobile.dart';
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

    final postsDigiteauxUserBloc = Provider.of<PostsDigiteauxUserBloc>(context);

    return Scaffold(
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
                      // ignore: unrelated_type_equality_checks
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(color: blanc, boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 0),
                              blurRadius: 10,
                              color: noir.withOpacity(.2))
                        ]),
                        child: ListView(
                          children: [
                            SizedBox(
                              height: size.height * .02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: size.width * .025,
                                ),
                                Text(
                                  'Dashbord',
                                  style: fontFammilyDii(context, 14, rouge,
                                      FontWeight.bold, FontStyle.normal),
                                ),
                                Text(
                                  'Actu221',
                                  style: fontFammilyDii(context, 14, noir,
                                      FontWeight.bold, FontStyle.normal),
                                ),
                              ],
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
                              ontap: () => menuAdminBloc.setMenu(11),
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
                              height: size.height * .01,
                            ),
                            GestureDetector(
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
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: size.width * .03,
                                      ),
                                      const Icon(
                                        Icons.logout_rounded,
                                        size: 13,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        'Déconnection',
                                        style: TextStyle(
                                            fontSize: 14, color: noir),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                ],
                              ),
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
                    const Positioned(child: TopBarMenu())
                  ],
                ),
        ));
  }
}
