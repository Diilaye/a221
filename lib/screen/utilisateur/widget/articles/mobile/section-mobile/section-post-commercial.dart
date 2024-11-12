import 'package:actu/models/administrateur/post-digiteaux-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';

class SectionPostCommercialDuJour extends StatelessWidget {
  final PostsDigiteauxModel post;
  const SectionPostCommercialDuJour({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          color: noir,
          child: Column(
            children: [
              Container(
                height: 45,
                width: size.width,
                color: noir,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      post.titre!.toUpperCase(),
                      style: fontFammilyDii(context, 20, blanc, FontWeight.bold,
                          FontStyle.normal),
                    )
                  ],
                ),
              ),
              Image.network(
                height: size.height * .7,
                width: size.width * .92,
                BASE_URL_ASSET + post.image!.url!,
                fit: BoxFit.contain,
              ),
              paddingVerticalGlobal(32),
            ],
          ),
        ),
      ],
    );
  }
}
