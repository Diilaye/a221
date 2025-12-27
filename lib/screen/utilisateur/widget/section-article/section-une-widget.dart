import 'dart:async';
import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/screen/utilisateur/widget/la-une-article.dart';
import 'package:actu/screen/utilisateur/widget/la-une-top-article.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/date-showing-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionUneWidget extends StatefulWidget {
  const SectionUneWidget({super.key});

  @override
  State<SectionUneWidget> createState() => _SectionUneWidgetState();
}

class _SectionUneWidgetState extends State<SectionUneWidget>
    with TickerProviderStateMixin {
  Timer? _timer;
  late AnimationController _slideController;
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;
  
  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAutoSlide();
  }

  void _setupAnimations() {
    // Animation pour les transitions
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Animation pour la barre de progression
    _progressController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_progressController);

    _slideController.forward();
    _startProgressAnimation();
  }

  void _startProgressAnimation() {
    _progressController.forward().then((_) {
      if (mounted) {
        _progressController.reset();
        _startProgressAnimation();
      }
    });
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 8), (timer) {
      if (mounted) {
        final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context, listen: false);
        if (homeUtilisateurBloc.articleUnes.isNotEmpty) {
          _animateToNext(homeUtilisateurBloc);
        }
      }
    });
  }

  void _animateToNext(HomeUtilisateurBloc bloc) async {
    await _slideController.reverse();
    int nextIndex = (bloc.uneTop + 1) % bloc.articleUnes.length;
    bloc.setTopClick(nextIndex);
    _slideController.forward();
    _progressController.reset();
    _startProgressAnimation();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _slideController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: size.width > 1200 ? 1200 : size.width * 0.95,
        ),
        child: AnimatedBuilder(
          animation: _slideController,
          builder: (context, child) {
            return Card(
              elevation: 8,
              shadowColor: Colors.black.withOpacity(0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                height: size.width < 768 ? 400 : 500,
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
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: size.width < 768 
                    ? _buildMobileLayout(size, homeUtilisateurBloc)
                    : _buildDesktopLayout(size, homeUtilisateurBloc),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(Size size, HomeUtilisateurBloc homeUtilisateurBloc) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 600),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1.0, 0.0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                      );
                    },
                    child: homeUtilisateurBloc.uneArticle != null 
                      ? Container(
                          key: ValueKey(homeUtilisateurBloc.uneTop),
                          child: LaUneTopArticle(),
                        )
                      : _buildEmptyState(),
                  ),
                ),
                paddingVerticalGlobal(12),
                _buildProgressIndicator(homeUtilisateurBloc),
                paddingVerticalGlobal(12),
              ],
            ),
          ),
          paddingHorizontalGlobal(16),
          if (homeUtilisateurBloc.articleUnes.isNotEmpty)
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  
                  Expanded(
                    child: Column(
                      children: homeUtilisateurBloc.articleUnes.asMap().entries
                          .where((entry) => entry.key != homeUtilisateurBloc.uneTop) // Filtrer l'article actuel
                          .map((entry) {
                        int index = entry.key;
                        var article = entry.value;
                        return LaUneArticle(
                          key: ValueKey('une_article_$index'),
                          rubrique: article.categorie?.titre ?? '',
                          date: showDate(article.date!),
                          titre: article.titre!,
                          color: hexToColor(article.categorie?.bgColor ?? '#FF0000'),
                          isActif: homeUtilisateurBloc.uneTop == index,
                          i: index,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(Size size, HomeUtilisateurBloc homeUtilisateurBloc) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              child: homeUtilisateurBloc.uneArticle != null 
                ? Container(
                    key: ValueKey(homeUtilisateurBloc.uneTop),
                    child: LaUneTopArticle(),
                  )
                : _buildEmptyState(),
            ),
          ),
          paddingVerticalGlobal(8),
          _buildProgressIndicator(homeUtilisateurBloc),
          paddingVerticalGlobal(8),
          if (homeUtilisateurBloc.articleUnes.isNotEmpty)
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Text(
                    'À LA UNE',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: rouge,
                    ),
                  ),
                  paddingVerticalGlobal(4),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(), // Désactive le scroll
                      child: Row(
                        children: homeUtilisateurBloc.articleUnes.asMap().entries
                            .where((entry) => entry.key != homeUtilisateurBloc.uneTop) // Filtrer l'article actuel
                            .map((entry) {
                          int index = entry.key;
                          var article = entry.value;
                          return Container(
                            width: size.width * 0.7,
                            margin: const EdgeInsets.only(right: 8),
                            child: LaUneArticle(
                              key: ValueKey('une_article_mobile_$index'),
                              rubrique: article.categorie?.titre ?? '',
                              date: showDate(article.date!),
                              titre: article.titre!,
                              color: hexToColor(article.categorie?.bgColor ?? '#FF0000'),
                              isActif: homeUtilisateurBloc.uneTop == index,
                              i: index,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(HomeUtilisateurBloc homeUtilisateurBloc) {
    return AnimatedBuilder(
      animation: _progressController,
      builder: (context, child) {
        return Container(
          height: 6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: Colors.grey.shade200,
          ),
          child: Row(
            children: List.generate(homeUtilisateurBloc.articleUnes.length, (index) {
              bool isActive = homeUtilisateurBloc.uneTop == index;
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: isActive 
                      ? rouge 
                      : Colors.grey.shade300,
                  ),
                  child: isActive 
                    ? LinearProgressIndicator(
                        value: _progressAnimation.value,
                        backgroundColor: Colors.transparent,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          rouge.withOpacity(0.7),
                        ),
                        borderRadius: BorderRadius.circular(3),
                      )
                    : null,
                ),
              );
            }),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Container(
      key: const ValueKey('empty'),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.news,
              size: 64,
              color: Colors.grey.shade400,
            ),
            paddingVerticalGlobal(8),
            Text(
              'Aucun article à la une',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
              ),
            ),
            Text(
              'Veuillez patienter...',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
