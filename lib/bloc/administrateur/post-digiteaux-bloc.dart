import 'package:actu/models/administrateur/file-model.dart';
import 'package:actu/models/administrateur/post-digiteaux-model.dart';
import 'package:actu/services/administrateur/emission-service.dart';
import 'package:actu/services/administrateur/pots-digiteaux-service.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/file-picker-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PostsDigiteauxBloc with ChangeNotifier {
  EmissionService emissionService = EmissionService();
  PostsDigiteauxService postsDigiteauxService = PostsDigiteauxService();
  TextEditingController titre = TextEditingController();

  int showUpdate = 0;

  setShowUpdate(int i) {
    showUpdate = i;
    if (i == 0) {
      imagePost = [null, null];
      notifyListeners();
    }
    notifyListeners();
  }

  int parcourirFile = 0;

  FileModel? fileModel;

  List<FileModel> filesModel = [];

  String recherche = "";

  setRecherche(String r) {
    recherche = r;
    notifyListeners();
  }

  allFileModel() async {
    filesModel = await emissionService.allFile();
    notifyListeners();
  }

  setParcourirFile(int i) {
    parcourirFile = i;
    notifyListeners();
  }

  setFileModel(FileModel? f) {
    if (fileModel == f) {
      fileModel = null;
    } else {
      fileModel = f;
    }
    notifyListeners();
  }

  List<dynamic> imagePost = [null, null];

  getImagePost() async {
    imagePost = await getImage(0);
    notifyListeners();
  }

  getImagePostUpdate() async {
    imagePost = await getImageUpdate(0, post!.image!);
    notifyListeners();
  }

  int typePost = 0;

  settypePost(int i) {
    typePost = i;
    notifyListeners();
  }

  bool chargement = false;

  addPost() async {
    chargement = true;
    notifyListeners();

    String? result = await postsDigiteauxService.add({
      "type": typePost == 0 ? 'essentiel' : 'commercial',
      "image": fileModel == null ? imagePost[0] : fileModel!.id!,
      "titre": titre.text
    });

    if (result != null) {
      Fluttertoast.showToast(
          msg: "Posts ajoutée avec success.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: vert,
          textColor: Colors.white,
          fontSize: 12.0);
      typePost = 0;
      allPosts();
      allFileModel();
      fileModel = null;
      parcourirFile = 0;
      imagePost = [null, null];
      notifyListeners();
    } else {
      Fluttertoast.showToast(
          msg: "Une erreur à été decélé.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: rouge,
          textColor: Colors.white,
          fontSize: 12.0);
    }
    chargement = false;
    notifyListeners();
  }

  updatePost() async {
    chargement = true;
    notifyListeners();

    String? result = await postsDigiteauxService.update({
      "type": typePost == 0 ? 'essentiel' : 'commercial',
      "image": fileModel == null ? imagePost[0] : fileModel!.id!,
      "titre": titre.text
    }, post!.id!);

    if (result != null) {
      Fluttertoast.showToast(
          msg: "Posts modifier avec success.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: vert,
          textColor: Colors.white,
          fontSize: 12.0);
      typePost = 0;
      allPosts();
      allFileModel();
      fileModel = null;
      parcourirFile = 0;
      imagePost = [null, null];
      notifyListeners();
    } else {
      Fluttertoast.showToast(
          msg: "Une erreur à été decélé.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: rouge,
          textColor: Colors.white,
          fontSize: 12.0);
    }
    chargement = false;
    notifyListeners();
  }

  activePost() async {
    chargement = true;
    notifyListeners();

    String? result = await postsDigiteauxService.update(
        {"statusOnline": post!.statusOnline! == "on" ? "off" : "on"},
        post!.id!);

    if (result != null) {
      Fluttertoast.showToast(
          msg: "Posts modifier avec success.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: vert,
          textColor: Colors.white,
          fontSize: 12.0);
      typePost = 0;
      allPosts();
      imagePost = [null, null];
      notifyListeners();
    } else {
      Fluttertoast.showToast(
          msg: "Une erreur à été decélé.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: rouge,
          textColor: Colors.white,
          fontSize: 12.0);
    }
    chargement = false;
    notifyListeners();
  }

  List<PostsDigiteauxModel> posts = [];
  PostsDigiteauxModel? post;

  setPost(PostsDigiteauxModel? p) {
    post = p;
    typePost = post!.type == 'essentiel' ? 0 : 1;
    imagePost = [post!.image!.id!, "$BASE_URL_ASSET${post!.image!.url}"];
    titre.text = post!.titre!;
    notifyListeners();
  }

  allPosts() async {
    posts = await postsDigiteauxService.all();

    notifyListeners();
  }

  PostsDigiteauxBloc() {
    allPosts();
    allFileModel();
  }
}
