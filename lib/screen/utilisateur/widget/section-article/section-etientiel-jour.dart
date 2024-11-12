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
    return Container(
      width: size.width,
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
                height: 350,
                child: Row(
                  children: [
                    paddingHorizontalGlobal(size.width * .1),
                    Expanded(
                        child: Image.network(
                      BASE_URL_ASSET + posts[0].image!.url!,
                      fit: BoxFit.contain,
                    )),
                    paddingHorizontalGlobal(8),
                    Expanded(
                        child: Image.network(
                      BASE_URL_ASSET + posts[1].image!.url!,
                      fit: BoxFit.contain,
                    )),
                    paddingHorizontalGlobal(8),
                    Expanded(
                        child: Image.network(
                      BASE_URL_ASSET + posts[2].image!.url!,
                      fit: BoxFit.contain,
                    )),
                    paddingHorizontalGlobal(size.width * .1),
                  ],
                ),
              ),
              paddingVerticalGlobal(32),
            ],
          ),
        ),
      ),
    );
  }
}
