import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:js' as js;

class SectionCategoryCard extends StatefulWidget {
  final List<ArticlesModel> articles;
  final String title;
  final IconData icon;
  final Color primaryColor;
  
  const SectionCategoryCard({
    super.key,
    required this.articles,
    required this.title,
    required this.icon,
    this.primaryColor = const Color(0xFFE31E24),
  });

  @override
  State<SectionCategoryCard> createState() => _SectionCategoryCardState();
}

class _SectionCategoryCardState extends State<SectionCategoryCard> {
  int _hoveredIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      height: 650,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.grey.shade50,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: noir.withOpacity(0.08),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header stylisé
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  widget.primaryColor.withOpacity(0.1),
                  widget.primaryColor.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: widget.primaryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    widget.icon,
                    color: widget.primaryColor,
                    size: 20,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.title.toUpperCase(),
                    style: fontFammilyDii(
                      context,
                      16,
                      noir,
                      FontWeight.w900,
                      FontStyle.normal,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: widget.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    size: 14,
                    color: blanc,
                  ),
                ),
              ],
            ),
          ),
          
          // Article principal avec image
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  // Grande carte principale
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onEnter: (_) => setState(() => _hoveredIndex = 0),
                    onExit: (_) => setState(() => _hoveredIndex = -1),
                    child: GestureDetector(
                      onTap: () {
                        js.context.callMethod('open', [
                          'https://a221.net/article/${widget.articles[0].slug!}'
                        ]);
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: 260,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: _hoveredIndex == 0
                                  ? widget.primaryColor.withOpacity(0.3)
                                  : noir.withOpacity(0.1),
                              blurRadius: _hoveredIndex == 0 ? 20 : 10,
                              offset: Offset(0, _hoveredIndex == 0 ? 8 : 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              // Image avec effet de zoom
                              AnimatedScale(
                                scale: _hoveredIndex == 0 ? 1.05 : 1.0,
                                duration: Duration(milliseconds: 500),
                                child: widget.articles[0].imageArticle?.url != null
                                    ? Image.network(
                                        BASE_URL_ASSET + widget.articles[0].imageArticle!.url!,
                                        fit: BoxFit.cover,
                                      )
                                    : Container(
                                        color: Colors.grey.shade300,
                                        child: Icon(
                                          CupertinoIcons.photo,
                                          size: 50,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                              ),
                              // Gradient overlay
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      noir.withOpacity(0.85),
                                    ],
                                  ),
                                ),
                              ),
                              // Badge catégorie
                              Positioned(
                                top: 12,
                                left: 12,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: widget.primaryColor.withOpacity(0.95),
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: widget.primaryColor.withOpacity(0.4),
                                        blurRadius: 8,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        CupertinoIcons.tag_fill,
                                        color: blanc,
                                        size: 12,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        widget.articles[0].tags?.titre?.toUpperCase() ?? widget.title.toUpperCase(),
                                        style: fontFammilyDii(
                                          context,
                                          10,
                                          blanc,
                                          FontWeight.w700,
                                          FontStyle.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Titre et icône
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.articles[0].titre ?? '',
                                        style: fontFammilyDii(
                                          context,
                                          15,
                                          blanc,
                                          FontWeight.w700,
                                          FontStyle.normal,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      if (_hoveredIndex == 0) ...[
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Icon(
                                              CupertinoIcons.arrow_right_circle_fill,
                                              color: widget.primaryColor,
                                              size: 18,
                                            ),
                                            SizedBox(width: 6),
                                            Text(
                                              'Lire l\'article',
                                              style: fontFammilyDii(
                                                context,
                                                12,
                                                blanc,
                                                FontWeight.w600,
                                                FontStyle.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  paddingVerticalGlobal(12),
                  
                  // Liste des articles secondaires
                  ...List.generate(
                    widget.articles.length > 4 ? 3 : widget.articles.length - 1,
                    (index) {
                      final article = widget.articles[index + 1];
                      final itemIndex = index + 1;
                      
                      return MouseRegion(
                        cursor: SystemMouseCursors.click,
                        onEnter: (_) => setState(() => _hoveredIndex = itemIndex),
                        onExit: (_) => setState(() => _hoveredIndex = -1),
                        child: GestureDetector(
                          onTap: () {
                            js.context.callMethod('open', [
                              'https://a221.net/article/${article.slug!}'
                            ]);
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            margin: EdgeInsets.only(bottom: 8),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: _hoveredIndex == itemIndex
                                  ? widget.primaryColor.withOpacity(0.05)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: _hoveredIndex == itemIndex
                                    ? widget.primaryColor.withOpacity(0.3)
                                    : Colors.grey.shade200,
                                width: 1,
                              ),
                              boxShadow: [
                                if (_hoveredIndex == itemIndex)
                                  BoxShadow(
                                    color: widget.primaryColor.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                  ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // Numéro stylisé
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: _hoveredIndex == itemIndex
                                          ? [widget.primaryColor, widget.primaryColor.withOpacity(0.8)]
                                          : [Colors.grey.shade300, Colors.grey.shade400],
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${itemIndex}',
                                      style: fontFammilyDii(
                                        context,
                                        14,
                                        blanc,
                                        FontWeight.w900,
                                        FontStyle.normal,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                // Texte
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (article.tags?.titre != null)
                                        Text(
                                          article.tags!.titre!.toUpperCase(),
                                          style: fontFammilyDii(
                                            context,
                                            9,
                                            widget.primaryColor,
                                            FontWeight.w700,
                                            FontStyle.normal,
                                          ),
                                        ),
                                      SizedBox(height: 4),
                                      Text(
                                        article.titre ?? '',
                                        style: fontFammilyDii(
                                          context,
                                          13,
                                          _hoveredIndex == itemIndex ? noir : Colors.grey.shade800,
                                          FontWeight.w600,
                                          FontStyle.normal,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                // Icône flèche
                                if (_hoveredIndex == itemIndex)
                                  Icon(
                                    CupertinoIcons.chevron_right,
                                    color: widget.primaryColor,
                                    size: 16,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
