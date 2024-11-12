import 'package:actu/models/administrateur/user-model.dart';
import 'package:actu/services/auth-service.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserBloc with ChangeNotifier {
  AuthService authService = AuthService();

  TextEditingController nom = TextEditingController();
  TextEditingController prenom = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController telephone = TextEditingController();

  String role = '';

  int showUpdate = 0;

  setShowUpate(int i) {
    showUpdate = i;
    notifyListeners();
  }

  setRole(String j) {
    role = j;
    notifyListeners();
  }

  List<UserModel> users = [];
  UserModel? user;

  setUser(UserModel? u) {
    user = u;
    nom.text = u!.nom!;
    prenom.text = u.prenom!;
    email.text = u.email!;
    telephone.text = u.telephone!;
    role = u.service!;
    notifyListeners();
  }

  allUsers() async {
    users = await authService.all();
    notifyListeners();
  }

  bool chargement = false;

  UserBloc() {
    allUsers();
  }

  addUser() async {
    chargement = true;
    notifyListeners();

    Map<String, dynamic> body = {
      "service": role,
      "nom": nom.text,
      "prenom": prenom.text,
      "telephone": telephone.text,
      "email": email.text,
      "password": "Actu221Yu",
    };

    print("addUser()");
    print(body);

    String? result = await authService.addAdmin(body);

    if (result != null) {
      Fluttertoast.showToast(
          msg: "Utilisateur ajoutée avec success.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: vert,
          textColor: Colors.white,
          fontSize: 12.0);
      await allUsers();
      nom.text = "";
      prenom.text = "";
      email.text = "";
      telephone.text = "";
      role = "";
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

  updateUser() async {
    chargement = true;
    notifyListeners();

    Map<String, dynamic> body = {
      "service": role,
      "nom": nom.text,
      "prenom": prenom.text,
      "telephone": telephone.text,
      "email": email.text,
      "password": "Actu221Yu",
    };

    String? result = await authService.updateAdmin(body, user!.id!);

    if (result != null) {
      Fluttertoast.showToast(
          msg: "Utilisateur modifier avec success.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: vert,
          textColor: Colors.white,
          fontSize: 12.0);
      await allUsers();
      nom.text = "";
      prenom.text = "";
      email.text = "";
      telephone.text = "";
      role = "";
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

  activeUser() async {
    chargement = true;
    notifyListeners();

    Map<String, dynamic> body = {
      "statusOnline": user!.statusOnline! == "on" ? "off" : "on",
    };

    String? result = await authService.updateAdmin(body, user!.id!);

    if (result != null) {
      Fluttertoast.showToast(
          msg: "Utilisateur modifier avec success.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: vert,
          textColor: Colors.white,
          fontSize: 12.0);
      await allUsers();
      nom.text = "";
      prenom.text = "";
      email.text = "";
      telephone.text = "";
      role = "";
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
}
