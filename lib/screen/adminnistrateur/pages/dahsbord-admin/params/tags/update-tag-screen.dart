import 'package:actu/bloc/administrateur/tags-bloc.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateTagScreen extends StatefulWidget {
  const UpdateTagScreen({super.key});

  @override
  State<UpdateTagScreen> createState() => _UpdateTagScreenState();
}

class _UpdateTagScreenState extends State<UpdateTagScreen> {
  @override
  Widget build(BuildContext context) {
    final tagsBloc = Provider.of<TagsBloc>(context);

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
                'modifier un tag '.toUpperCase(),
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
                'titre tag'.toUpperCase(),
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
                  controller: tagsBloc.titre,
                  decoration: InputDecoration(
                    hintText: "Ajouter tags".toUpperCase(),
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
                  onTap: () => tagsBloc.updateTags(context),
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        paddingHorizontalGlobal(6),
                        tagsBloc.chargement
                            ? CircularProgressIndicator(
                                backgroundColor: blanc,
                                color: bleuMarine,
                              )
                            : Text(
                                "modifer un tag",
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
                onTap: () => tagsBloc.setShowUpdate(0),
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
