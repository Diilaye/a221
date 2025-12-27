import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/screen/utilisateur/widget/section-article/section-article-ternaire.dart';
import 'package:actu/screen/utilisateur/widget/section-article/section-une-ternaire-widget.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SectionEconomiqueWidget extends StatefulWidget {
  const SectionEconomiqueWidget({super.key});

  @override
  State<SectionEconomiqueWidget> createState() => _SectionEconomiqueWidgetState();
}

class _SectionEconomiqueWidgetState extends State<SectionEconomiqueWidget> {
 
  bool _isHovered = false;

  
  void _handleHover(bool value) {
    setState(() {
      _isHovered = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return homeUtilisateurBloc.articleEconomies.isEmpty
        ? const SizedBox()
        : Container(
            width: 1200,
            height: 600,
            margin: const EdgeInsets.symmetric(vertical: 32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Colors.grey.shade50,
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  spreadRadius: 0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: MouseRegion(
              onEnter: (_) => _handleHover(true),
              onExit: (_) => _handleHover(false),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.shade200,
                          width: _isHovered ? 2 : 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: rouge.withOpacity(_isHovered ? 0.15 : 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.trending_up,
                            color: rouge,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          'économie'.toUpperCase(),
                          style: fontFammilyDii(
                            context,
                            28,
                            noir,
                            FontWeight.bold,
                            FontStyle.normal,
                          ),
                        ),
                        const Spacer(),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () async {
                              await homeUtilisateurBloc.setCatMenu(
                                homeUtilisateurBloc.categories.firstWhere(
                                  (e) => e.titre! == "ECONOMIE",
                                ),
                              );
                              if (!context.mounted) return;
                              context.go(
                                '/categorie/${homeUtilisateurBloc.articleEconomies.first.categorie!.slug!.toLowerCase()}',
                              );
                              await homeUtilisateurBloc.setCategorieMenu();
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: rouge.withOpacity(_isHovered ? 0.15 : 0.1),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'voir plus'.toUpperCase(),
                                    style: fontFammilyDii(
                                      context,
                                      14,
                                      rouge,
                                      FontWeight.bold,
                                      FontStyle.normal,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: rouge,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                for (var i = 0; i < 4; i++) ...[
                                  if (i > 0) const SizedBox(height: 16),
                                  SectionArticleTernaireWidget(
                                    articlesModel:
                                        homeUtilisateurBloc.articleEconomies[i],
                                    sizeTags: 13,
                                    sizeTitle: 15,
                                  ),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(width: 24),
                          if (homeUtilisateurBloc.uneEconomie != null)
                            Expanded(
                              flex: 2,
                              child: Container(
                                constraints: const BoxConstraints(maxHeight: 520),
                                child: SectionUneTernaireWidget(
                                  article: homeUtilisateurBloc.uneEconomie!,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}