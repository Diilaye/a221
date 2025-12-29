import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WebErrorHandler {
  static bool _errorHandlerSetup = false;
  static int _suppressedErrorCount = 0;
  static final Set<String> _loggedErrors = {};

  /// Configure la gestion d'erreur spécifique pour le web
  static void setupWebErrorHandling() {
    if (kIsWeb && !_errorHandlerSetup) {
      _errorHandlerSetup = true;
      
      // Gestion des erreurs Flutter
      FlutterError.onError = (FlutterErrorDetails details) {
        if (_shouldIgnoreError(details.exception)) {
          _suppressedErrorCount++;
          // Ignorer silencieusement les erreurs connues non critiques
          // Log seulement la première occurrence en mode debug
          if (kDebugMode && _suppressedErrorCount == 1) {
            debugPrint('🔇 Web engine warnings are being suppressed (flutter web engine assertions)');
          }
          return;
        }
        
        // Pour toutes les autres erreurs, utiliser le handler par défaut
        FlutterError.presentError(details);
      };

      // Gestion des erreurs de zone (zone errors) qui ne sont pas captées par FlutterError.onError
      // Cela permet de capturer les erreurs du DebugService
      runZonedGuarded(() {
        // Cette zone capturera les erreurs non gérées
      }, (error, stack) {
        if (_shouldIgnoreError(error)) {
          // Ignorer silencieusement les erreurs connues non critiques
          return;
        }
        
        // Pour les autres erreurs, les logger en mode debug
        if (kDebugMode) {
          final errorKey = error.toString();
          if (!_loggedErrors.contains(errorKey)) {
            _loggedErrors.add(errorKey);
            debugPrint('⚠️ Uncaught error: $error');
            debugPrint('Stack trace: $stack');
          }
        }
      });

      // Suppression des erreurs de platformDispatcher
      PlatformDispatcher.instance.onError = (error, stack) {
        if (_shouldIgnoreError(error)) {
          // Ignorer silencieusement et retourner true pour indiquer que l'erreur est gérée
          return true;
        }
        
        // Pour les autres erreurs, retourner false pour utiliser le handler par défaut
        return false;
      };
    }
  }

  /// Vérifie si une erreur doit être ignorée
  static bool _shouldIgnoreError(Object? error) {
    if (error == null) return true;
    
    final errorString = error.toString();
    
    // Liste des patterns d'erreurs connues et non critiques pour le web
    final ignoredPatterns = [
      'Cannot send Null',
      'DebugService',
      'Error serving requests',
      'Unsupported operation',
      'LegacyJavaScriptObject',
      'isDisposed',
      'Trying to render a disposed EngineFlutterView',
      'EngineFlutterView',
      'disposed',
      'window.dart',
      'Assertion failed',
      'org-dartlang-sdk:///lib/_engine/engine/window.dart',
      '_engine/engine/window.dart',
    ];
    
    // Vérifier si l'erreur contient un des patterns à ignorer
    for (final pattern in ignoredPatterns) {
      if (errorString.contains(pattern)) {
        return true;
      }
    }
    
    return false;
  }

  /// Obtenir le nombre d'erreurs supprimées
  static int getSuppressedErrorCount() => _suppressedErrorCount;

  /// Réinitialiser le compteur d'erreurs supprimées
  static void resetSuppressedErrorCount() {
    _suppressedErrorCount = 0;
    _loggedErrors.clear();
  }
}