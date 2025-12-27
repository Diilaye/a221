import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LaUneArticle extends StatelessWidget {
  final String rubrique, date, titre;
  final Color color;
  final bool isActif;
  final int i;
  const LaUneArticle(
      {super.key,
      required this.rubrique,
      required this.date,
      required this.titre,
      required this.color,
      required this.isActif,
      required this.i});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context, listen: false);
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              homeUtilisateurBloc.setTopClick(i);
              homeUtilisateurBloc.setAticle(homeUtilisateurBloc.uneArticle!);
            },
            child: AnimatedContainer(
              key: ValueKey('article_$i'),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: isActif ? color.withOpacity(0.05) : blanc,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isActif ? color.withOpacity(0.3) : Colors.grey.shade200,
                  width: isActif ? 2 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: isActif ? 12 : 4,
                    offset: Offset(0, isActif ? 6 : 2),
                    color: isActif 
                      ? color.withOpacity(0.2)
                      : Colors.black.withOpacity(0.1),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Row(
                  children: [
                    // Indicateur de couleur de catégorie
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: isActif ? 6 : 4,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            color,
                            color.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // En-tête avec rubrique et date
                            Row(
                              children: [
                                Flexible(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: color.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: color.withOpacity(0.3), width: 0.5),
                                    ),
                                    child: Text(
                                      rubrique.toUpperCase(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: fontFammilyDii(context, 9, color,
                                          FontWeight.bold, FontStyle.normal),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    date,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: fontFammilyDii(context, 8, Colors.grey.shade600,
                                        FontWeight.w400, FontStyle.normal),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            // Titre principal
                            Expanded(
                              child: Text(
                                titre,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4, // Augmenté pour utiliser plus d'espace vertical
                                textAlign: TextAlign.left,
                                style: fontFammilyDii(
                                  context,
                                  isActif ? 13 : 12,
                                  isActif ? color.withOpacity(0.9) : noir,
                                  FontWeight.w600,
                                  FontStyle.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Indicateur d'article actif
                    if (isActif)
                      Container(
                        width: 3,
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
