import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/screen/utilisateur/widget/section-article/section-sport-modern.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';

class SectionMultiModern extends StatelessWidget {
  final List<ArticlesModel> sportArticles;
  final List<ArticlesModel> cultureArticles;
  final List<ArticlesModel> afriqueArticles;
  final List<ArticlesModel> internationalArticles;

  const SectionMultiModern({
    super.key,
    required this.sportArticles,
    required this.cultureArticles,
    required this.afriqueArticles,
    required this.internationalArticles,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 650,
      width: 1024,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            if (sportArticles.isNotEmpty) ...[
              SectionSportModern(articles: sportArticles),
              paddingHorizontalGlobal(),
            ],
            if (cultureArticles.isNotEmpty) ...[
              SectionSportModern(articles: cultureArticles),
              paddingHorizontalGlobal(),
            ],
            if (afriqueArticles.isNotEmpty) ...[
              SectionSportModern(articles: afriqueArticles),
              paddingHorizontalGlobal(),
            ],
            if (internationalArticles.isNotEmpty) ...[
              SectionSportModern(articles: internationalArticles),
            ],
          ],
        ),
      ),
    );
  }
}
