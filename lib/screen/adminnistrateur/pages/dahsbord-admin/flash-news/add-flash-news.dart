import 'package:actu/bloc/administrateur/flash-news-bloc.dart';
import 'package:actu/bloc/administrateur/menu-admin.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddFlashNewsScreen extends StatefulWidget {
  const AddFlashNewsScreen({super.key});

  @override
  State<AddFlashNewsScreen> createState() => _AddFlashNewsScreenState();
}

class _AddFlashNewsScreenState extends State<AddFlashNewsScreen> {
  @override
  Widget build(BuildContext context) {
    final flashNewsBloc = Provider.of<FlashNewsBloc>(context);
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
                'Ajouter Flash news'.toUpperCase(),
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
                'titre flash news'.toUpperCase(),
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
                  controller: flashNewsBloc.desc,
                  decoration: InputDecoration(
                    hintText: "Ajouter titre  flash news".toUpperCase(),
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
                'Type flash news'.toUpperCase(),
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
                  controller: flashNewsBloc.type,
                  decoration: InputDecoration(
                    hintText: "Type flash news".toUpperCase(),
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
                  onTap: () => flashNewsBloc.add(),
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        paddingHorizontalGlobal(6),
                        flashNewsBloc.chargement
                            ? CircularProgressIndicator(
                                backgroundColor: blanc,
                                color: bleuMarine,
                              )
                            : Text(
                                "Ajouter flash news",
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
                onTap: () => menuAdminBloc.setFlashNews(0),
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
