import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExitMenuRubrique extends StatelessWidget {
  const ExitMenuRubrique({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    return Positioned(
        top: 1000,
        child: GestureDetector(
          onTap: () => homeUtilisateurBloc.setHoverMenuClick(0, null),
          child: Container(
            height: 500,
            width: size.width,
            color: rouge,
          ),
        ));
  }
}
