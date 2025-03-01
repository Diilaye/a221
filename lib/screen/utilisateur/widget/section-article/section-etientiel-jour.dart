import 'package:actu/models/administrateur/post-digiteaux-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';

class SectionEtientielJourWidget extends StatelessWidget {
  final List<PostsDigiteauxModel> posts;
  const SectionEtientielJourWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        width: 1024,
        decoration: BoxDecoration(
          color: bleuMarine,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0),
          child: Container(
            decoration: BoxDecoration(color: bleuMarine, boxShadow: [
              BoxShadow(blurRadius: 0, color: rouge.withOpacity(.7))
            ]),
            child: Column(
              children: [
                paddingVerticalGlobal(32),
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
                paddingVerticalGlobal(32),
                SizedBox(
                  height: 300,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: posts.map((e) => Row(children: [
                      paddingHorizontalGlobal(8),
                      Image.network(
                        BASE_URL_ASSET + e.image!.url!,
                        fit: BoxFit.contain,
                      ),
                      paddingHorizontalGlobal(8),
                    ],)).toList()
                  ),
                ),
                paddingVerticalGlobal(32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
