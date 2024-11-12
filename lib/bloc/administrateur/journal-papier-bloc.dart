import 'package:actu/models/administrateur/file-model.dart';
import 'package:actu/models/administrateur/journal-papier-model.dart';
import 'package:actu/services/administrateur/emission-service.dart';
import 'package:actu/services/administrateur/journal-papier-service.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/file-picker-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class JourPapierBloc with ChangeNotifier {
  JournalPapierService journalPapierService = JournalPapierService();
  EmissionService emissionService = EmissionService();

  List<dynamic> imageJournal = [null, null];
  List<dynamic> fileUrl = [null, null];

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

  getImageJournal() async {
    imageJournal = await getImage(0);
    notifyListeners();
  }

  getImageJournalUpdate() async {
    imageJournal = await getImageUpdate(0, journalPapier!.image!);
    notifyListeners();
  }

  getFileJournal() async {
    fileUrl = await getFile();
    notifyListeners();
  }

  bool chargement = false;

  addJournalPapier() async {
    chargement = true;
    notifyListeners();

    String? result = await journalPapierService.add({
      // "file": fileUrl[0],
      "image": fileModel == null ? imageJournal[0] : fileModel!.id!,
    });

    if (result != null) {
      Fluttertoast.showToast(
          msg: "Journal ajoutée avec success.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: vert,
          textColor: Colors.white,
          fontSize: 12.0);
      allPapier();
      showUpdate = 0;
      fileModel = null;
      imageJournal = [null, null];
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
      allPapier();
      showUpdate = 0;
      fileModel = null;
      imageJournal = [null, null];
    }
    chargement = false;
    notifyListeners();
  }

  updateJournalPapier() async {
    chargement = true;
    notifyListeners();

    String? result = await journalPapierService.update({
      "image": fileModel == null ? imageJournal[0] : fileModel!.id!,
    }, journalPapier!.id!);

    if (result != null) {
      Fluttertoast.showToast(
          msg: "Journal modifier avec success.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: vert,
          textColor: Colors.white,
          fontSize: 12.0);
      allPapier();
      fileModel = null;
      imageJournal = [null, null];
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

  activeJournalPapier() async {
    chargement = true;
    notifyListeners();

    String? result = await journalPapierService.update({
      "statusOnline": journalPapier!.statusOnline! == "on" ? "off" : "on",
    }, journalPapier!.id!);

    if (result != null) {
      allPapier();
      Fluttertoast.showToast(
          msg: "Journal modifier avec success.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: vert,
          textColor: Colors.white,
          fontSize: 12.0);
      allPapier();
      showUpdate = 0;
      fileModel = null;
      imageJournal = [null, null];
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

  List<PapierJournalModel> journalPapiers = [];
  PapierJournalModel? journalPapier;

  setPapierJournal(PapierJournalModel? j) {
    journalPapier = j;
    imageJournal = [
      journalPapier!.image!.id!,
      "$BASE_URL_ASSET${journalPapier!.image!.url}"
    ];

    notifyListeners();
  }

  allPapier() async {
    journalPapiers = await journalPapierService.all();
    notifyListeners();
  }

  JourPapierBloc() {
    allPapier();
    allFileModel();
  }
}
