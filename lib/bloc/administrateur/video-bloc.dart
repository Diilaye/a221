import 'package:actu/models/administrateur/file-model.dart';
import 'package:actu/models/administrateur/video-youtube-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/file-picker-dii.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../services/administrateur/video-youtube-service.dart';

class VideoBloc with ChangeNotifier {
  VideoYoutubeService videosService = VideoYoutubeService();

  List<dynamic> imagePost = [null, null];

  int showUpdate = 0;

  setShowUpdate(int i) {
    showUpdate = i;
    notifyListeners();
  }

  int parcourirFile = 0;

  FileModel? fileModel;

  List<FileModel> filesModel = [];
  
  List<VideoYoutubeModel> videos = [];
  
  VideoYoutubeModel? selectedVideo;

  String recherche = "";

  setRecherche(String r) {
    recherche = r;
    notifyListeners();
  }

  allFileModel() async {
    filesModel = await videosService.allFile();
    notifyListeners();
  }

  setParcourirFile(int i) {
    parcourirFile = i;
    notifyListeners();
  }

  setFileModel(FileModel? f) {
    try {
      if (fileModel == f) {
        fileModel = null;
      } else {
        fileModel = f;
      }
      notifyListeners();
    } catch (e) {
      print('Erreur lors de la définition du modèle de fichier: $e');
    }
  }

  getImagePost() async {
    imagePost = await getImage(0);
    notifyListeners();
  }

  getImagePostUpdate() async {
    try {
      // Implémentation pour la mise à jour d'image si nécessaire
      // imagePost = await getImageUpdate(0, selectedVideo?.imageFile?.id);
      notifyListeners();
    } catch (e) {
      print('Erreur lors de la mise à jour de l\'image: $e');
    }
  }

  TextEditingController titre = TextEditingController();
  TextEditingController emission = TextEditingController();
  TextEditingController url = TextEditingController();
  int type = 0;

  setType(int i) {
    type = i;
    notifyListeners();
  }

  bool chargement = false;

  addVideo() async {
    chargement = true;
    notifyListeners();

    try {
      Map<String, dynamic> videoData = {
        "isLive": type == 0 ? 'off' : 'on',
        "titre": titre.text.trim(),
        "emission": emission.text.trim(),
        "url": url.text.trim(),
        "image": fileModel?.id ?? imagePost[0],
      };

      String? result = await videosService.add(videoData);

      if (result != null) {
        Fluttertoast.showToast(
            msg: "Vidéo ajoutée avec succès.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: vert,
            textColor: Colors.white,
            fontSize: 12.0);
        _clearForm();
        await allVideo();
      } else {
        _showErrorToast("Erreur lors de l'ajout de la vidéo.");
      }
    } catch (e) {
      print('Erreur lors de l\'ajout de la vidéo: $e');
      _showErrorToast("Une erreur inattendue s'est produite.");
    }
    
    chargement = false;
    notifyListeners();
  }

  updateVideo() async {
    if (selectedVideo == null) return;
    
    chargement = true;
    notifyListeners();

    try {
      Map<String, dynamic> videoData = {
        "isLive": type == 0 ? 'off' : 'on',
        "titre": titre.text.trim(),
        "emission": emission.text.trim(),
        "url": url.text.trim(),
        "image": fileModel?.id ?? imagePost[0],
      };

      String? result = await videosService.update(videoData, selectedVideo!.id!);

      if (result != null) {
        Fluttertoast.showToast(
            msg: "Vidéo modifiée avec succès.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: vert,
            textColor: Colors.white,
            fontSize: 12.0);
        _clearForm();
        await allVideo();
        showUpdate = 0;
      } else {
        _showErrorToast("Erreur lors de la modification de la vidéo.");
      }
    } catch (e) {
      print('Erreur lors de la modification de la vidéo: $e');
      _showErrorToast("Une erreur inattendue s'est produite.");
    }
    
    chargement = false;
    notifyListeners();
  }

  toggleVideoStatus() async {
    if (selectedVideo == null) return;
    
    chargement = true;
    notifyListeners();

    try {
      String newStatus = selectedVideo!.statusOnline == "on" ? "off" : "on";
      
      String? result = await videosService.update(
          {"statusOnline": newStatus},
          selectedVideo!.id!);

      if (result != null) {
        Fluttertoast.showToast(
            msg: "Statut de la vidéo modifié avec succès.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: vert,
            textColor: Colors.white,
            fontSize: 12.0);
        await allVideo();
        showUpdate = 0;
      } else {
        _showErrorToast("Erreur lors de la modification du statut.");
      }
    } catch (e) {
      print('Erreur lors de la modification du statut de la vidéo: $e');
      _showErrorToast("Une erreur inattendue s'est produite.");
    }
    
    chargement = false;
    notifyListeners();
  }

  setSelectedVideo(VideoYoutubeModel? video) {
    try {
      selectedVideo = video;
      if (video != null) {
        titre.text = video.titre ?? '';
        emission.text = video.emission ?? '';
        url.text = video.url ?? '';
        type = video.isLive == 'on' ? 1 : 0;
        if (video.imageFile != null) {
          imagePost = [
            video.imageFile!.id,
            video.imageFile!.url
          ];
        }
      }
      fileModel = null;
      notifyListeners();
    } catch (e) {
      print('Erreur lors de la sélection de la vidéo: $e');
    }
  }

  allVideo() async {
    try {
      videos = await videosService.all();
      notifyListeners();
    } catch (e) {
      print('Erreur lors du chargement des vidéos: $e');
    }
  }

  // Méthodes utilitaires privées
  void _clearForm() {
    titre.clear();
    emission.clear();
    url.clear();
    type = 0;
    fileModel = null;
    selectedVideo = null;
    imagePost = [null, null];
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: rouge,
        textColor: Colors.white,
        fontSize: 12.0);
  }

  VideoBloc() {
    _initializeBloc();
  }
  
  void _initializeBloc() async {
    try {
      await allVideo();
      await allFileModel();
    } catch (e) {
      print('Erreur lors de l\'initialisation du VideoBloc: $e');
    }
  }
}
