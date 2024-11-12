import 'package:actu/models/administrateur/post-digiteaux-model.dart';
import 'package:actu/services/utilisateur/home-service.dart';
import 'package:flutter/material.dart';

class PostsDigiteauxUserBloc with ChangeNotifier {
  HomeService homeService = HomeService();

  List<PostsDigiteauxModel> listePosts = [];

  allPosts() async {
    listePosts = await homeService.allPostDigiteaux();
    notifyListeners();
  }

  PostsDigiteauxUserBloc() {
    allPosts();
  }
}
