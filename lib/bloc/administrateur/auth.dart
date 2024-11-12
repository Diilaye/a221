import 'package:actu/services/auth-service.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class ConnexionBloc with ChangeNotifier {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  AuthService authService = AuthService();

  bool showPassword = true;
  bool mailling = true;
  bool infoPartenaire = true;

  setShowPassword() {
    showPassword = !showPassword;
    notifyListeners();
  }

  setMailling() {
    mailling = !mailling;
    notifyListeners();
  }

  setInfoPartenaire() {
    infoPartenaire = !infoPartenaire;
    notifyListeners();
  }

  bool chargement = false;

  String? resultRegister;

  login(BuildContext context) async {
    Map<String, String> body = {"email": email.text, "password": password.text};

    chargement = true;
    notifyListeners();

    resultRegister = await authService.auth(body);

    chargement = false;
    notifyListeners();

    if (resultRegister != null) {
      email.text = "";
      // resultRegister = null;
      password.text = "";
      notifyListeners();

      Fluttertoast.showToast(
          msg: "Connexion réussi.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: vert,
          textColor: Colors.white,
          fontSize: 12.0);
      context.go('/login');
    } else {
      Fluttertoast.showToast(
          msg: "Probleme de connexion identifiant incorrect",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: rouge,
          textColor: Colors.white,
          fontSize: 12.0);
    }
  }

  register() async {
    Map<String, String> body = {"email": email.text, "password": password.text};

    chargement = true;
    notifyListeners();

    resultRegister = await authService.add(body);

    chargement = false;
    notifyListeners();

    if (resultRegister != null) {
      email.text = "";
      // resultRegister = null;
      password.text = "";
      notifyListeners();
      Fluttertoast.showToast(
          msg: "Création de compte réussi.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: rouge,
          textColor: Colors.white,
          fontSize: 12.0);
    } else {
      Fluttertoast.showToast(
          msg: "Probleme survenue",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: rouge,
          textColor: Colors.white,
          fontSize: 12.0);
    }
  }
}
