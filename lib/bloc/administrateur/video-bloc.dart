import 'package:actu/models/administrateur/emission-model.dart';
import 'package:actu/models/administrateur/file-model.dart';
import 'package:actu/services/administrateur/emission-service.dart';
import 'package:actu/services/administrateur/video-service.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/file-picker-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../services/administrateur/video-youtube-service.dart';

class VideoBloc with ChangeNotifier {
  VideoYoutubeService videosService = VideoYoutubeService();

  List<dynamic> imagePost = [null, null];

  int showUpdate = 0;

  setShowUpdate(int i) {
    showUpdate = i;
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
    filesModel = await videosService.allFile();
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

  getImagePost() async {
    imagePost = await getImage(0);
    notifyListeners();
  }

  getImagePostUpdate() async {
   // imagePost = await getImageUpdate(0, emission!.photoCouverture!);
    notifyListeners();
  }

  TextEditingController titre = TextEditingController();
  TextEditingController emission = TextEditingController();
  TextEditingController url = TextEditingController();
  int type = 0;

  setType(int i) {
    type = i;
    notifyListeners();
  }

  bool chargement = false;

  addVideo() async {
    chargement = true;
    notifyListeners();

    String? result = await videosService.add({
      "isLive": type== 0 ? 'off' : 'on',
      "titre": titre.text,
      "emission": emission.text,
      "url": url.text,
      "image": fileModel == null ? imagePost[0] : fileModel!.id!,
    });

    if (result != null) {
      Fluttertoast.showToast(
          msg: "Video ajoutée avec success.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: vert,
          textColor: Colors.white,
          fontSize: 12.0);
      titre.text = "";
      emission.text = "";
      url.text = "";
      titre.text = "";
      fileModel = null;
      await allVideo();
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

  updateEmission() async {
    chargement = true;
    notifyListeners();
/*
    String? result = await emissionService.update({
      "type": typeEmission == 0 ? 'invite' : 'suivre',
      "titre": titre.text,
      "heure": heure.text,
      "urlMedia": url.text,
      "description": desc.text,
      "photoCouverture": fileModel == null ? imagePost[0] : fileModel!.id!,
    }, emission!.id!);

    if (result != null) {
      Fluttertoast.showToast(
          msg: "Emission modifier avec success.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: vert,
          textColor: Colors.white,
          fontSize: 12.0);
      titre.text = "";
      heure.text = "";
      url.text = "";
      titre.text = "";
      desc.text = "";
      await allEmissions();
      fileModel = null;
      showUpdate = 0;
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
    } */
    chargement = false;
    notifyListeners();
  }

  activeEmission() async {
    chargement = true;
    notifyListeners();

  /*  String? result = await emissionService.update(
        {"statusOnline": emission!.statusOnline == "on" ? "off" : "on"},
        emission!.id!);

    if (result != null) {
      Fluttertoast.showToast(
          msg: "Emission modifier avec success.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: vert,
          textColor: Colors.white,
          fontSize: 12.0);
      titre.text = "";
      heure.text = "";
      url.text = "";
      titre.text = "";
      desc.text = "";
      await allEmissions();
      showUpdate = 0;
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
    }*/
    chargement = false;
    notifyListeners();
  }

 // List<EmissionModel> emissions = [];

  //EmissionModel? emission;

  setEmission(EmissionModel? e) {
    /*  emission = e!;
   titre.text = e.titre!;
    heure.text = e.heure!;
    url.text = e.urlMedia!;
    desc.text = e.description!;
    typeEmission = e.type == 'invite' ? 0 : 1;
    imagePost = [
    //  e.photoCouverture!.id!,
     // "$BASE_URL_ASSET${e.photoCouverture!.url}"
    //];
    fileModel = null;
    notifyListeners();*/
  }

  allVideo() async {
 //   emissions = await videosService.all();

    notifyListeners();
  }

  VideoBloc() {
    allVideo();
    allFileModel();
  }
}
