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
      height: 450,
      width: MediaQuery.of(context).size.width,
      color: bleuMarine,
      child: Column(
        children: [
          paddingVerticalGlobal(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "L'essentiel".toUpperCase(),
                style: fontFammilyDii(
                    context, 24, blanc, FontWeight.bold, FontStyle.normal),
              )
            ],
          ),
          paddingVerticalGlobal(),
          SizedBox(
              height: 350,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: posts.map((e) => Row(children: [
                  paddingHorizontalGlobal(8),
                  Image.network(
                    BASE_URL_ASSET + e.image!.url!,
                    fit: BoxFit.contain,
                    height: 350,
                    width: MediaQuery.of(context).size.width *.9 ,
                  ),
                ],)).toList(),
              )),
          paddingVerticalGlobal(32),
        ],
      ),
    );
  }
}
