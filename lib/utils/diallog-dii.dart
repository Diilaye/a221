import 'package:flutter/material.dart';

Future<bool> dialogRequest(
    {required BuildContext context, required String title}) async {
  bool exitApp = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            content: Text(title),
            title: const Text('Actu221'),
            actions: [
              TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('Non')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text('Oui')),
            ],
          ));

  return exitApp;
}

Future<bool> dialogRequestInfo(
    {required BuildContext context,
    required String text1,
    required String text2,
    required String text3}) async {
  bool exitApp = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            content: SizedBox(
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const ImageIcon(
                          AssetImage("assets/images/preparion.png")),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          child: Text(
                        text1,
                        overflow: TextOverflow.ellipsis,
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const ImageIcon(
                          AssetImage("assets/images/livraison.png")),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          child: Text(
                        text2,
                        overflow: TextOverflow.ellipsis,
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const ImageIcon(AssetImage("assets/images/livree.png")),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          child: Text(
                        text3,
                        overflow: TextOverflow.ellipsis,
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            title: const Text('Swaped'),
            actions: [
              // TextButton(
              //     onPressed: () async {
              //       Navigator.of(context).pop(false);
              //     },
              //     child: Text('Non')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text('Fermer')),
            ],
          ));

  return exitApp;
}
