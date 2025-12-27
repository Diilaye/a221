import 'package:actu/screen/utilisateur/widget/videos/video-card-animated.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../bloc/utilisateur/home-bloc.dart';
import '../../../../../../utils/widgets/font-fammily-dii.dart';

class SectionVideoMobile extends StatelessWidget {
  const SectionVideoMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return  homeUtilisateurBloc.videos.isNotEmpty ? Container(
      height: 400,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            bleuMarine,
            bleuMarine.withOpacity(0.95),
            Color(0xFF0A1929),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: noir.withOpacity(0.3),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          paddingVerticalGlobal(12),
          Row(
            children: [
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: rouge.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: rouge.withOpacity(0.5), width: 1),
                ),
                child: Row(
                  children: [
                    Icon(CupertinoIcons.play_circle_fill, color: rouge, size: 18,),
                    SizedBox(width: 8),
                    Text('VIDÉOS',style: fontFammilyDii(
                        context,
                        22,
                        blanc,
                        FontWeight.w900,
                        FontStyle.normal), ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
          paddingVerticalGlobal(8),
          SizedBox(
            height: 340,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: homeUtilisateurBloc.videos.where((e) => e.statusOnline == "on" && e.isLive =="off" ).map((el) => Row(
                children: [
                  paddingHorizontalGlobal(8),
                  VideoCardAnimated(video: el),
                ],
              )).toList(),
            ),
          ),
          paddingVerticalGlobal(8),

        ],
      ),
    ): const SizedBox();
  }
}
