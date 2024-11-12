import 'package:actu/models/administrateur/flash-news-model.dart';
import 'package:actu/services/administrateur/flash-new-service.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FlashNewsBloc with ChangeNotifier {
  FlashNewsService flashNewsService = FlashNewsService();

  TextEditingController type = TextEditingController();
  TextEditingController desc = TextEditingController();

  List<FlashNewsModel> flashNews = [];
  FlashNewsModel? flashNew;

  setFlashNews(FlashNewsModel? f) {
    flashNew = f;
    type.text = flashNew!.type!;
    desc.text = flashNew!.desc!;
  }

  bool chargement = false;

  int showUpdate = 0;

  setShowUpdate(int i) {
    showUpdate = i;
    notifyListeners();
  }

  add() async {
    chargement = true;
    notifyListeners();

    String? result =
        await flashNewsService.add({"type": type.text, "desc": desc.text});

    if (result != null) {
      Fluttertoast.showToast(
          msg: "flashNews ajoutée avec success.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: vert,
          textColor: Colors.white,
          fontSize: 12.0);
      await allFlashNews();
      type.text = "";
      desc.text = "";
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

  update() async {
    chargement = true;
    notifyListeners();

    String? result = await flashNewsService
        .update({"type": type.text, "desc": desc.text}, flashNew!.id!);

    if (result != null) {
      Fluttertoast.showToast(
          msg: "flashNews modifier avec success.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: vert,
          textColor: Colors.white,
          fontSize: 12.0);
      await allFlashNews();
      type.text = "";
      desc.text = "";
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
    }
    chargement = false;
    notifyListeners();
  }

  active() async {
    chargement = true;
    notifyListeners();

    String? result = await flashNewsService.update(
        {"statusOnline": flashNew!.statusOnline! == "on" ? "off" : "on"},
        flashNew!.id!);

    if (result != null) {
      Fluttertoast.showToast(
          msg: "flashNews modifier avec success.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: vert,
          textColor: Colors.white,
          fontSize: 12.0);
      await allFlashNews();
      type.text = "";
      desc.text = "";
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
    }
    chargement = false;
    notifyListeners();
  }

  allFlashNews() async {
    flashNews = await flashNewsService.all();
    // categorie = categories[0];
    notifyListeners();
  }

  FlashNewsBloc() {
    allFlashNews();
  }
}
