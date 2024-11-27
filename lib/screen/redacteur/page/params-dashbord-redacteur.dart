import 'package:actu/bloc/administrateur/menu-admin.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/params/categories/categories-screen.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/params/mots-cles/key-word-screen.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/params/profile-sccren.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/params/sous-categorie/sous-categorie-screen.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/params/tags/tags-screen.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/params/users/users-screen.dart';
import 'package:actu/screen/adminnistrateur/widgets/menu/item-menu.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ParamsDashbordRedacteur extends StatelessWidget {
  const ParamsDashbordRedacteur({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final menuAdminBloc = Provider.of<MenuAdminBloc>(context);

    return Row(
      children: [
        paddingHorizontalGlobal(0),
        Expanded(
            child: Container(
          decoration: BoxDecoration(color: blanc, boxShadow: [
            BoxShadow(
                offset: const Offset(0, 0),
                blurRadius: 1,
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
                    'Parametres'.toUpperCase(),
                    style: fontFammilyDii(
                        context, 20, rouge, FontWeight.bold, FontStyle.normal),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * .02,
              ),
              ItemMenu(
                titre: 'Tags',
                icons: CupertinoIcons.circle_fill,
                haveIcon: false,
                isActive: menuAdminBloc.sousMenu == 2,
                ontap: () => menuAdminBloc.setSousMenu(2),
              ),
              SizedBox(
                height: size.height * .02,
              ),
              ItemMenu(
                titre: 'Utilisateur',
                icons: CupertinoIcons.circle_fill,
                haveIcon: false,
                isActive: menuAdminBloc.sousMenu == 4,
                ontap: () => menuAdminBloc.setSousMenu(4),
              ),
              SizedBox(
                height: size.height * .02,
              ),
              ItemMenu(
                titre: 'Mot de passe',
                icons: CupertinoIcons.circle_fill,
                haveIcon: false,
                isActive: menuAdminBloc.sousMenu == 5,
                ontap: () => menuAdminBloc.setSousMenu(5),
              ),
            ],
          ),
        )),
        Expanded(
            flex: 4,
            child: menuAdminBloc.sousMenu == 2
                ? const TagScreen()
                : menuAdminBloc.sousMenu == 4
                    ? const UserScreen()
                    : menuAdminBloc.sousMenu == 5
                        ? const ProfileUserScreen()
                        : const SizedBox()),
      ],
    );
  }
}
