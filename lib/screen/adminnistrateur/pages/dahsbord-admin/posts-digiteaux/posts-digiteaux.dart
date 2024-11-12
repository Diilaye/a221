import 'package:actu/bloc/administrateur/menu-admin.dart';
import 'package:actu/bloc/administrateur/post-digiteaux-bloc.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/posts-digiteaux/add-post-digiteaux.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/posts-digiteaux/update-post-digiteaux.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/diallog-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostDigiteauxScreen extends StatelessWidget {
  const PostDigiteauxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final menuAdminBloc = Provider.of<MenuAdminBloc>(context);
    final postsDigiteauxBloc = Provider.of<PostsDigiteauxBloc>(context);

    return Stack(
      children: [
        ListView(
          children: [
            paddingVerticalGlobal(size.height * .02),
            Row(
              children: [
                paddingHorizontalGlobal(),
                Text(
                  'Posts digiteaux'.toUpperCase(),
                  style: fontFammilyDii(
                      context, 20, noir, FontWeight.bold, FontStyle.normal),
                )
              ],
            ),
            paddingVerticalGlobal(size.height * .02),
            Row(
              children: [
                paddingHorizontalGlobal(),
                Icon(
                  CupertinoIcons.home,
                  color: noir.withOpacity(.6),
                  size: 14,
                ),
                paddingHorizontalGlobal(6),
                Icon(
                  CupertinoIcons.chevron_forward,
                  color: noir.withOpacity(.6),
                  size: 12,
                ),
                paddingHorizontalGlobal(6),
                Text(
                  'Posts digiteaux',
                  style: fontFammilyDii(context, 14, noir.withOpacity(.6),
                      FontWeight.w300, FontStyle.normal),
                ),
                paddingHorizontalGlobal(6),
                Icon(
                  CupertinoIcons.chevron_forward,
                  color: noir.withOpacity(.6),
                  size: 12,
                ),
                paddingHorizontalGlobal(6),
                Text(
                  'Dashbord',
                  style: fontFammilyDii(
                      context, 12, noir, FontWeight.w300, FontStyle.normal),
                ),
                const Spacer(),
                CircleAvatar(
                    backgroundColor: noir.withOpacity(.5),
                    child: Center(child: Icon(CupertinoIcons.printer))),
                paddingHorizontalGlobal(8),
                CircleAvatar(
                    backgroundColor: noir.withOpacity(.5),
                    child: Center(child: Icon(CupertinoIcons.folder_circle))),
                paddingHorizontalGlobal(),
              ],
            ),
            paddingVerticalGlobal(),
            Row(
              children: [
                const Spacer(),
                paddingHorizontalGlobal(),
                GestureDetector(
                  onTap: () => menuAdminBloc.setPresseEcrite(1),
                  child: CircleAvatar(
                      backgroundColor: bleuMarine,
                      child: Icon(
                        CupertinoIcons.add,
                        color: blanc,
                      )),
                ),
                paddingHorizontalGlobal(),
              ],
            ),
            paddingVerticalGlobal(),
            SizedBox(
                height: 700,
                width: size.width,
                child: GridView.count(
                    crossAxisCount: 4,
                    padding: EdgeInsets.all(8),
                    children: postsDigiteauxBloc.posts
                        .map((e) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 2,
                                color: e.statusOnline! == "on" ? blanc : rouge,
                                child: Column(
                                  children: [
                                    paddingVerticalGlobal(6),
                                    Expanded(
                                      flex: 5,
                                      child: Row(
                                        children: [
                                          paddingHorizontalGlobal(6),
                                          Expanded(
                                            child: Image.network(
                                              BASE_URL_ASSET + e.image!.url!,
                                              height: 2000,
                                              width: 2000,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          paddingHorizontalGlobal(6),
                                        ],
                                      ),
                                    ),
                                    paddingVerticalGlobal(8),
                                    Row(
                                      children: [
                                        paddingHorizontalGlobal(8),
                                        Text(
                                          e.type!.toUpperCase(),
                                          style: fontFammilyDii(
                                              context,
                                              14,
                                              bleuMarine,
                                              FontWeight.bold,
                                              FontStyle.normal),
                                        )
                                      ],
                                    ),
                                    paddingVerticalGlobal(4),
                                    Row(
                                      children: [
                                        const Spacer(),
                                        IconButton(
                                            onPressed: () {
                                              postsDigiteauxBloc.setPost(e);
                                              postsDigiteauxBloc
                                                  .setShowUpdate(1);
                                            },
                                            tooltip: "Modifier posts",
                                            icon:
                                                const Icon(CupertinoIcons.pen)),
                                        paddingHorizontalGlobal(6),
                                        IconButton(
                                            onPressed: () async =>
                                                dialogRequest(
                                                        title:
                                                            'Vous êtes sur de vouloir suprimer ce posts',
                                                        context: context)
                                                    .then((value) async {
                                                  if (value) {
                                                    postsDigiteauxBloc
                                                        .setPost(e);
                                                    postsDigiteauxBloc
                                                        .activePost();
                                                  }
                                                }),
                                            tooltip: e.statusOnline! == "on"
                                                ? "Suprimer posts"
                                                : "Réintégrer posts",
                                            icon: Icon(e.statusOnline! == "on"
                                                ? CupertinoIcons.delete
                                                : Icons.publish)),
                                        paddingHorizontalGlobal(8),
                                      ],
                                    ),
                                    paddingVerticalGlobal(4),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          paddingVerticalGlobal(8),
                                          Row(
                                            children: [
                                              paddingHorizontalGlobal(6),
                                              Expanded(
                                                child: Text(
                                                  e.date!
                                                      .split("T")[0]
                                                      .split("-")
                                                      .reversed
                                                      .join('/'),
                                                  overflow: TextOverflow.clip,
                                                  style: fontFammilyDii(
                                                      context,
                                                      12,
                                                      noir,
                                                      FontWeight.w300,
                                                      FontStyle.normal),
                                                ),
                                              ),
                                              const Spacer(),
                                              Icon(
                                                CupertinoIcons.square_fill,
                                                color: e.statusOnline! == "on"
                                                    ? vert
                                                    : rouge,
                                                size: 12,
                                              ),
                                              paddingHorizontalGlobal(4),
                                              Text(
                                                e.statusOnline! == "on"
                                                    ? 'En ligne'
                                                    : "Brouillons",
                                                overflow: TextOverflow.clip,
                                                style: fontFammilyDii(
                                                    context,
                                                    12,
                                                    noir,
                                                    FontWeight.w800,
                                                    FontStyle.normal),
                                              ),
                                              paddingHorizontalGlobal(6),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        .toList())),
            paddingVerticalGlobal(),
            Row(
              children: [
                paddingHorizontalGlobal(8),
                Text(
                  "Affichage de 1 à 10 sur 50 posts",
                  style: fontFammilyDii(context, 14, noir.withOpacity(.7),
                      FontWeight.w700, FontStyle.normal),
                ),
                const Spacer(),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: SizedBox(
                      height: 30,
                      width: 50,
                      child: Center(
                          child: Icon(
                        CupertinoIcons.chevron_left,
                        size: 14,
                        color: noir,
                      ))),
                ),
                paddingHorizontalGlobal(8),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: SizedBox(
                      height: 30,
                      width: 50,
                      child: Center(
                          child: Icon(
                        CupertinoIcons.chevron_right,
                        size: 14,
                        color: noir,
                      ))),
                ),
                paddingHorizontalGlobal(),
              ],
            )
          ],
        ),
        if (menuAdminBloc.addPresseEcrite == 1)
          Positioned(
              top: 0,
              right: 0,
              child: SizedBox(
                width: size.width * .8,
                height: size.height,
                child: const AddPostDigiteauxScreen(),
              )),
        if (postsDigiteauxBloc.showUpdate == 1)
          Positioned(
              top: 0,
              right: 0,
              child: SizedBox(
                width: size.width * .8,
                height: size.height,
                child: const UpdatePostDigiteauxScreen(),
              )),
      ],
    );
  }
}
