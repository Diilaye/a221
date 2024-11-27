import 'package:actu/bloc/administrateur/categorie-bloc.dart';
import 'package:actu/bloc/administrateur/menu-admin.dart';
import 'package:actu/bloc/administrateur/user-bloc.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/params/users/add-user-screen.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/params/users/update-user-screen.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/diallog-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final menuAdminBloc = Provider.of<MenuAdminBloc>(context);
    final userBloc = Provider.of<UserBloc>(context);

    return Stack(
      children: [
        ListView(
          children: [
            paddingVerticalGlobal(),
            Row(
              children: [
                paddingHorizontalGlobal(),
                Text(
                  'Utilisateurs'.toUpperCase(),
                  style: fontFammilyDii(
                      context, 20, noir, FontWeight.bold, FontStyle.normal),
                )
              ],
            ),
            paddingVerticalGlobal(size.height * .02),
            Row(
              children: [
                paddingHorizontalGlobal(),
                Icon(
                  CupertinoIcons.home,
                  color: noir.withOpacity(.6),
                  size: 14,
                ),
                paddingHorizontalGlobal(6),
                Icon(
                  CupertinoIcons.chevron_forward,
                  color: noir.withOpacity(.6),
                  size: 12,
                ),
                paddingHorizontalGlobal(6),
                Text(
                  'Utilisateur',
                  style: fontFammilyDii(context, 14, noir.withOpacity(.6),
                      FontWeight.w300, FontStyle.normal),
                ),
                paddingHorizontalGlobal(6),
                Icon(
                  CupertinoIcons.chevron_forward,
                  color: noir.withOpacity(.6),
                  size: 12,
                ),
                paddingHorizontalGlobal(6),
                Text(
                  'Dashbord',
                  style: fontFammilyDii(
                      context, 12, noir, FontWeight.w300, FontStyle.normal),
                ),
                paddingHorizontalGlobal(),
                const Spacer(),
                Center(
                  child: SizedBox(
                    height: 45,
                    width: size.width * .3,
                    child: Row(
                      children: [
                        paddingHorizontalGlobal(8),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText:
                                  "RECHERCHER UN utilisateur".toUpperCase(),
                              border: const OutlineInputBorder(),
                              enabledBorder: const OutlineInputBorder(),
                            ),
                            onChanged: (value) => userBloc.setRecherche(value),
                          ),
                        ),
                        paddingHorizontalGlobal(8),
                      ],
                    ),
                  ),
                ),
                paddingHorizontalGlobal(),
                GestureDetector(
                  onTap: () => menuAdminBloc.setAddUser(1),
                  child: CircleAvatar(
                      backgroundColor: bleuMarine,
                      child: Icon(
                        CupertinoIcons.add,
                        color: blanc,
                      )),
                ),
                paddingHorizontalGlobal(),
              ],
            ),
            paddingVerticalGlobal(),
            SizedBox(
              height: 700,
              width: size.width,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    paddingVerticalGlobal(8),
                    Row(
                      children: [
                        paddingHorizontalGlobal(8),
                        Expanded(
                            child: Row(
                          children: [
                            Row(
                              children: [
                                Center(
                                    child: Text(
                                  'Nom complet',
                                  style: fontFammilyDii(context, 14, noir,
                                      FontWeight.w500, FontStyle.normal),
                                )),
                              ],
                            ),
                          ],
                        )),
                        Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Text(
                                  'email',
                                  style: fontFammilyDii(context, 14, noir,
                                      FontWeight.w500, FontStyle.normal),
                                ),
                              ],
                            )),
                        Expanded(
                            child: Row(
                          children: [
                            Text(
                              'Role',
                              style: fontFammilyDii(context, 14, noir,
                                  FontWeight.w500, FontStyle.normal),
                            ),
                          ],
                        )),
                        Expanded(
                            child: Row(
                          children: [
                            Text(
                              'Status',
                              style: fontFammilyDii(context, 14, noir,
                                  FontWeight.w500, FontStyle.normal),
                            ),
                          ],
                        )),
                        Expanded(
                            child: Row(
                          children: [
                            Text(
                              '...',
                              style: fontFammilyDii(context, 14, noir,
                                  FontWeight.w500, FontStyle.normal),
                            ),
                          ],
                        )),
                        paddingHorizontalGlobal(8),
                      ],
                    ),
                    paddingVerticalGlobal(8),
                    Expanded(
                        child: Row(
                      children: [
                        paddingHorizontalGlobal(8),
                        Expanded(
                          child: ListView(
                            children: userBloc.users
                                .where((e) => e.nom!.toLowerCase().contains(
                                    userBloc.rechercheT.toLowerCase()))
                                .map((e) => Container(
                                      height: 50,
                                      color: blanc,
                                      child: Row(
                                        children: [
                                          paddingHorizontalGlobal(8),
                                          Expanded(
                                              child: Row(
                                            children: [
                                              Text(
                                                '${e.prenom!} ${e.nom!}',
                                                style: fontFammilyDii(
                                                    context,
                                                    12,
                                                    noir,
                                                    FontWeight.w500,
                                                    FontStyle.normal),
                                              ),
                                            ],
                                          )),
                                          Expanded(
                                              flex: 1,
                                              child: Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Center(
                                                          child: Text(
                                                        e.email!,
                                                        style: fontFammilyDii(
                                                            context,
                                                            12,
                                                            noir,
                                                            FontWeight.w500,
                                                            FontStyle.normal),
                                                      )),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          Expanded(
                                              flex: 1,
                                              child: Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Center(
                                                          child: Text(
                                                        e.service!
                                                            .toUpperCase(),
                                                        style: fontFammilyDii(
                                                            context,
                                                            12,
                                                            noir,
                                                            FontWeight.w500,
                                                            FontStyle.normal),
                                                      )),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          Expanded(
                                              child: Row(
                                            children: [
                                              Icon(
                                                CupertinoIcons.circle_fill,
                                                size: 10,
                                                color: e.statusOnline! == "on"
                                                    ? vertSport
                                                    : rouge,
                                              ),
                                              paddingHorizontalGlobal(4),
                                              Text(
                                                e.statusOnline! == "on"
                                                    ? "En ligne"
                                                    : "Broullions",
                                                style: fontFammilyDii(
                                                    context,
                                                    14,
                                                    noir,
                                                    FontWeight.w500,
                                                    FontStyle.normal),
                                              ),
                                            ],
                                          )),
                                          Expanded(
                                              child: Row(
                                            children: [
                                              paddingHorizontalGlobal(6),
                                              IconButton(
                                                  onPressed: () {
                                                    userBloc.setShowUpate(1);
                                                    userBloc.setUser(e);
                                                  },
                                                  tooltip:
                                                      "Modifier la catégorie",
                                                  icon:
                                                      Icon(CupertinoIcons.pen)),
                                              paddingHorizontalGlobal(6),
                                              IconButton(
                                                  onPressed: () async =>
                                                      dialogRequest(
                                                              title:
                                                                  'Vous êtes sur de vouloir suprimer cette user',
                                                              context: context)
                                                          .then((value) async {
                                                        if (value) {
                                                          userBloc.setUser(e);
                                                          userBloc.activeUser();
                                                        }
                                                      }),
                                                  tooltip:
                                                      e.statusOnline! == "on"
                                                          ? "Suprimer  user"
                                                          : "Réintégrer user",
                                                  icon: Icon(e.statusOnline! ==
                                                          "on"
                                                      ? CupertinoIcons.delete
                                                      : Icons.publish)),
                                              paddingHorizontalGlobal(6),
                                              IconButton(
                                                  onPressed: () async =>
                                                      dialogRequest(
                                                              title:
                                                                  'Vous êtes sur de vouloir réinitialiser le mot de passe de ce user',
                                                              context: context)
                                                          .then((value) async {
                                                        if (value) {
                                                          userBloc.setUser(e);
                                                          userBloc
                                                              .reinitialiserPasswordUser();
                                                        }
                                                      }),
                                                  tooltip:
                                                      "Vous êtes sur de vouloir réinitialiser le mot de passe de ce user",
                                                  icon: Icon(CupertinoIcons
                                                      .return_icon)),
                                            ],
                                          )),
                                          paddingHorizontalGlobal(8),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                        paddingHorizontalGlobal(8)
                      ],
                    )),
                    paddingVerticalGlobal(8)
                  ],
                ),
              ),
            ),
            paddingVerticalGlobal(),
            Row(
              children: [
                paddingHorizontalGlobal(8),
                Text(
                  "Affichage de 1 à 10 sur ${userBloc.users.length} users",
                  style: fontFammilyDii(context, 14, noir.withOpacity(.7),
                      FontWeight.w700, FontStyle.normal),
                ),
                const Spacer(),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: SizedBox(
                      height: 30,
                      width: 50,
                      child: Center(
                          child: Icon(
                        CupertinoIcons.chevron_left,
                        size: 14,
                        color: noir,
                      ))),
                ),
                paddingHorizontalGlobal(8),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: SizedBox(
                      height: 30,
                      width: 50,
                      child: Center(
                          child: Icon(
                        CupertinoIcons.chevron_right,
                        size: 14,
                        color: noir,
                      ))),
                ),
                paddingHorizontalGlobal(),
              ],
            )
          ],
        ),
        if (menuAdminBloc.addUser == 1)
          Positioned(
              top: 0,
              right: 0,
              child: SizedBox(
                width: size.width * .64,
                height: size.height,
                child: const AddUserScreen(),
              )),
        if (userBloc.showUpdate == 1)
          Positioned(
              top: 0,
              right: 0,
              child: SizedBox(
                width: size.width * .64,
                height: size.height,
                child: const ModifierUserScreen(),
              )),
      ],
    );
  }
}
