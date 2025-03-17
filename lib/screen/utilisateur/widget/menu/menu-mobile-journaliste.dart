import 'package:actu/bloc/administrateur/menu-admin.dart';
import 'package:actu/bloc/utilisateur/emission-user-bloc.dart';
import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/bloc/utilisateur/papier-journal-bloc.dart';
import 'package:actu/screen/adminnistrateur/widgets/menu/item-menu.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/footer-mobile.dart';
import 'package:actu/screen/utilisateur/widget/emissions/article-top-bar.dart';
import 'package:actu/screen/utilisateur/widget/emissions/emission-top-bar.dart';
import 'package:actu/screen/utilisateur/widget/menu/menu-mobile-item.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/diallog-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuMobileJournaliste extends StatelessWidget {
  const MenuMobileJournaliste({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    final menuAdminBloc = Provider.of<MenuAdminBloc>(context);

    return Container(
      height: size.height - 60,
      width: size.width,
      color: blanc,
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
                style: fontFammilyDii(
                    context, 14, rouge, FontWeight.bold, FontStyle.normal),
              ),
              Text(
                'Actu221',
                style: fontFammilyDii(
                    context, 14, noir, FontWeight.bold, FontStyle.normal),
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
         /* ItemMenu(
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

          */
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
        /*  ItemMenu(
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

         */
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
                    context: context, title: "Voullez-vous vous déconectez ?")
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
          paddingVerticalGlobal(4),
        ],
      ),
    );
  }
}
