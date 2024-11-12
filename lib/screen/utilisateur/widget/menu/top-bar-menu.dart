import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/responsive-ui.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TopBarMenu extends StatelessWidget {
  const TopBarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    Size size = MediaQuery.of(context).size;

    return deviceName(size) == ScreenType.Mobile
        ? Container(
            height: 60,
            width: size.width,
            decoration: BoxDecoration(
                color: blanc,
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  BoxShadow(color: noir.withOpacity(.3), blurRadius: .3)
                ]),
            child: Row(
              children: [
                paddingHorizontalGlobal(),
                GestureDetector(
                  onTap: () => homeUtilisateurBloc.setShowMenuMobile(),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4), color: gris),
                    child: Center(
                      child: homeUtilisateurBloc.showMenuMobile == 0
                          ? Icon(Icons.menu)
                          : Icon(Icons.close),
                    ),
                  ),
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onEnter: (e) => homeUtilisateurBloc.setHover(1),
                  onExit: (e) => homeUtilisateurBloc.setHover(0),
                  child: GestureDetector(
                    onTap: () {
                      context.go('/');
                    },
                    child: Container(
                      height: 60,
                      color: blanc,
                      child: Row(
                        children: [
                          paddingHorizontalGlobal(8),
                          SizedBox(
                              width: 180,
                              child: Image.asset(
                                "assets/images/logo_a221.png",
                                color: rouge,
                                fit: BoxFit.cover,
                              )),
                          paddingHorizontalGlobal(8),
                        ],
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => context.go('/login'),
                    child: Container(
                      height: 60,
                      color: blanc,
                      child: Icon(
                        CupertinoIcons.person_alt_circle,
                        size: 18,
                        color: noir,
                      ),
                    ),
                  ),
                ),
                paddingHorizontalGlobal(8),
                Container(
                  height: 20,
                  width: .5,
                  color: noir,
                ),
                paddingHorizontalGlobal(8),
                Container(
                  height: 25,
                  decoration: BoxDecoration(
                      color: jaune, borderRadius: BorderRadius.circular(4)),
                  child: Row(
                    children: [
                      paddingHorizontalGlobal(6),
                      Text(
                        "S'abonner",
                        style: fontFammilyDii(context, 10, noir.withOpacity(.7),
                            FontWeight.w700, FontStyle.normal),
                      ),
                      paddingHorizontalGlobal(6),
                    ],
                  ),
                ),
                paddingHorizontalGlobal(),
              ],
            ),
          )
        : homeUtilisateurBloc.hoverMenuClick != 0
            ? GestureDetector(
                onTap: () => homeUtilisateurBloc.setHoverMenuClick(0, null),
                child: Container(
                  height: 60,
                  width: size.width,
                  decoration: BoxDecoration(
                      color: blanc,
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: [
                        BoxShadow(color: noir.withOpacity(.3), blurRadius: .3)
                      ]),
                  child: Row(
                    children: [
                      paddingHorizontalGlobal(),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        onEnter: (e) => homeUtilisateurBloc.setHover(1),
                        onExit: (e) => homeUtilisateurBloc.setHover(0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 60,
                            color: homeUtilisateurBloc.hover == 1
                                ? noir.withOpacity(.05)
                                : blanc,
                            child: Row(
                              children: [
                                paddingHorizontalGlobal(8),
                                SizedBox(
                                    width: size.width >= 1440
                                        ? 300
                                        : size.width <= 1024 &&
                                                size.width > 1440
                                            ? 200
                                            : 150,
                                    child: Image.asset(
                                      "assets/images/logo_a221.png",
                                      color: rouge,
                                      fit: BoxFit.cover,
                                    )),
                                paddingHorizontalGlobal(8),
                              ],
                            ),
                          ),
                        ),
                      ),
                      paddingHorizontalGlobal(),
                      Container(
                        width: 1,
                        height: 20,
                        color: noir,
                      ),
                      paddingHorizontalGlobal(),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        onEnter: (e) => homeUtilisateurBloc.setHover(2),
                        onExit: (e) => homeUtilisateurBloc.setHover(0),
                        child: GestureDetector(
                          onTap: () => homeUtilisateurBloc.setShowMenu(),
                          child: Container(
                            height: 60,
                            color: homeUtilisateurBloc.hover == 2
                                ? noir.withOpacity(.05)
                                : blanc,
                            child: Row(
                              children: [
                                paddingHorizontalGlobal(
                                  size.width >= 1440
                                      ? 8
                                      : size.width <= 1024 && size.width > 1440
                                          ? 6
                                          : 4,
                                ),
                                Text(
                                  "DEVENIR CORRESPONDANT ?",
                                  style: TextStyle(
                                      fontSize: size.width >= 1440
                                          ? 12
                                          : size.width <= 1024 &&
                                                  size.width > 1440
                                              ? 10
                                              : 8,
                                      color: noir,
                                      fontWeight: FontWeight.bold),
                                ),
                                paddingHorizontalGlobal(
                                  size.width >= 1440
                                      ? 8
                                      : size.width <= 1024 && size.width > 1440
                                          ? 6
                                          : 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        onEnter: (e) => homeUtilisateurBloc.setHover(3),
                        onExit: (e) => homeUtilisateurBloc.setHover(0),
                        child: Container(
                          height: 60,
                          color: homeUtilisateurBloc.hover == 3
                              ? noir.withOpacity(.05)
                              : blanc,
                          child: Row(
                            children: [
                              paddingHorizontalGlobal(
                                size.width >= 1440
                                    ? 8
                                    : size.width <= 1024 && size.width > 1440
                                        ? 6
                                        : 4,
                              ),
                              SvgPicture.asset(
                                "assets/images/live_actu.svg",
                                height: size.width >= 1440
                                    ? 14
                                    : size.width <= 1024 && size.width > 1440
                                        ? 10
                                        : 6,
                                width: size.width >= 1440
                                    ? 14
                                    : size.width <= 1024 && size.width > 1440
                                        ? 10
                                        : 6,
                              ),
                              paddingHorizontalGlobal(
                                size.width >= 1440
                                    ? 8
                                    : size.width <= 1024 && size.width > 1440
                                        ? 6
                                        : 4,
                              ),
                              Text(
                                "En direct".toUpperCase(),
                                style: TextStyle(
                                    fontSize: size.width >= 1440
                                        ? 12
                                        : size.width <= 1024 &&
                                                size.width > 1440
                                            ? 10
                                            : 8,
                                    color: noir,
                                    fontWeight: FontWeight.w600),
                              ),
                              paddingHorizontalGlobal(
                                size.width >= 1440
                                    ? 8
                                    : size.width <= 1024 && size.width > 1440
                                        ? 6
                                        : 4,
                              ),
                              Icon(
                                CupertinoIcons.chevron_down,
                                size: size.width >= 1440
                                    ? 12
                                    : size.width <= 1024 && size.width > 1440
                                        ? 10
                                        : 8,
                                color: noir,
                              ),
                              paddingHorizontalGlobal(
                                size.width >= 1440
                                    ? 8
                                    : size.width <= 1024 && size.width > 1440
                                        ? 6
                                        : 4,
                              ),
                            ],
                          ),
                        ),
                      ),
                      paddingHorizontalGlobal(),
                      GestureDetector(
                        onTap: () => context.go("/login"),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                            height: 35,
                            decoration: BoxDecoration(
                                color: rouge,
                                borderRadius: BorderRadius.circular(2)),
                            child: Row(
                              children: [
                                paddingHorizontalGlobal(
                                  size.width >= 1440
                                      ? 8
                                      : size.width <= 1024 && size.width > 1440
                                          ? 6
                                          : 4,
                                ),
                                Text(
                                  "Créer mon compte",
                                  style: TextStyle(
                                      fontSize: size.width >= 1440
                                          ? 12
                                          : size.width <= 1024 &&
                                                  size.width > 1440
                                              ? 10
                                              : 8,
                                      color: blanc),
                                ),
                                paddingHorizontalGlobal(
                                  size.width >= 1440
                                      ? 8
                                      : size.width <= 1024 && size.width > 1440
                                          ? 6
                                          : 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      paddingHorizontalGlobal(),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        onEnter: (e) => homeUtilisateurBloc.setHover(4),
                        onExit: (e) => homeUtilisateurBloc.setHover(0),
                        child: Container(
                          height: 60,
                          color: homeUtilisateurBloc.hover == 4
                              ? noir.withOpacity(.05)
                              : blanc,
                          child: Row(
                            children: [
                              paddingHorizontalGlobal(8),
                              Icon(
                                CupertinoIcons.person_alt_circle,
                                size: 32,
                                color: noir,
                              ),
                              paddingHorizontalGlobal(8),
                            ],
                          ),
                        ),
                      ),
                      paddingHorizontalGlobal(),
                    ],
                  ),
                ))
            : Container(
                height: 60,
                width: size.width,
                decoration: BoxDecoration(
                    color: blanc,
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(color: noir.withOpacity(.3), blurRadius: .3)
                    ]),
                child: Row(
                  children: [
                    paddingHorizontalGlobal(),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      // onEnter: (e) => homeUtilisateurBloc.setHover(1),
                      // onExit: (e) => homeUtilisateurBloc.setHover(0),
                      child: GestureDetector(
                        onTap: () {
                          context.go('/');
                        },
                        child: Container(
                          height: 60,
                          color: homeUtilisateurBloc.hover == 1
                              ? noir.withOpacity(.05)
                              : blanc,
                          child: Row(
                            children: [
                              paddingHorizontalGlobal(8),
                              SizedBox(
                                  width: size.width >= 1440
                                      ? 300
                                      : size.width <= 1024 && size.width > 1440
                                          ? 200
                                          : 150,
                                  child: Image.asset(
                                    "assets/images/logo_a221.png",
                                    color: rouge,
                                    fit: BoxFit.cover,
                                  )),
                              paddingHorizontalGlobal(8),
                            ],
                          ),
                        ),
                      ),
                    ),
                    paddingHorizontalGlobal(),
                    Container(
                      width: 1,
                      height: 20,
                      color: noir,
                    ),
                    paddingHorizontalGlobal(),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onEnter: (e) => homeUtilisateurBloc.setHover(2),
                      onExit: (e) => homeUtilisateurBloc.setHover(0),
                      child: GestureDetector(
                        onTap: () => homeUtilisateurBloc.setShowMenu(),
                        child: Container(
                          height: 60,
                          color: homeUtilisateurBloc.hover == 2
                              ? noir.withOpacity(.05)
                              : blanc,
                          child: Row(
                            children: [
                              paddingHorizontalGlobal(
                                size.width >= 1440
                                    ? 8
                                    : size.width <= 1024 && size.width > 1440
                                        ? 6
                                        : 4,
                              ),
                              Text(
                                "DEVENIR CORRESPONDANT ?",
                                style: TextStyle(
                                    fontSize: size.width >= 1440
                                        ? 12
                                        : size.width <= 1024 &&
                                                size.width > 1440
                                            ? 10
                                            : 8,
                                    color: noir,
                                    fontWeight: FontWeight.bold),
                              ),
                              paddingHorizontalGlobal(
                                size.width >= 1440
                                    ? 8
                                    : size.width <= 1024 && size.width > 1440
                                        ? 6
                                        : 4,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onEnter: (e) => homeUtilisateurBloc.setHover(3),
                      onExit: (e) => homeUtilisateurBloc.setHover(0),
                      child: Container(
                        height: 60,
                        color: homeUtilisateurBloc.hover == 3
                            ? noir.withOpacity(.05)
                            : blanc,
                        child: Row(
                          children: [
                            paddingHorizontalGlobal(
                              size.width >= 1440
                                  ? 8
                                  : size.width <= 1024 && size.width > 1440
                                      ? 6
                                      : 4,
                            ),
                            SvgPicture.asset(
                              "assets/images/live_actu.svg",
                              height: size.width >= 1440
                                  ? 14
                                  : size.width <= 1024 && size.width > 1440
                                      ? 10
                                      : 6,
                              width: size.width >= 1440
                                  ? 14
                                  : size.width <= 1024 && size.width > 1440
                                      ? 10
                                      : 6,
                            ),
                            paddingHorizontalGlobal(
                              size.width >= 1440
                                  ? 8
                                  : size.width <= 1024 && size.width > 1440
                                      ? 6
                                      : 4,
                            ),
                            Text(
                              "En direct".toUpperCase(),
                              style: TextStyle(
                                  fontSize: size.width >= 1440
                                      ? 12
                                      : size.width <= 1024 && size.width > 1440
                                          ? 10
                                          : 8,
                                  color: noir,
                                  fontWeight: FontWeight.w600),
                            ),
                            paddingHorizontalGlobal(
                              size.width >= 1440
                                  ? 8
                                  : size.width <= 1024 && size.width > 1440
                                      ? 6
                                      : 4,
                            ),
                            Icon(
                              CupertinoIcons.chevron_down,
                              size: size.width >= 1440
                                  ? 12
                                  : size.width <= 1024 && size.width > 1440
                                      ? 10
                                      : 8,
                              color: noir,
                            ),
                            paddingHorizontalGlobal(
                              size.width >= 1440
                                  ? 8
                                  : size.width <= 1024 && size.width > 1440
                                      ? 6
                                      : 4,
                            ),
                          ],
                        ),
                      ),
                    ),
                    paddingHorizontalGlobal(),
                    GestureDetector(
                      onTap: () => context.go("/login"),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Container(
                          height: 35,
                          decoration: BoxDecoration(
                              color: rouge,
                              borderRadius: BorderRadius.circular(2)),
                          child: Row(
                            children: [
                              paddingHorizontalGlobal(
                                size.width >= 1440
                                    ? 8
                                    : size.width <= 1024 && size.width > 1440
                                        ? 6
                                        : 4,
                              ),
                              Text(
                                "Créer mon compte",
                                style: TextStyle(
                                    fontSize: size.width >= 1440
                                        ? 12
                                        : size.width <= 1024 &&
                                                size.width > 1440
                                            ? 10
                                            : 8,
                                    color: blanc),
                              ),
                              paddingHorizontalGlobal(
                                size.width >= 1440
                                    ? 8
                                    : size.width <= 1024 && size.width > 1440
                                        ? 6
                                        : 4,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    paddingHorizontalGlobal(),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onEnter: (e) => homeUtilisateurBloc.setHover(4),
                      onExit: (e) => homeUtilisateurBloc.setHover(0),
                      child: Container(
                        height: 60,
                        color: homeUtilisateurBloc.hover == 4
                            ? noir.withOpacity(.05)
                            : blanc,
                        child: Row(
                          children: [
                            paddingHorizontalGlobal(8),
                            Icon(
                              CupertinoIcons.person_alt_circle,
                              size: 32,
                              color: noir,
                            ),
                            paddingHorizontalGlobal(8),
                          ],
                        ),
                      ),
                    ),
                    paddingHorizontalGlobal(),
                  ],
                ),
              );
  }
}
