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
          final exception = details.exception;
          final errorString = exception?.toString() ?? 'null';

          // Certains messages générés par l'infrastructure web/debug peuvent
          // être bruyants mais inoffensifs. On ignore uniquement les cas
          // clairement non-critiques (ex: erreur "Cannot send Null") tout en
          // laissant remonter les erreurs du DebugService pour pouvoir les
          // corriger si nécessaire.
          if (errorString.contains('Cannot send Null') ||
              errorString.contains('LegacyJavaScriptObject')) {
            // Journaliser en debug et ignorer le bruit non critique
            if (kDebugMode) {
              // ignore: avoid_print
              print('Ignored benign web error: $errorString');
            }
            return;
          }

          // Pour toutes les autres erreurs, utiliser le handler par défaut afin
          // de conserver le comportement standard (affichage en debug, crash en
          // release si nécessaire).
          FlutterError.presentError(details);
        } catch (e) {
          // En cas d'erreur dans le handler, journaliser en debug puis abandonner
          if (kDebugMode) {
            // ignore: avoid_print
            print('WebErrorHandler failed: $e');
          }
          return;
        }
      };
    }
  }
}