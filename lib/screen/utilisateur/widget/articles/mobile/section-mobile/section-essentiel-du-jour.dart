import 'package:actu/models/administrateur/post-digiteaux-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';

class SectionEssentielDuJour extends StatelessWidget {
  final List<PostsDigiteauxModel> posts;
  const SectionEssentielDuJour({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 400,
      color: bleuMarine,
      child: Column(
        children: [
          paddingVerticalGlobal(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "En ce moment …".toUpperCase(),
                style: fontFammilyDii(
                    context, 24, blanc, FontWeight.bold, FontStyle.normal),
              )
            ],
          ),
          paddingVerticalGlobal(),
          SizedBox(
              height: 350,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: posts.map((e) => Row(children: [
                  paddingHorizontalGlobal(8),
                  Image.network(
                    BASE_URL_ASSET + e.image!.url!,
                    fit: BoxFit.contain,

                  ),
                ],)).toList(),
              )),
          paddingVerticalGlobal(32),
        ],
      ),
    );
  }
}
