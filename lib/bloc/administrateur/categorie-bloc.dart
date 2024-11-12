import 'package:actu/models/administrateur/categorie-model.dart';
import 'package:actu/services/administrateur/categorie-service.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CategorieBloc with ChangeNotifier {
  CategorieService categorieService = CategorieService();

  TextEditingController titre = TextEditingController();
  String recherche = "";

  setRecherche(String v) {
    recherche = v;
    notifyListeners();
  }

  bool chargement = false;

  List<CategorieModel> categories = [];
  CategorieModel? categorie;

  int showUpdate = 0;

  setShowUpdate(int i) {
    showUpdate = i;
    notifyListeners();
  }

  addCategorie(BuildContext context) async {
    chargement = true;
    notifyListeners();

    String? result = await categorieService.add({"titre": titre.text});

    if (result != null) {
      Fluttertoast.showToast(
          msg: "Categorie ajoutée avec success.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: vert,
          textColor: Colors.white,
          fontSize: 12.0);
      await allCategorie();
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

  updateCategorie(BuildContext context) async {
    chargement = true;
    notifyListeners();

    String? result =
        await categorieService.update({"titre": titre.text}, categorie!.id!);

    if (result != null) {
      Fluttertoast.showToast(
          msg: "Categorie modifie avec success.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: vert,
          textColor: Colors.white,
          fontSize: 12.0);
      await allCategorie();
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

  activeCategorie() async {
    chargement = true;
    notifyListeners();

    String? result = await categorieService.update(
        {"statusOnline": categorie!.statusOnline == "on" ? "off" : "on"},
        categorie!.id!);

    if (result != null) {
      Fluttertoast.showToast(
          msg: "Categorie modifie avec success.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: vert,
          textColor: Colors.white,
          fontSize: 12.0);
      await allCategorie();
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

  setCategorie(CategorieModel? cat) {
    categorie = cat;
    titre.text = categorie!.titre!;
    notifyListeners();
  }

  allCategorie() async {
    categories = await categorieService.all();
    notifyListeners();
  }

  CategorieBloc() {
    allCategorie();
  }
}
