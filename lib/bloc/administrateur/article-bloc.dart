import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/models/administrateur/categorie-model.dart';
import 'package:actu/models/administrateur/file-model.dart';
import 'package:actu/models/administrateur/tags-model.dart';
import 'package:actu/services/administrateur/article-service.dart';
import 'package:actu/services/administrateur/categorie-service.dart';
import 'package:actu/services/administrateur/emission-service.dart';
import 'package:actu/services/administrateur/tags-service.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/file-picker-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class AddArticleBloc with ChangeNotifier {
  CategorieService categorieService = CategorieService();
  EmissionService emissionService = EmissionService();

  TagsService tagsService = TagsService();
  ArticleService articleService = ArticleService();
  QuillEditorController controllerProduct = QuillEditorController();
  TextEditingController titre = TextEditingController();
  TextEditingController motCles = TextEditingController();
  TextEditingController recherche = TextEditingController();
  String rechercheT = "";
  setRecherche(String v) {
    rechercheT = v;
    notifyListeners();
  }

  int showUpdate = 0;

  int updateDesc = 0;

  String statusNews = 'all';

  setStatusNews(String v) {
    statusNews = v;
    notifyListeners();
  }

  setUpdateDesc(int updat) {
    updateDesc = updat;
    notifyListeners();
  }

  List<CategorieModel> categories = [];
  CategorieModel? categorie;

  setShowUpdate(int i) {
    showUpdate = i;
    notifyListeners();
  }

  String body = "";

  setBody(String v) async {
    body = v;
    notifyListeners();
  }

  giveTextController() {
    print("giveTextController");
    print(body);
    controllerProduct.setText(body);
  }

  int parcourirFile = 0;

  FileModel? fileModel;

  List<FileModel> filesModel = [];

  String rechercheFile = "";

  setRechercheFile(String r) {
    rechercheFile = r;
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

  List<dynamic> imageAticle = [null, null];

  getImageArticle() async {
    imageAticle = await getImage(0);
    notifyListeners();
  }

  getImageArticleUpdate() async {
    imageAticle = await getImageUpdate(0, article!.imageArticle!);
    notifyListeners();
  }

  setCategorie(CategorieModel? cat) {
    categorie = cat;
    notifyListeners();
  }

  TagsModel? tag;

  setTags(TagsModel? t) {
    print(t?.toJson());
    tag = t;
    notifyListeners();
  }

  List<String> keyWorld = [];

  setContainer() {
    keyWorld.add(motCles.text.trim().toUpperCase());
    motCles.text = "";
    notifyListeners();
  }

  setKeyWord(List<String> liste) {
    for (var element in liste) {
      keyWorld.add(element);
    }
    notifyListeners();
  }

  removeContainer(String v) {
    keyWorld.remove(v);
    notifyListeners();
  }

  int typeArticle = 0;

  setTypeArticle(int i) {
    typeArticle = i;
    notifyListeners();
  }

  final FocusNode focusNode = FocusNode();

  bool chargement = false;

  addArticle() async {
    chargement = true;
    notifyListeners();

    String? result = await articleService.add({
      "titre": titre.text,
      "description": body,
      "typeUne": typeArticle == 0
          ? 'none'
          : typeArticle == 1
              ? 'top'
              : typeArticle == 2
                  ? 'une'
                  : typeArticle == 3
                      ? 'rubrique'
                      : 'choix-redac',
      "categorie": categorie!.id!,
      "tags": tag!.id!,
      "keyWorod": keyWorld.map((e) => e.toUpperCase().trim()).toList(),
      "image": fileModel == null ? imageAticle[0] : fileModel!.id!,
    });

    if (result != null) {
      Fluttertoast.showToast(
          msg: "article ajouté avec success.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: vert,
          textColor: Colors.white,
          fontSize: 12.0);
      titre.text = "";
      body = "";
      typeArticle = 0;
      showUpdate = 0;
      updateDesc = 0;
      keyWorld = [];
      fileModel = null;
      imageAticle = [null, null];
      categorie = null;
      tag = null;
      allArticles();
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

  activeArticle() async {
    String? result = await articleService.active({
      "statusOnline": article!.statusOnline! == "on" ? "off" : "on",
    }, article!.id!);

    if (result != null) {
      Fluttertoast.showToast(
          msg: "article modifier avec success.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: vert,
          textColor: Colors.white,
          fontSize: 12.0);
      showUpdate = 0;
      updateDesc = 0;
      allArticles();
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
  }

  updateArticle() async {
    chargement = true;
    notifyListeners();

    String? result = await articleService.update({
      "titre": titre.text,
      "description": body,
      "typeUne": typeArticle == 0
          ? 'none'
          : typeArticle == 1
              ? 'top'
              : typeArticle == 2
                  ? 'une'
                  : 'rubrique',
      "categorie": categorie!.id!,
      "tags": tag!.id!,
      "keyWorod": keyWorld.map((e) => e.toUpperCase().trim()).toList(),
      "image": fileModel == null ? imageAticle[0] : fileModel!.id!,
    }, article!.id!);

    if (result != null) {
      Fluttertoast.showToast(
          msg: "article modifier avec success.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: vert,
          textColor: Colors.white,
          fontSize: 12.0);
      showUpdate = 0;
      updateDesc = 0;
      allArticles();
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

  List<ArticlesModel> articles = [];

  ArticlesModel? article;

  setArticle(ArticlesModel? art, int i) async {
    article = art;
    titre.text = article!.titre!;
    body = article!.description!;
    typeArticle = article!.typeUne! == 'none'
        ? 0
        : article!.typeUne! == 'top'
            ? 1
            : article!.typeUne! == 'une'
                ? 2
                : 3;
    categorie = categories.lastWhere((e) => e.id! == article!.categorie!.id!);
    print(categorie!.toJson());
    tag = tags.lastWhere((e) => e.id! == article!.tags!.id!);
    keyWorld = [];
    setKeyWord(article!.keyWorod!);
    imageAticle = [
      article!.imageArticle!.id,
      "$BASE_URL_ASSET${article!.imageArticle!.url}"
    ];
    updateDesc = 0;
    setShowUpdate(i);
    notifyListeners();
  }

  allArticles() async {
    articles = await articleService.all();
    articles = articles.reversed.toList();
    notifyListeners();
  }

  allCategorie() async {
    categories = await categorieService.all();
    // categorie = categories[0];
    notifyListeners();
  }

  List<TagsModel> tags = [];

  allTags() async {
    tags = await tagsService.all();

    notifyListeners();
  }

  AddArticleBloc() {
    allArticles();
    allCategorie();
    allTags();
    allFileModel();
  }
}
