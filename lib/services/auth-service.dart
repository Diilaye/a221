import 'package:actu/models/administrateur/user-model.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<String?> add(Map<String, dynamic> body) async {
    return await postResponse(url: '/users/client', body: body)
        .then((value) async {
      if (value['status'] == 201) {
        await SharedPreferences.getInstance().then((prefs) {
          prefs.setString('token', value['body']['data']['token']);
        });
        return "ajout réussi";
      } else {
        return null;
      }
    });
  }

  Future<String?> addAdmin(Map<String, dynamic> body) async {
    return await postResponse(url: '/users', body: body).then((value) async {
      if (value['status'] == 201) {
        return "ajout réussi";
      } else {
        return null;
      }
    });
  }

  Future<String?> updateAdmin(Map<String, dynamic> body, String id) async {
    return await putResponse(url: '/users/$id', body: body).then((value) async {
      if (value['status'] == 200) {
        return "ajout réussi";
      } else {
        return null;
      }
    });
  }

  Future<String?> auth(Map<String, dynamic> body) async {
    return await postResponse(url: '/users/auth', body: body)
        .then((value) async {
      if (value['status'] == 200) {
        print(value['body']['data']['service']);
        await SharedPreferences.getInstance().then((prefs) {
          prefs.setString('token', value['body']['data']['token']);
          prefs.setString('role', value['body']['data']['service']);
        });
        return "Connexion réussi";
      } else {
        return null;
      }
    });
  }

  Future<UserModel?> getAuth() async {
    return await getResponse(url: '/users/auth').then((value) async {
      if (value['status'] == 200) {
        return UserModel.fromJson(value['body']['data']);
      } else {
        return null;
      }
    });
  }

  Future<List<UserModel>> all() async {
    return await getResponse(url: '/users').then((value) async {
      if (value['status'] == 200) {
        return UserModel.fromList(data: value['body']['data']);
      } else {
        return [];
      }
    });
  }
}
