import 'dart:async';

import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/models/administrateur/categorie-model.dart';
import 'package:actu/models/administrateur/flash-news-model.dart';
import 'package:actu/models/administrateur/video-youtube-model.dart';
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
    print(catMenu!.toJson());
    showMenuMobile = 0;
    notifyListeners();
  }

  List<FlashNewsModel> flashNews = [];

  CategorieMenuModel? categorieMenuModel;
  TagModelMenu? tagMenuModel;

  setCategorieMenu() async {
    categorieMenuModel = await homeService.categorieMenu(catMenu!.id!);
    print(categorieMenuModel!.articles!.length);
    showMenuMobile = 0;
    notifyListeners();
  }

  setCategorieMenuIndex(String id) async {
    print(id);
    categorieMenuModel = await homeService.categorieMenuName(id);
    print(categorieMenuModel!.articles!.length);
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

  List<VideoYoutubeModel> videos = [];

  allVideo() async {
    videos = await homeService.allVideos();
    notifyListeners();
  }

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

  bool showLiveYoutube = false ;

  setShowLiveYoutube() {
    showLiveYoutube = showLiveYoutube == true ? false : true;
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

    //notifyListeners();
   // await setCategorieMenu();
    notifyListeners();
  }

  setHoverMenu(int i) {
    hoverMenu = i;
    notifyListeners();
  }

  int uneTop = 0;

  Timer? timer;

  setUneTop() async {
     timer = Timer.periodic(const Duration(seconds: 10), (timer) {
       if (uneTop == 4) {
         uneTop = 0;
       } else {
         uneTop++;
       }
       notifyListeners();
       setUneArticle(uneTop);
     });
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

  uneArticlesFunc() async {
    articleUnes = await homeService.uneArticles();
    uneArticle = articleUnes[0];
    uneArticleMobile = articleUnes[0];
    setUneTop();
    notifyListeners();
  }

  articleActualiteFunc() async {
    articleActualites = await homeService.articleActualite();
    notifyListeners();
  }

  articlePolitiqueFunc() async {
    articlePolitiques = await homeService.articlePolitique();
    notifyListeners();
  }

  unePolitiqueFunc() async {
    unePolitique = await homeService.unePolitique();
    notifyListeners();
  }

  articleEconomieFunc() async {
    articleEconomies = await homeService.articleEconomie();
    notifyListeners();
  }

  uneEconomieFunc() async {
    uneEconomie = await homeService.uneEconomie();
    notifyListeners();
  }

  articleInvestigationFunc() async {
    articleInvestigations = await homeService.articleInvestigation();
    notifyListeners();
  }

  uneInvestigationFunc() async {
    uneInvestigations = await homeService.uneInvestigation();
    notifyListeners();
  }

  articleChoixRedacFunc() async {
    articleChoixRedac = await homeService.articleChoixRedac();
    notifyListeners();
  }

  articleContributionFunc() async {
    articleContributions  = await homeService.articleContribution();
    notifyListeners();
  }

  articleSportFunc() async {
    articleSport  = await homeService.articleSport();
    notifyListeners();
  }

  articleCultureFunc() async {
    articleCultures  = await homeService.articleCulture();
    notifyListeners();
  }

  articleAfriqueFunc() async {
    articleAfriques  = await homeService.articleAfrique();
    notifyListeners();
  }

  articleInternationalFunc() async {
    articleInternationals  = await homeService.articleInternational();
    notifyListeners();
  }

  HomeUtilisateurBloc() {
    allRubrique();
    getTopArticle();
    uneArticlesFunc();
    articleActualiteFunc();
    unePolitiqueFunc();
    articlePolitiqueFunc();
    articleContributionFunc();
    uneInvestigationFunc();
    articleInvestigationFunc();
    uneEconomieFunc();
    articleEconomieFunc();
    articleChoixRedacFunc();
    allVideo();
    articleSportFunc();
    articleCultureFunc();
    articleAfriqueFunc();
    articleInternationalFunc();
    allArticles();
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
