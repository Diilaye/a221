import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/date-showing-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:js' as js;

class ArticleLesPlusLue extends StatefulWidget {
  final int nombre;
  final ArticlesModel? article;
  
  const ArticleLesPlusLue({
    super.key, 
    required this.nombre, 
    this.article
  });

  @override
  State<ArticleLesPlusLue> createState() => _ArticleLesPlusLueState();
}

class _ArticleLesPlusLueState extends State<ArticleLesPlusLue> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.article != null ? () {
            homeUtilisateurBloc.setAticle(widget.article!);
            js.context.callMethod(
              'open',
              ['https://a221.net/article/${widget.article!.slug!}', '_self']
            );
          } : null,
          onHover: (value) => setState(() => _isHovered = value),
          borderRadius: BorderRadius.circular(8),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _isHovered ? Colors.grey.shade50 : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: rouge.withOpacity(_isHovered ? 0.15 : 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    '${widget.nombre}',
                    style: fontFammilyDii(
                      context,
                      16,
                      rouge,
                      FontWeight.bold,
                      FontStyle.normal,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.article?.titre ?? 'Article non disponible',
                        style: fontFammilyDii(
                          context,
                          14,
                          noir,
                          FontWeight.w600,
                          FontStyle.normal,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (widget.article?.date != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          'Daté le ${showDate(widget.article!.date!)}',
                          style: fontFammilyDii(
                            context,
                            12,
                            Colors.grey[600]!,
                            FontWeight.normal,
                            FontStyle.normal,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}