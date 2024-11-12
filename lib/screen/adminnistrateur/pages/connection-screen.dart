import 'package:actu/bloc/administrateur/auth.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ConnectionScreen extends StatelessWidget {
  const ConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final connectionBloc = Provider.of<ConnexionBloc>(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: .0,
        elevation: .0,
      ),
      body: Container(
        height: size.height,
        width: size.width,
        color: bgAdmin,
        child: ListView(
          children: [
            Container(
              height: 60,
              width: size.width,
              color: blanc,
              child: Row(
                children: [
                  paddingHorizontalGlobal(size.width * .1),
                  SizedBox(
                    width: 200,
                    child: Image.asset(
                      "assets/images/logo_a221.png",
                      color: rouge,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Spacer(),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => context.go("/"),
                      child: Container(
                        height: 40,
                        color: noir.withOpacity(.6),
                        child: Row(
                          children: [
                            paddingHorizontalGlobal(4),
                            Text(
                              "Retour au site",
                              style: fontFammilyDii(context, 12, blanc,
                                  FontWeight.bold, FontStyle.normal),
                            ),
                            paddingHorizontalGlobal(4),
                          ],
                        ),
                      ),
                    ),
                  ),
                  paddingHorizontalGlobal(size.width * .1),
                ],
              ),
            ),
            paddingVerticalGlobal(60),
            Center(
              child: Container(
                height: 630,
                width: 300,
                decoration: BoxDecoration(
                    color: blanc,
                    border: Border(
                        top: BorderSide(color: noir.withOpacity(.5), width: 2)),
                    boxShadow: [
                      BoxShadow(color: noir.withOpacity(.3), blurRadius: 10)
                    ]),
                child: Column(
                  children: [
                    paddingVerticalGlobal(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Connectez-vous',
                          style: fontFammilyDii(context, 16, rouge,
                              FontWeight.bold, FontStyle.normal),
                        )
                      ],
                    ),
                    paddingVerticalGlobal(15),
                    Container(
                      height: 1,
                      color: noir.withOpacity(.2),
                    ),
                    paddingVerticalGlobal(24),
                    Row(
                      children: [
                        paddingHorizontalGlobal(8),
                        Text(
                          'Email',
                          style: fontFammilyDii(context, 14, noir,
                              FontWeight.bold, FontStyle.normal),
                        ),
                        paddingHorizontalGlobal(8),
                      ],
                    ),
                    paddingVerticalGlobal(4),
                    Center(
                      child: SizedBox(
                        height: 45,
                        width: size.width,
                        child: Row(
                          children: [
                            paddingHorizontalGlobal(8),
                            Expanded(
                              child: TextField(
                                controller: connectionBloc.email,
                                decoration: const InputDecoration(
                                  hintText: "Email",
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            paddingHorizontalGlobal(8),
                          ],
                        ),
                      ),
                    ),
                    paddingVerticalGlobal(24),
                    Row(
                      children: [
                        paddingHorizontalGlobal(8),
                        Text(
                          'Mot de passe',
                          style: fontFammilyDii(context, 14, noir,
                              FontWeight.bold, FontStyle.normal),
                        ),
                        paddingHorizontalGlobal(8),
                      ],
                    ),
                    paddingVerticalGlobal(4),
                    Center(
                      child: SizedBox(
                        height: 45,
                        width: size.width,
                        child: Row(
                          children: [
                            paddingHorizontalGlobal(8),
                            Expanded(
                              child: TextField(
                                obscureText: connectionBloc.showPassword,
                                controller: connectionBloc.password,
                                decoration: const InputDecoration(
                                  hintText: "Mot de passe",
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            paddingHorizontalGlobal(8),
                          ],
                        ),
                      ),
                    ),
                    paddingVerticalGlobal(24),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Row(
                        children: [
                          paddingHorizontalGlobal(0),
                          IconButton(
                              onPressed: () => connectionBloc.setShowPassword(),
                              padding: const EdgeInsets.all(0),
                              iconSize: 12,
                              icon: Icon(
                                connectionBloc.showPassword
                                    ? Icons.square_outlined
                                    : Icons.check_box,
                                color: noir,
                                size: 16,
                              )),
                          paddingHorizontalGlobal(4),
                          Text(
                            'Afficher le mot de passe',
                            style: fontFammilyDii(context, 12, noir,
                                FontWeight.w300, FontStyle.normal),
                          )
                        ],
                      ),
                    ),
                    paddingVerticalGlobal(32),
                    Row(
                      children: [
                        paddingHorizontalGlobal(8),
                        Expanded(
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () async {
                                connectionBloc.login(context);
                              },
                              child: Container(
                                height: 45,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: rouge),
                                child: Center(
                                  child: Text(
                                    "Se connecter",
                                    style: fontFammilyDii(context, 12, blanc,
                                        FontWeight.w400, FontStyle.normal),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        paddingHorizontalGlobal(8),
                      ],
                    ),
                    paddingVerticalGlobal(24),
                    Center(
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Text(
                          'Mot de passe oublier ?',
                          style: fontFammilyDii(context, 10, bleuMarine,
                              FontWeight.w400, FontStyle.normal),
                        ),
                      ),
                    ),
                    paddingVerticalGlobal(24),
                    Center(
                      child: Text(
                        "Vous n'êtes pas inscrit sur Actu211 ",
                        style: fontFammilyDii(context, 10, noir,
                            FontWeight.w800, FontStyle.normal),
                      ),
                    ),
                    paddingVerticalGlobal(8),
                    Center(
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => context.go('/register'),
                          child: Text(
                            'Inscrivez-vous ?',
                            style: fontFammilyDii(context, 10, vertSport,
                                FontWeight.bold, FontStyle.normal),
                          ),
                        ),
                      ),
                    ),
                    paddingVerticalGlobal(8),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          height: 1,
                          color: noir.withOpacity(.3),
                        )),
                        paddingHorizontalGlobal(0),
                        Text(
                          'OU',
                          style: fontFammilyDii(context, 16, bleuMarine,
                              FontWeight.w400, FontStyle.normal),
                        ),
                        paddingHorizontalGlobal(0),
                        Expanded(
                            child: Container(
                          height: 1,
                          color: noir.withOpacity(.3),
                        )),
                      ],
                    ),
                    paddingVerticalGlobal(),
                    Row(
                      children: [
                        paddingHorizontalGlobal(8),
                        Expanded(
                            child: Container(
                          height: 40,
                          decoration: BoxDecoration(color: blanc, boxShadow: [
                            BoxShadow(
                                blurRadius: .5,
                                color: bleuMarine.withOpacity(.5))
                          ]),
                          child: Row(
                            children: [
                              paddingHorizontalGlobal(),
                              CachedNetworkImage(
                                height: 24,
                                width: 24,
                                imageUrl: "assets/images/google.png",
                              ),
                              paddingHorizontalGlobal(8),
                              Text(
                                "S'inscrire avec Google",
                                style: fontFammilyDii(
                                    context,
                                    10,
                                    noir.withOpacity(.4),
                                    FontWeight.w600,
                                    FontStyle.normal),
                              )
                            ],
                          ),
                        )),
                        paddingHorizontalGlobal(8),
                      ],
                    ),
                    paddingVerticalGlobal(),
                    Row(
                      children: [
                        paddingHorizontalGlobal(8),
                        Expanded(
                            child: Container(
                          height: 40,
                          decoration: BoxDecoration(color: blanc, boxShadow: [
                            BoxShadow(
                                blurRadius: .5,
                                color: bleuMarine.withOpacity(.5))
                          ]),
                          child: Row(
                            children: [
                              paddingHorizontalGlobal(),
                              CachedNetworkImage(
                                height: 24,
                                width: 24,
                                imageUrl: "assets/images/apple.png",
                              ),
                              paddingHorizontalGlobal(8),
                              Text(
                                "S'inscrire avec Apple",
                                style: fontFammilyDii(
                                    context,
                                    10,
                                    noir.withOpacity(.4),
                                    FontWeight.w600,
                                    FontStyle.normal),
                              )
                            ],
                          ),
                        )),
                        paddingHorizontalGlobal(8),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
