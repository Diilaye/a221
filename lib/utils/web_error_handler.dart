import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WebErrorHandler {
  static bool _errorHandlerSetup = false;

  /// Configure la gestion d'erreur spécifique pour le web
  static void setupWebErrorHandling() {
    if (kIsWeb && !_errorHandlerSetup) {
      _errorHandlerSetup = true;
      
      // Configuration très simple sans traitement complexe
      FlutterError.onError = (FlutterErrorDetails details) {
        try {
          // Ne faire aucun traitement complexe sur les détails de l'erreur
          final errorString = details.exception.toString();
          
          // Filtrage simple basé uniquement sur le message d'exception
          if (errorString.contains('Cannot send Null') ||
              errorString.contains('LegacyJavaScriptObject') ||
              errorString.contains('DebugService')) {
            // Ignorer silencieusement ces erreurs
            return;
          }
          
          // Pour les autres erreurs, utiliser le handler par défaut
          FlutterError.presentError(details);
        } catch (e) {
          // Si notre handler échoue, ne rien faire pour éviter les boucles
          return;
        }
      };
    }
  }
}