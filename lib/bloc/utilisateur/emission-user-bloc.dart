import 'package:actu/models/administrateur/emission-model.dart';
import 'package:actu/services/utilisateur/home-service.dart';
import 'package:flutter/material.dart';

class EmissionUserBloc with ChangeNotifier {
  HomeService homeService = HomeService();

  List<EmissionModel> emissions = [];
  EmissionModel? inviteEmission;
  EmissionModel? suivreEmission;
  allEmissions() async {
    emissions = await homeService.allEmission();
    inviteEmission = emissions.lastWhere((e) => e.type == "invite");
    suivreEmission = emissions.lastWhere((e) => e.type == "suivre");
    notifyListeners();
  }

  EmissionUserBloc() {
    allEmissions();
  }
}
