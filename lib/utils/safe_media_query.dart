import 'package:flutter/material.dart';

/// Helper pour accéder à MediaQuery de manière sécurisée sur le web
class SafeMediaQuery {
  /// Récupère la taille de l'écran de manière sécurisée
  static Size getSafeSize(BuildContext context) {
    try {
      return MediaQuery.of(context).size;
    } catch (e) {
      // Si MediaQuery n'est pas disponible, retourner une taille par défaut
      return const Size(1024, 768);
    }
  }

  /// Récupère les données MediaQuery de manière sécurisée
  static MediaQueryData getSafeMediaQuery(BuildContext context) {
    try {
      return MediaQuery.of(context);
    } catch (e) {
      // Retourner des données par défaut
      return const MediaQueryData();
    }
  }

  /// Vérifie si MediaQuery est disponible
  static bool isMediaQueryAvailable(BuildContext context) {
    try {
      MediaQuery.of(context);
      return true;
    } catch (e) {
      return false;
    }
  }
}
