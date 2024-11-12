import 'package:actu/models/administrateur/journal-papier-model.dart';
import 'package:actu/services/utilisateur/home-service.dart';
import 'package:flutter/material.dart';

class PapierJournalUserBloc with ChangeNotifier {
  HomeService homeService = HomeService();

  List<PapierJournalModel> papierJournals = [];

  allPapier() async {
    papierJournals = await homeService.allPapierJournal();
    notifyListeners();
  }

  PapierJournalUserBloc() {
    allPapier();
  }
}
