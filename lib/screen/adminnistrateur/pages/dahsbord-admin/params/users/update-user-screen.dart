import 'package:actu/bloc/administrateur/menu-admin.dart';
import 'package:actu/bloc/administrateur/user-bloc.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModifierUserScreen extends StatefulWidget {
  const ModifierUserScreen({super.key});

  @override
  State<ModifierUserScreen> createState() => _ModifierUserScreenState();
}

class _ModifierUserScreenState extends State<ModifierUserScreen> {
  @override
  Widget build(BuildContext context) {
    final userBloc = Provider.of<UserBloc>(context);

    final menuAdminBloc = Provider.of<MenuAdminBloc>(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: ListView(
        children: [
          paddingVerticalGlobal(),
          Row(
            children: [
              paddingHorizontalGlobal(8),
              Text(
                'Modifier utilisateur '.toUpperCase(),
                style: fontFammilyDii(
                    context, 18, rouge, FontWeight.bold, FontStyle.normal),
              )
            ],
          ),
          paddingVerticalGlobal(),
          Row(
            children: [
              paddingHorizontalGlobal(8),
              Text(
                'nom'.toUpperCase(),
                style: fontFammilyDii(context, 14, noir.withOpacity(.5),
                    FontWeight.w300, FontStyle.normal),
              )
            ],
          ),
          paddingVerticalGlobal(8),
          Row(
            children: [
              paddingHorizontalGlobal(8),
              Expanded(
                child: TextField(
                  controller: userBloc.nom,
                  decoration: InputDecoration(
                    hintText: "Ajouter nom".toUpperCase(),
                    border: const OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(),
                  ),
                ),
              ),
              paddingHorizontalGlobal(8),
            ],
          ),
          paddingVerticalGlobal(),
          Row(
            children: [
              paddingHorizontalGlobal(8),
              Text(
                'PRÉnom'.toUpperCase(),
                style: fontFammilyDii(context, 14, noir.withOpacity(.5),
                    FontWeight.w300, FontStyle.normal),
              )
            ],
          ),
          paddingVerticalGlobal(8),
          Row(
            children: [
              paddingHorizontalGlobal(8),
              Expanded(
                child: TextField(
                  controller: userBloc.prenom,
                  decoration: InputDecoration(
                    hintText: "Ajouter prénom".toUpperCase(),
                    border: const OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(),
                  ),
                ),
              ),
              paddingHorizontalGlobal(8),
            ],
          ),
          paddingVerticalGlobal(),
          Row(
            children: [
              paddingHorizontalGlobal(8),
              Text(
                'Téléphone'.toUpperCase(),
                style: fontFammilyDii(context, 14, noir.withOpacity(.5),
                    FontWeight.w300, FontStyle.normal),
              )
            ],
          ),
          paddingVerticalGlobal(8),
          Row(
            children: [
              paddingHorizontalGlobal(8),
              Expanded(
                child: TextField(
                  controller: userBloc.telephone,
                  decoration: InputDecoration(
                    hintText: "Ajouter téléphone".toUpperCase(),
                    border: const OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(),
                  ),
                ),
              ),
              paddingHorizontalGlobal(8),
            ],
          ),
          paddingVerticalGlobal(),
          Row(
            children: [
              paddingHorizontalGlobal(8),
              Text(
                'email'.toUpperCase(),
                style: fontFammilyDii(context, 14, noir.withOpacity(.5),
                    FontWeight.w300, FontStyle.normal),
              )
            ],
          ),
          paddingVerticalGlobal(8),
          Row(
            children: [
              paddingHorizontalGlobal(8),
              Expanded(
                child: TextField(
                  controller: userBloc.email,
                  decoration: InputDecoration(
                    hintText: "Ajouter email".toUpperCase(),
                    border: const OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(),
                  ),
                ),
              ),
              paddingHorizontalGlobal(8),
            ],
          ),
          paddingVerticalGlobal(),
          Row(
            children: [
              paddingHorizontalGlobal(8),
              Text(
                'profile'.toUpperCase(),
                style: fontFammilyDii(context, 14, noir.withOpacity(.5),
                    FontWeight.w300, FontStyle.normal),
              )
            ],
          ),
          Row(
            children: [
              paddingHorizontalGlobal(8),
              Expanded(
                  child: DropdownButton(
                      value: userBloc.role,
                      iconSize: .0,
                      icon: const SizedBox(),
                      items: [
                        "",
                        "journaliste",
                        "redacteur",
                        "aministrateur",
                        "comptable",
                        "infographie",
                        "stagiare",
                        "client"
                      ]
                          .map((e) => DropdownMenuItem(
                              value: e,
                              child: e == ''
                                  ? Text("Remplir le role de l'utilisateur"
                                      .toUpperCase())
                                  : Text(e.toUpperCase())))
                          .toList(),
                      onChanged: (value) {
                        userBloc.setRole(value!);
                      })),
            ],
          ),
          paddingVerticalGlobal(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Card(
                elevation: 2,
                color: bleuMarine,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
                child: GestureDetector(
                  onTap: () => userBloc.updateUser(),
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        paddingHorizontalGlobal(6),
                        userBloc.chargement
                            ? CircularProgressIndicator(
                                backgroundColor: blanc,
                                color: bleuMarine,
                              )
                            : Text(
                                "Modifier Utilisateur",
                                style: fontFammilyDii(context, 14, blanc,
                                    FontWeight.bold, FontStyle.normal),
                              ),
                        paddingHorizontalGlobal(6),
                      ],
                    ),
                  ),
                ),
              ),
              paddingHorizontalGlobal(),
              GestureDetector(
                onTap: () => menuAdminBloc.setAddUser(0),
                child: Card(
                  elevation: 2,
                  color: blanc,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        paddingHorizontalGlobal(6),
                        Text(
                          "Annuler ",
                          style: fontFammilyDii(context, 14, noir,
                              FontWeight.bold, FontStyle.normal),
                        ),
                        paddingHorizontalGlobal(6),
                      ],
                    ),
                  ),
                ),
              ),
              paddingHorizontalGlobal()
            ],
          ),
          paddingVerticalGlobal(),
        ],
      ),
    );
  }
}
