import 'package:actu/models/administrateur/tags-model.dart';
import 'package:actu/services/administrateur/tags-service.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TagsBloc with ChangeNotifier {
  TagsService tagsService = TagsService();

  TextEditingController titre = TextEditingController();

  TextEditingController tagRecherche = TextEditingController();

  bool chargement = false;

  int showUpdate = 0;

  String rechercheT = "";

  setShowUpdate(int i) {
    showUpdate = i;
    notifyListeners();
  }

  setRecherche(String v) {
    rechercheT = v;
    notifyListeners();
  }

  TagsModel? tag;

  setTage(TagsModel t) {
    tag = t;
    titre.text = tag!.titre!;
    notifyListeners();
  }

  List<TagsModel> tags = [];

  addTags(BuildContext context) async {
    chargement = true;
    notifyListeners();

    String? result = await tagsService.add({"titre": titre.text});

    if (result != null) {
      Fluttertoast.showToast(
          msg: "Tags ajoutée avec success.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: vert,
          textColor: Colors.white,
          fontSize: 12.0);
      await allTags();
      titre.text = "";
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

  updateTags(BuildContext context) async {
    chargement = true;
    notifyListeners();

    String? result = await tagsService.update({"titre": titre.text}, tag!.id!);

    if (result != null) {
      Fluttertoast.showToast(
          msg: "Tags modifier avec success.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: vert,
          textColor: Colors.white,
          fontSize: 12.0);
      await allTags();
      titre.text = "";
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

  activeTags() async {
    chargement = true;
    notifyListeners();

    String? result = await tagsService.update(
        {"statusOnline": tag!.statusOnline == "on" ? "off" : "on"}, tag!.id!);

    if (result != null) {
      Fluttertoast.showToast(
          msg: "Tags modifier avec success.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: vert,
          textColor: Colors.white,
          fontSize: 12.0);
      await allTags();
      titre.text = "";
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

  allTags() async {
    tags = await tagsService.all();

    notifyListeners();
  }

  TagsBloc() {
    allTags();
  }
}
