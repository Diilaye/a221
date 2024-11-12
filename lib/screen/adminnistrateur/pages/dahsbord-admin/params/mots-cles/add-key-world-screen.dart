import 'package:actu/bloc/administrateur/menu-admin.dart';
import 'package:actu/bloc/administrateur/mot-cles-bloc.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddKeyWorldScreen extends StatefulWidget {
  const AddKeyWorldScreen({super.key});

  @override
  State<AddKeyWorldScreen> createState() => _AddKeyWorldScreenState();
}

class _AddKeyWorldScreenState extends State<AddKeyWorldScreen> {
  @override
  Widget build(BuildContext context) {
    final motsClesBloc = Provider.of<MotsClesBloc>(context);
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
                'Ajouter un mot clés '.toUpperCase(),
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
                'titre mot clés'.toUpperCase(),
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
                  controller: motsClesBloc.titre,
                  decoration: InputDecoration(
                    hintText: "Ajouter un mot clés".toUpperCase(),
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Card(
                elevation: 2,
                color: bleuMarine,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
                child: GestureDetector(
                  onTap: () => motsClesBloc.addMotCles(context),
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        paddingHorizontalGlobal(6),
                        motsClesBloc.chargement
                            ? CircularProgressIndicator(
                                backgroundColor: blanc,
                                color: bleuMarine,
                              )
                            : Text(
                                "Ajouter un mot clés",
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
                onTap: () => menuAdminBloc.setKeyWord(0),
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
