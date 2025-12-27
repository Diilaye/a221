import 'package:actu/bloc/administrateur/article-bloc.dart';
import 'package:actu/bloc/administrateur/auth.dart';
import 'package:actu/bloc/administrateur/categorie-bloc.dart';
import 'package:actu/bloc/administrateur/emission-bloc.dart';
import 'package:actu/bloc/administrateur/flash-news-bloc.dart';
import 'package:actu/bloc/administrateur/journal-papier-bloc.dart';
import 'package:actu/bloc/administrateur/menu-admin.dart';
import 'package:actu/bloc/administrateur/mot-cles-bloc.dart';
import 'package:actu/bloc/administrateur/post-digiteaux-bloc.dart';
import 'package:actu/bloc/administrateur/sous-categorie-bloc.dart';
import 'package:actu/bloc/administrateur/tags-bloc.dart';
import 'package:actu/bloc/administrateur/user-bloc.dart';
import 'package:actu/bloc/utilisateur/emission-user-bloc.dart';
import 'package:actu/bloc/utilisateur/flash-news-bloc.dart';
import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/bloc/utilisateur/papier-journal-bloc.dart';
import 'package:actu/bloc/utilisateur/posts-digiteaux.dart';
import 'package:actu/bloc/live-feed-bloc.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/adminisatrateur-screen.dart';
import 'package:actu/screen/adminnistrateur/pages/connection-screen.dart';
import 'package:actu/screen/adminnistrateur/pages/register-screen.dart';
import 'package:actu/screen/infographie/pages/infographie-dashbord.dart';
import 'package:actu/screen/journalistes/page/journaliste-dashbord.dart';
import 'package:actu/screen/redacteur/page/redacteur-dashbord.dart';
import 'package:actu/screen/utilisateur/pages/article-screen.dart';
import 'package:actu/screen/utilisateur/pages/categorie-home.dart';
import 'package:actu/screen/utilisateur/pages/home-screen.dart';
import 'package:actu/screen/utilisateur/pages/mobiles/article-recents-screen.dart';
import 'package:actu/screen/utilisateur/pages/tag-screen.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      name: 'categorie',
      path: '/categorie/:categorieSlug',
      builder: (context, state) {
        final categorieSlug = state.pathParameters['categorieSlug']!;

        return FutureBuilder(
          future: context
              .read<HomeUtilisateurBloc>()
              .setCategorieMenuIndex(categorieSlug),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              return const Scaffold(
                body: Center(
                    child: Text('Erreur lors du chargement de la catégorie')),
              );
            } else {
              return const CategorieHome();
            }
          },
        );
      },
    ),
    GoRoute(
      name: 'tag',
      path: '/tag/:tagSlug',
      builder: (context, state) {
        final tagSlug = state.pathParameters['tagSlug']!;

        return FutureBuilder(
          future: context.read<HomeUtilisateurBloc>().setTagsMenuIndex(tagSlug),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              return const Scaffold(
                body:
                    Center(child: Text('Erreur lors du chargement de la tag')),
              );
            } else {
              return const TagHomeScreen();
            }
          },
        );
      },
    ),
    GoRoute(
      name: 'article',
      path: '/article/:articleSlug',
      builder: (context, state) {
        final articleSlug = state.pathParameters['articleSlug']!;

        return FutureBuilder(
          future:
              context.read<HomeUtilisateurBloc>().setAticleSlug(articleSlug),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              return const Scaffold(
                body: Center(
                    child: Text('Erreur lors du chargement de l\'article')),
              );
            } else {
              return const ArticleScreen();
            }
          },
        );
      },
    ),
    GoRoute(
      path: '/login',
      redirect: (context, state) async {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();

        if (sharedPreferences.getString("token") != "" &&
            sharedPreferences.containsKey("token")) {
          if (sharedPreferences.getString("role") == "administrateur" &&
              sharedPreferences.containsKey("role")) {
            return "/administratif";
          } else if (sharedPreferences.getString("role") == "redacteur" &&
              sharedPreferences.containsKey("role")) {
            return "/redacteur";
          } else if (sharedPreferences.getString("role") == "journaliste" &&
              sharedPreferences.containsKey("role")) {
            return "/journaliste";
          } else if (sharedPreferences.getString("role") == "infographie" &&
              sharedPreferences.containsKey("role")) {
            return "/infographie";
          }
        } else {
          return '/login';
        }
        return null;
      },
      builder: (context, state) => const ConnectionScreen(),
    ),
    GoRoute(
      path: '/register',
      redirect: (context, state) async {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();

        if (sharedPreferences.getString("token") != "" &&
            sharedPreferences.containsKey("token")) {
          return "/";
        } else {
          return '/register';
        }
      },
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeUtilisateurScreen(),
    ),
    GoRoute(
      path: '/administratif',
      builder: (context, state) => const AdministrateurAscreen(),
    ),
    GoRoute(
      path: '/infographie',
      builder: (context, state) => const InfographieDashbordAscreen(),
    ),
    GoRoute(
      path: '/journaliste',
      builder: (context, state) => const JournalisteScreen(),
    ),
    GoRoute(
      path: '/redacteur',
      builder: (context, state) => const RedacteurScreen(),
    ),
    GoRoute(
      path: '/recent',
      builder: (context, state) => const ArticleRecentScreen(),
    ),
  ],
);
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  setUrlStrategy(PathUrlStrategy());

  // Gestion simple des erreurs web sans traitement complexe
  if (kIsWeb) {
    FlutterError.onError = (details) {
      // Ignorer complètement les erreurs web communes
      final error = details.exception.toString();
      if (error.contains('Cannot send Null') || 
          error.contains('LegacyJavaScriptObject') ||
          error.contains('DebugService')) {
        return; // Ne rien faire
      }
      // Laisser les autres erreurs passer par le système par défaut
      FlutterError.presentError(details);
    };
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeUtilisateurBloc()),
        ChangeNotifierProvider(create: (_) => ConnexionBloc()),
        ChangeNotifierProvider(create: (_) => MenuAdminBloc()),
        ChangeNotifierProvider(create: (_) => AddArticleBloc()),
        ChangeNotifierProvider(create: (_) => CategorieBloc()),
        ChangeNotifierProvider(create: (_) => SousCategorieBloc()),
        ChangeNotifierProvider(create: (_) => TagsBloc()),
        ChangeNotifierProvider(create: (_) => MotsClesBloc()),
        ChangeNotifierProvider(create: (_) => FlashNewsBloc()),
        ChangeNotifierProvider(create: (_) => LiveFeedBloc()),
        ChangeNotifierProvider(create: (_) => FlashNewsUserBloc()),
        ChangeNotifierProvider(create: (_) => PostsDigiteauxBloc()),
        ChangeNotifierProvider(create: (_) => PostsDigiteauxUserBloc()),
        ChangeNotifierProvider(create: (_) => JourPapierBloc()),
        ChangeNotifierProvider(create: (_) => PapierJournalUserBloc()),
        ChangeNotifierProvider(create: (_) => EmissionBloc()),
        ChangeNotifierProvider(create: (_) => EmissionUserBloc()),
        ChangeNotifierProvider(create: (_) => UserBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: "ACTU221 | L'essentiel de l'information",
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('fr')],
        theme: ThemeData(
            colorScheme:
                ColorScheme.fromSwatch(primarySwatch: createMaterialColor(noir))
                    .copyWith(background: blanc)),
        routerConfig: _router);
  }
}
