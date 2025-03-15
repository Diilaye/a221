/*import 'package:actu/screen/utilisateur/widget/videos/video-webview-dii.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideoWidgetDii extends StatefulWidget {
  final String url ;

  const VideoWidgetDii({super.key, required this.url});
  @override
  _VideoWidgetDiiState createState() => _VideoWidgetDiiState();
}

class _VideoWidgetDiiState extends State<VideoWidgetDii> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 320,
        height: 270,
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: GestureDetector(
                onTap: () => showDialog(
                    barrierDismissible: false,
                    builder: (context) => AlertDialog(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      title: Text("ROMAN FRAYSSINET - Ô DEDANS - SPECTACLE COMPLET" , style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: noir
                      ),),
                      actions: [
                        TextButton(
                            onPressed: () async {
                              Navigator.of(context).pop(false);
                            },
                            child: Text('Fermer')),

                      ],
                      content:  Center(
                        child: Container(
                            width: 1024,
                            height: 750,
                            decoration: BoxDecoration(
                              color: Colors.black,
                            ),
                            child:  YoutubeWebView()
                        ),
                      ),
                    ),
                    context: context
                ),
                child: Stack(
                  children: [
                    SizedBox(
                      height: 200,
                      width:  320 ,
                      child: Image.network(BASE_URL_ASSET+ widget.url , fit: BoxFit.fill,),
                    ),
                    Positioned(
                        top : 75,
                        left: 135,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: blanc.withOpacity(1),
                            borderRadius: BorderRadius.circular(50)
                          ),
                          child: Center(
                            child: Icon(CupertinoIcons.play , color: noir, size: 12,),
                          ),
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 70,
              width:  320 ,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Emission" , style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: blanc
                      ),),
                    ],
                  ),
                  Text("ROMAN FRAYSSINET - Ô DEDANS - SPECTACLE COMPLET" , style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: blanc
                  ),)
                ],
              ),
            )
          ],
        ));
  }
}


 */