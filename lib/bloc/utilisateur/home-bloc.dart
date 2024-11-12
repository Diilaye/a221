import 'dart:async';

import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/models/administrateur/categorie-model.dart';
import 'package:actu/models/administrateur/flash-news-model.dart';
import 'package:actu/models/utilisateur/categorie-menu-model.dart';
import 'package:actu/models/utilisateur/tag-menu-model.dart';
import 'package:actu/services/utilisateur/home-service.dart';
import 'package:flutter/material.dart';

class HomeUtilisateurBloc with ChangeNotifier {
  final ScrollController controllerListHome = ScrollController();

  final ScrollController controllerListHomeMobileNav = ScrollController();

  double mobileNavPadd = 0;

  int showMenuMobile = 0;

  setShowMenuMobile() {
    if (showMenuMobile == 0) {
      showMenuMobile = 1;
    } else {
      showMenuMobile = 0;
    }
    setExpended();

    notifyListeners();
  }

  bool isExpanded = false;

  setExpended() {
    isExpanded = !isExpanded;
    notifyListeners();
  }

  HomeService homeService = HomeService();

  List<CategorieModel> categories = [];

  CategorieModel? catMenu;

  setCatMenu(CategorieModel? c) {
    catMenu = c;
    showMenuMobile = 0;
    notifyListeners();
  }

  List<FlashNewsModel> flashNews = [];

  CategorieMenuModel? categorieMenuModel;
  TagModelMenu? tagMenuModel;

  setCategorieMenu() async {
    categorieMenuModel = await homeService.categorieMenu(catMenu!.id!);
    showMenuMobile = 0;
    notifyListeners();
  }

  setCategorieMenuIndex(String id) async {
    categorieMenuModel = await homeService.categorieMenuName(id);
    notifyListeners();
  }

  setTagsMenuIndex(String id) async {
    tagMenuModel = await homeService.tagsMenuName(id);
    notifyListeners();
  }

  ArticlesModel? articleSlug;

  setAticleSlug(String slug) async {
    articleSlug = await homeService.articleSlug(slug);

    notifyListeners();
  }

  setAticle(ArticlesModel e) {
    articleSlug = e;
    notifyListeners();
  }

  List<ArticlesModel> articles = [];

  List<ArticlesModel> articleUnes = [];

  List<ArticlesModel> articlePolitiques = [];
  List<ArticlesModel> articleEconomies = [];
  List<ArticlesModel> articleInvestigations = [];
  List<ArticlesModel> articleChoixRedac = [];
  List<ArticlesModel> articleContributions = [];
  List<ArticlesModel> articleSport = [];
  List<ArticlesModel> articleCultures = [];
  List<ArticlesModel> articleAfriques = [];
  List<ArticlesModel> articleInternationals = [];
  List<ArticlesModel> articleActualites = [];

  ArticlesModel? topArticle;
  ArticlesModel? unePolitique;
  ArticlesModel? uneEconomie;
  ArticlesModel? uneInvestigations;
  ArticlesModel? uneChoixRedac;
  ArticlesModel? uneSport;
  ArticlesModel? uneCulture;
  ArticlesModel? uneAfrique;
  ArticlesModel? uneInternational;

  ArticlesModel? uneArticle;
  ArticlesModel? uneArticleMobile;

  setUneArticle(int i) async {
    uneArticle = articleUnes[i];
    notifyListeners();
  }

  setArticleMobile(int i) {
    uneArticleMobile = articleUnes[i];
    notifyListeners();
  }

