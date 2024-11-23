import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/articles/add-screen.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/flash-news/add-flash-news.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/flash-news/flash-new.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/params/params-dashbord.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/posts-digiteaux/add-post-digiteaux.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/posts-digiteaux/posts-digiteaux.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/presse-ecrite/add-presse-ecrite.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/presse-ecrite/presse-ecrite.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/tv/add-emission.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/tv/tv-screen.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/articles/journal-screen.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/overview-admin.dart';
import 'package:actu/screen/adminnistrateur/widgets/menu/item-menu.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/diallog-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:actu/bloc/administrateur/menu-admin.dart';

class JournalisteScreen extends StatelessWidget {
  const JournalisteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final menuAdminBloc = Provider.of<MenuAdminBloc>(context);

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: .0,
          elevation: .0,
        ),
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Row(
            children: [
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
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => context.go('/'),
                        child: Row(
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
                      ontap: () => menuAdminBloc.setMenu(11),
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
                    SizedBox(
                      height: size.height * .5,
                    ),
                    ItemMenu(
                      titre: 'Paramètres',
                      icons: CupertinoIcons.settings,
                      isActive: menuAdminBloc.menu == 7,
                      sizeIcon: 16,
                      ontap: () => null,
                    ),
                    SizedBox(
                      height: 16,
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
                                style: TextStyle(fontSize: 14, color: noir),
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
                                                                                      ? const ParamsDashbord()
                                                                                      : Container()),
            ],
          ),
        ));
  }
}
