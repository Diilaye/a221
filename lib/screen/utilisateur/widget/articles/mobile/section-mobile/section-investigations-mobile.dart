import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/article-investigation.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SectionInvestigationMobile extends StatelessWidget {
  const SectionInvestigationMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: 45,
          color: blanc,
          child: Row(
            children: [
              paddingHorizontalGlobal(),
              Text(
                'Insvestigations'.toUpperCase(),
                style: fontFammilyDii(
                    context, 22, rouge, FontWeight.bold, FontStyle.normal),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 300,
          width: size.width,
          child: ListView(
              scrollDirection: Axis.horizontal,
              children: homeUtilisateurBloc.articleInvestigations
                  .map((e) => ArtilceInvestiogationMobile(article: e))
                  .toList()),
        ),
        paddingVerticalGlobal(),
        Container(
          height: 1,
          color: noir,
        ),
      ],
    );
  }
}