  allArticles() async {
    articles = await homeService.allAricles();

    articles = articles.reversed.toList();
    articleUnes =
        articles.where((e) => e.typeUne == "une").toList().sublist(0, 5);

    uneArticle = articleUnes[0];
    uneArticleMobile = articleUnes[0];
    notifyListeners();

    articlePolitiques = articles
        .where(
            (e) => e.categorie!.titre == 'POLITIQUE' && e.typeUne != "rubrique")
        .toList();

    articleActualites = articles
        .where((e) =>
            e.categorie!.titre == 'ACTUALITES' && e.typeUne != "rubrique")
        .toList();

    unePolitique = articles.firstWhere(
        (e) => e.categorie!.titre == 'POLITIQUE' && e.typeUne! == "rubrique");

    articleEconomies = articles
        .where(
            (e) => e.categorie!.titre == 'ECONOMIE' && e.typeUne! != "rubrique")
        .toList();

    uneEconomie = articles.firstWhere(
        (e) => e.categorie!.titre == 'ECONOMIE' && e.typeUne! == "rubrique");

    articleInvestigations = articles
        .where((e) =>
            e.categorie!.titre == 'INVESTIGATION' && e.typeUne! != "rubrique")
        .toList();

    uneInvestigations = articles.firstWhere((e) =>
        e.categorie!.titre == 'INVESTIGATION' && e.typeUne == "rubrique");
    articleSport = articles
        .where(
            (e) => e.categorie!.titre == 'SPORTS' && e.typeUne! != "rubrique")
        .toList();

    uneSport = articles.firstWhere(
        (e) => e.categorie!.titre == 'SPORTS' && e.typeUne == "rubrique");

    articleChoixRedac = articles
        .where((e) =>
            e.categorie!.titre == 'CHOIX DE LA REDACTION' &&
            e.typeUne! != "rubrique")
        .toList();

    uneChoixRedac = articles.firstWhere((e) =>
        e.categorie!.titre == 'CHOIX DE LA REDACTION' &&
        e.typeUne! == "rubrique");

    articleContributions = articles
        .where((e) =>
            e.categorie!.titre == 'CONTRIBUTION & ANALYSE' &&
            e.typeUne != "rubrique")
        .toList();

    articleSport = articles
        .where(
            (e) => e.categorie!.titre == 'SPORTS' && e.typeUne! != "rubrique")
        .toList();

    uneSport = articles.firstWhere(
        (e) => e.categorie!.titre == 'SPORTS' && e.typeUne != "rubrique");

    articleCultures = articles
        .where((e) =>
            e.categorie!.titre == 'CULTURE & ART' && e.typeUne != "rubrique")
        .toList();

    uneCulture = articles.firstWhere(
        (e) => e.categorie!.titre == 'POLITIQUE' && e.typeUne != "rubrique");

    articleAfriques = articles
        .where(
            (e) => e.categorie!.titre == 'AFRIQUE' && e.typeUne != "rubrique")
        .toList();

    uneAfrique = articles.firstWhere(
        (e) => e.categorie!.titre == 'AFRIQUE' && e.typeUne != "rubrique");

    articleInternationals = articles
        .where((e) =>
            e.categorie!.titre == 'INTERNATIONAL' && e.typeUne != "rubrique")
        .toList();

    uneInternational = articles.firstWhere((e) =>
        e.categorie!.titre == 'INTERNATIONAL' && e.typeUne != "rubrique");
    notifyListeners();
  }

  getTopArticle() async {
    topArticle = await homeService.ArtilceTop();

    notifyListeners();
  }

  allRubrique() async {
    categories = await homeService.allCatgerie();

    notifyListeners();
  }

  bool showFlashInfo = true;

  setShowFlashInfo(bool _) {
    showFlashInfo = _;
    notifyListeners();
  }

  int hover = 0;

  setHover(int i) {
    hover = i;
    notifyListeners();
  }

  int hoverMenu = 0;

  int hoverMenuClick = 0;

  String? titleRubrique;

  setTitlerubrique(String t) {
    titleRubrique = t;
    notifyListeners();
  }

  setHoverMenuClick(int i, CategorieModel? cat) async {
    hoverMenuClick = 0;
    catMenu = cat;

    notifyListeners();
    await setCategorieMenu();
    notifyListeners();
  }

  setHoverMenu(int i) {
    hoverMenu = i;
    notifyListeners();
  }

  int uneTop = 0;

  Timer? timer;

  setUneTop() async {
    // timer = Timer.periodic(const Duration(seconds: 10), (timer) {
    //   if (uneTop == 4) {
    //     uneTop = 0;
    //   } else {
    //     uneTop++;
    //   }
    //   notifyListeners();
    //   setUneArticle(uneTop);
    // });
  }

  setTopClick(int i) {
    uneTop = i;
    setUneArticle(uneTop);
    notifyListeners();
  }

  int showMenu = 0;

  setShowMenu() {
    if (showMenu == 0) {
      showMenu = 1;
    } else {
      showMenu = 0;
      hoverMenuClick = 0;
    }
    notifyListeners();
  }

  setMobileNavPadd(double d) {
    mobileNavPadd = d;
    notifyListeners();
  }

  HomeUtilisateurBloc() {
    allRubrique();
    getTopArticle();

    allArticles();
    setUneTop();
    controllerListHome.addListener(() {
      if (controllerListHome.position.pixels > 100) {
        setShowFlashInfo(false);
      } else {
        setShowFlashInfo(true);
      }
    });

    controllerListHomeMobileNav.addListener(() {
      if (controllerListHomeMobileNav.position.pixels > 16) {
        if ((controllerListHomeMobileNav.position.pixels / 4) > 260) {
          setMobileNavPadd(350);
        }
        setMobileNavPadd(controllerListHomeMobileNav.position.pixels / 4);
      } else {
        setMobileNavPadd(controllerListHomeMobileNav.position.pixels);
      }
    });
  }
}
