import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'dart:js' as js;

class SectionDossierRedactionWidget extends StatefulWidget {
  final ArticlesModel? articles;
  const SectionDossierRedactionWidget({super.key, this.articles = null});

  @override
  State<SectionDossierRedactionWidget> createState() => _SectionDossierRedactionWidgetState();
}

class _SectionDossierRedactionWidgetState extends State<SectionDossierRedactionWidget> {
  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: Colors.white,
        //  borderRadius: BorderRadius.circular(12),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(_isHovered ? 0.12 : 0.08),
          //     blurRadius: _isHovered ? 20 : 15,
          //     offset: Offset(0, _isHovered ? 8 : 5),
          //   ),
          // ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: widget.articles!.slug!,
              child: GestureDetector(
                onTap: () {
                  homeUtilisateurBloc.setAticle(widget.articles!);
                  js.context.callMethod('open', [
                    'https://a221.net/article/${widget.articles!.slug!}',
                    '_self'
                  ]);
                },
                child: Container(
                  height: 240,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        BASE_URL_ASSET + widget.articles!.imageArticle!.url!,
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.go('/tag/${widget.articles!.tags!.slug!}');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE53935).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFFE53935).withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        widget.articles!.tags!.titre!.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 8,
                          color: Color(0xFFE53935),
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      homeUtilisateurBloc.setAticle(widget.articles!);
                      js.context.callMethod('open', [
                        'https://a221.net/article/${widget.articles!.slug!}',
                        '_self'
                      ]);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.05),
                          width: 1,
                        ),
                      ),
                      child: HtmlWidget(
                        widget.articles!.titre!,
                        customStylesBuilder: (element) {
                          if (element.classes.contains('ql-align-center')) {
                            return {'text-align': 'center'};
                          }
                          if (element.classes.contains('ql-align-justify')) {
                            return {'text-align': 'justify'};
                          }
                          return {
                            'fontSize': '12px',
                            'text-align': 'left',
                            'line-height': '1.4',
                            'word-wrap': 'break-word',
                            'font-weight': '700',
                            'letter-spacing': '-0.3px',
                            'color': '#1A1A1A',
                          };
                        },
                        textStyle: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF1A1A1A),
                          fontWeight: FontWeight.w700,
                          height: 1.4,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}