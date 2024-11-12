import 'package:actu/models/administrateur/categorie-model.dart';
import 'package:actu/models/administrateur/sous-categorie-model.dart';
import 'package:actu/services/administrateur/categorie-service.dart';
import 'package:actu/services/administrateur/sous-categorie-service.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SousCategorieBloc with ChangeNotifier {
  SousCategorieService sousCategorieService = SousCategorieService();

  CategorieService categorieService = CategorieService();

  TextEditingController titre = TextEditingController();

  String recherche = "";

  setRecherche(String v) {
    recherche = v;
    notifyListeners();
  }

  int showUpadte = 0;

  setShowUpdate(int i) {
    showUpadte = i;
    notifyListeners();
  }

  bool chargement = false;

  CategorieModel? categorie;

  List<SousCategorieModel> sous_categories = [];

  SousCategorieModel? sousCategorie;

  setSousCategorie(SousCategorieModel? sous) {
    sousCategorie = sous;
    titre.text = sousCategorie!.titre!;
    categorie =
        categories.lastWhere((e) => e.id! == sousCategorie!.categorie!.id!);
    notifyListeners();
  }

  List<CategorieModel> categories = [];

  setCategorie(CategorieModel cat) async {
    categorie = cat;
    notifyListeners();
  }

  setCategorieById(String id) {
    categorie = categories.lastWhere((e) => e.id! == id);
    notifyListeners();
  }

  addSousCategorie() async {
    chargement = true;
    notifyListeners();
    String? result = await sousCategorieService
        .add({"titre": titre.text, "categorie": categorie!.id!});

    if (result != null) {
      Fluttertoast.showToast(
          msg: "Sous Categorie ajoutée avec success.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: vert,
          textColor: Colors.white,
          fontSize: 12.0);
      await allSousCategorie();
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

  updateSousCategorie() async {
    chargement = true;
    notifyListeners();
    String? result = await sousCategorieService.update(
        {"titre": titre.text, "categorie": categorie!.id!}, sousCategorie!.id!);

    if (result != null) {
      Fluttertoast.showToast(
          msg: "Sous Categorie modifier avec success.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: vert,
          textColor: Colors.white,
          fontSize: 12.0);
      await allSousCategorie();
      showUpadte = 0;
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

  activeSousCategorie() async {
    chargement = true;
    notifyListeners();
    String? result = await sousCategorieService.update(
        {"statusOnline": sousCategorie!.statusOnline == "on" ? "off" : "on"},
        sousCategorie!.id!);

    if (result != null) {
      Fluttertoast.showToast(
          msg: "Sous Categorie modifier avec success.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: vert,
          textColor: Colors.white,
          fontSize: 12.0);
      await allSousCategorie();
      showUpadte = 0;
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

  allSousCategorie() async {
    sous_categories = await sousCategorieService.all();

    notifyListeners();
  }

  allCategorie() async {
    categories = await categorieService.all();
    notifyListeners();
  }

  SousCategorieBloc() {
    allSousCategorie();
    allCategorie();
  }
}
