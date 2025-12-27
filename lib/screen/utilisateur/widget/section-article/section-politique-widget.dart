import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/// Section "Politique" — implémentation propre et lisible
class SectionPolitiqueWidget extends StatelessWidget {
  const SectionPolitiqueWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeBloc = Provider.of<HomeUtilisateurBloc>(context);
    final List<ArticlesModel> articles = homeBloc.articlePolitiques;

    if (articles.isEmpty) return const SizedBox.shrink();

    final une = homeBloc.unePolitique;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8)],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _header(context),
        const SizedBox(height: 12),
        LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > 720) {
            return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(flex: 3, child: _mainArticle(context, une)),
              const SizedBox(width: 16),
              Expanded(flex: 2, child: _secondaryList(context, articles)),
            ]);
          }

          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _mainArticle(context, une),
            const SizedBox(height: 12),
            _secondaryList(context, articles),
          ]);
        })
      ]),
    );
  }

  Widget _header(BuildContext context) {
    final homeBloc = Provider.of<HomeUtilisateurBloc>(context);
    return Row(children: [
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: const Color(0xFFDC2626), borderRadius: BorderRadius.circular(6)),
        child: const Icon(Icons.gavel, color: Colors.white, size: 18),
      ),
      const SizedBox(width: 12),
      Text('Politique', style: fontFammilyDii(context, 20.0, const Color(0xFF1F2937), FontWeight.w700, FontStyle.normal)),
      const Spacer(),
      InkWell(
        onTap: () async {
          await homeBloc.setCatMenu(
                            homeBloc.categories.firstWhere(
                            (e) => e.titre! == "POLITIQUE"));
                            context.go(
                              '/categorie/${homeBloc.articlePolitiques.first.categorie!.slug!.toLowerCase()}',
                            );
                            await homeBloc.setCategorieMenu();
        },
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(6)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Text('Voir +', style: fontFammilyDii(context, 13.0, const Color(0xFF6B7280), FontWeight.w600, FontStyle.normal)),
            const SizedBox(width: 6),
            const Icon(Icons.arrow_forward_ios, size: 12, color: Color(0xFF6B7280))
          ]),
        ),
      )
    ]);
  }

  Widget _mainArticle(BuildContext context, ArticlesModel? a) {
    if (a == null) return const SizedBox.shrink();

    return InkWell(
      onTap: () => GoRouter.of(context).push('/article/${a.id}'),
      borderRadius: BorderRadius.circular(8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: a.imageArticle != null
              ? Image.network(
                  '$BASE_URL_ASSET${a.imageArticle!.url}',
                  width: double.infinity,
                  height: 420,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(height: 420, color: const Color(0xFFF3F4F6), child: const Icon(Icons.image_not_supported, size: 40, color: Color(0xFF9CA3AF))),
                )
              : Container(height: 420, color: const Color(0xFFF3F4F6), child: const Icon(Icons.article, size: 40, color: Color(0xFF9CA3AF))),
        ),
        const SizedBox(height: 12),
       // Text(a.titre ?? '', style: fontFammilyDii(context, 18.0, const Color(0xFF1F2937), FontWeight.w700, FontStyle.normal), maxLines: 3, overflow: TextOverflow.ellipsis),
        const SizedBox(height: 8),
        //Text(a.description ?? '', style: fontFammilyDii(context, 14.0, const Color(0xFF6B7280), FontWeight.w400, FontStyle.normal), maxLines: 3, overflow: TextOverflow.ellipsis),
        const SizedBox(height: 12),
        
      ]),
    );
  }

  Widget _secondaryList(BuildContext context, List<ArticlesModel> articles) {
    final list = articles.length > 4 ? articles.sublist(0, 4) : articles;
    return Column(children: list.map((a) => _listItem(context, a)).toList());
  }

  Widget _listItem(BuildContext context, ArticlesModel a) {
    return InkWell(
      onTap: () => GoRouter.of(context).push('/article/${a.id}'),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFFE5E7EB))),
        child: Row(children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: a.imageArticle != null
                  ? Image.network(
                      '$BASE_URL_ASSET${a.imageArticle!.url}',
                      width: 92,
                      height: 64,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(width: 92, height: 64, color: const Color(0xFFF3F4F6)),
                    )
                  : Container(width: 92, height: 64, color: const Color(0xFFF3F4F6), child: const Icon(Icons.article, color: Color(0xFF9CA3AF)))),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(a.titre ?? '', style: fontFammilyDii(context, 14.0, const Color(0xFF1F2937), FontWeight.w600, FontStyle.normal), maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 6),
              Text(_formatDate(a.date ?? ''), style: fontFammilyDii(context, 11.0, const Color(0xFF9CA3AF), FontWeight.w400, FontStyle.normal))
            ]),
          )
        ]),
      ),
    );
  }

  /// Format simple de date en français: '10 octobre 2023'
  String _formatDate(String dateStr) {
    if (dateStr.isEmpty) return 'Date non disponible';

    try {
      final date = DateTime.parse(dateStr);
      final months = [
        'janvier',
        'février',
        'mars',
        'avril',
        'mai',
        'juin',
        'juillet',
        'août',
        'septembre',
        'octobre',
        'novembre',
        'décembre'
      ];
      return '${date.day} ${months[date.month - 1]} ${date.year}';
    } catch (e) {
      return dateStr; // fallback
    }
  }
}