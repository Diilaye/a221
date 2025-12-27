import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/screen/utilisateur/widget/section-article/section-article-ternaire.dart';
import 'package:actu/screen/utilisateur/widget/section-article/section-dossier-redaction-widget.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/responsive-ui.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionChoixRedacWidget extends StatefulWidget {
  const SectionChoixRedacWidget({super.key});

  @override
  State<SectionChoixRedacWidget> createState() => _SectionChoixRedacWidgetState();
}

class _SectionChoixRedacWidgetState extends State<SectionChoixRedacWidget> {
  int _hoveredIndex = -1;

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return Center(
      child: Container(
        height: 500,
        width: 1024,
        margin: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: gris.withOpacity(0.95),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: noir.withOpacity(0.1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                "à venir".toUpperCase(),
                style: fontFammilyDii(
                  context,
                  28,
                  noir,
                  FontWeight.bold,
                  FontStyle.normal
                ),
              ),
            ),
            const SizedBox(height: 32),
            if (homeUtilisateurBloc.articleChoixRedac.isEmpty)
              const SizedBox()
            else
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: List.generate(
                      3,
                      (index) => Expanded(
                        child: MouseRegion(
                          onEnter: (_) => setState(() => _hoveredIndex = index),
                          onExit: (_) => setState(() => _hoveredIndex = -1),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: noir.withOpacity(_hoveredIndex == index ? 0.15 : 0.08),
                                  blurRadius: _hoveredIndex == index ? 20 : 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(2),
                              child: SectionDossierRedactionWidget(
                                articles: homeUtilisateurBloc.articleChoixRedac[index],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
