import 'package:actu/bloc/utilisateur/papier-journal-bloc.dart';
import 'package:actu/screen/utilisateur/widget/section-article/section-edition-widget.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../bloc/utilisateur/home-bloc.dart';
import '../../../../../../utils/requette-by-dii.dart';
import '../../../../../../utils/widgets/font-fammily-dii.dart';
import '../../../../../../utils/yWebUtils.dart';

class SectionVideoMobile extends StatelessWidget {
  const SectionVideoMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return  homeUtilisateurBloc.videos.isNotEmpty ? Container(
      height: 350,
      width: MediaQuery.of(context).size.width,
      color: bleuMarine,
      child: Column(
        children: [
          paddingVerticalGlobal(),
          Row(
            children: [
              const Spacer(),
              Text('Vidéo',style: fontFammilyDii(
                  context,
                  24,
                  blanc,
                  FontWeight.bold,
                  FontStyle.normal), ),
              const Spacer(),
            ],
          ),
          SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: homeUtilisateurBloc.videos.where((e) => e.statusOnline == "on" && e.isLive =="off" ).map((el) => Row(
                children: [
                  paddingHorizontalGlobal(8),
                  GestureDetector(
                    onTap: () => showDialog(
                        context: context,
                        builder: (c) {
                          return AlertDialog(
                            backgroundColor: noir,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(0.0))),
                            contentPadding: EdgeInsets.only(top: 0.0),
                            title: Text(el.titre!, style: fontFammilyDii(context, 24, blanc, FontWeight.w400, FontStyle.normal),),
                            content:YoutubeHtmlWidget(urlY: el.url!,),
                          );
                        }
                    ),
                    child: Container(
                      width: 325,
                      height: 294,
                      child: Stack(
                        children: [
                          (el.imageFile?.url != null && el.imageFile!.url!.isNotEmpty)
                            ? Image.network(BASE_URL_ASSET+el.imageFile!.url! , height: 190,width: 325, fit: BoxFit.fill,)
                            : Image.network('https://cdn.vectorstock.com/i/500p/81/79/no-photo-icon-default-placeholder-vector-41468179.jpg', height: 190, width: 325, fit: BoxFit.fill,),
                          Positioned(
                              top: 85,
                              left: 140,
                              child: Icon(Icons.play_circle_fill_outlined , color: blanc, size: 45,)),
                          Positioned(
                              top: 190,
                              child: SizedBox(
                                width: 325,
                                height: 89,
                                child: Column(
                                  children: [
                                    paddingVerticalGlobal(8),
                                    Row(
                                      children: [
                                        SizedBox(
                                            width: 325,
                                            child: Text(el.emission!  , style: fontFammilyDii(context, 16, rouge, FontWeight.w600, FontStyle.normal),)),
                                      ],
                                    ),
                                    paddingVerticalGlobal(4),
                                    Row(
                                      children: [
                                        SizedBox(
                                            width: 325,
                                            child: Text(el.titre!, style: fontFammilyDii(context, 14, blanc, FontWeight.w400, FontStyle.normal),)),
                                      ],
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              )).toList(),
            ),
          ),
          paddingVerticalGlobal(4),

        ],
      ),
    ): const SizedBox();
  }
}
