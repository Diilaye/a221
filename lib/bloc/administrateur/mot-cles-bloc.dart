import 'package:actu/models/administrateur/mot-cles-model.dart';
import 'package:actu/services/administrateur/key-world-service.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MotsClesBloc with ChangeNotifier {
  KeyWorlService keyWorlService = KeyWorlService();

  TextEditingController titre = TextEditingController();

  bool chargement = false;

  MotClesModel? motClesModel;

  int showUpdate = 0;

  setShowUpdate(int i) {
    showUpdate = i;
    notifyListeners();
  }

  setMotCles(MotClesModel? m) {
    motClesModel = m;
    titre.text = motClesModel!.titre!;
    notifyListeners();
  }

  List<MotClesModel> motCles = [];

  addMotCles(BuildContext context) async {
    chargement = true;
    notifyListeners();

    String? result = await keyWorlService.add({"titre": titre.text});

    if (result != null) {
      Fluttertoast.showToast(
          msg: "Mots clés ajoutée avec success.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: vert,
          textColor: Colors.white,
          fontSize: 12.0);
      // await allTags();
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

  updateMotCles() async {
    chargement = true;
    notifyListeners();

    String? result =
        await keyWorlService.update({"titre": titre.text}, motClesModel!.id!);

    if (result != null) {
      Fluttertoast.showToast(
          msg: "Mots clés modifie avec success.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: vert,
          textColor: Colors.white,
          fontSize: 12.0);
      allMotsCles();
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

  activeMotCles() async {
    chargement = true;
    notifyListeners();

    String? result = await keyWorlService.update(
        {"statusOnline": motClesModel!.statusOnline == "on" ? "off" : "on"},
        motClesModel!.id!);

    if (result != null) {
      Fluttertoast.showToast(
          msg: "Mots clés modifie avec success.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: vert,
          textColor: Colors.white,
          fontSize: 12.0);
      // await allTags();
      allMotsCles();
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

  allMotsCles() async {
    motCles = await keyWorlService.all();
    notifyListeners();
  }

  MotsClesBloc() {
    allMotsCles();
  }
}
