import 'dart:async';
import 'package:actu/bloc/utilisateur/flash-news-bloc.dart';
import 'package:actu/models/administrateur/flash-news-model.dart';
import 'package:actu/utils/date-showing-dii.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlashNewsWidget extends StatefulWidget {
  final bool havespace;
  final List<FlashNewsModel> flashNews;
  const FlashNewsWidget(
      {super.key, this.havespace = true, required this.flashNews});

  @override
  State<FlashNewsWidget> createState() => _FlashNewsWidgetState();
}

class _FlashNewsWidgetState extends State<FlashNewsWidget>
    with TickerProviderStateMixin {
  Timer? _timer;
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAutoScroll();
  }

  void _setupAnimations() {
    // Animation pour le glissement
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));

    // Animation pour la transparence
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));

    // Démarrer les animations
    _slideController.forward();
    _fadeController.forward();
  }

  void _startAutoScroll() {
    if (widget.flashNews.isEmpty) return;
    
    _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
      if (mounted && widget.flashNews.isNotEmpty) {
        final flashNewsUserBloc = Provider.of<FlashNewsUserBloc>(context, listen: false);
        _animateToNext(flashNewsUserBloc);
      }
    });
  }

  void _animateToNext(FlashNewsUserBloc bloc) async {
    // Animation de sortie
    await _fadeController.reverse();
    await _slideController.reverse();
    
    // Changer l'index
    bloc.setIndexShow(bloc.indexShow + 1);
    
    // Animation d'entrée
    _slideController.forward();
    _fadeController.forward();
  }

  void _animateToPrevious(FlashNewsUserBloc bloc) async {
    // Animation de sortie
    await _fadeController.reverse();
    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));
    await _slideController.reverse();
    
    // Changer l'index
    bloc.setIndexShow(bloc.indexShow - 1);
    
    // Remettre l'animation normale et animer l'entrée
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));
    _slideController.forward();
    _fadeController.forward();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final flashNewsUserBloc = Provider.of<FlashNewsUserBloc>(context);
    
    // État de chargement
    if (flashNewsUserBloc.isLoading) {
      return Container(
        height: 60,
        margin: widget.havespace 
          ? const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
          : EdgeInsets.zero,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF1e293b),
              Color(0xFF334155),
            ],
          ),
          borderRadius: widget.havespace ? BorderRadius.circular(12) : BorderRadius.zero,
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white.withOpacity(0.7)),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Chargement des flash news...',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }
    
    // Aucune donnée
    if (widget.flashNews.isEmpty) {
      return Container(
        height: 60,
        margin: widget.havespace 
          ? const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
          : EdgeInsets.zero,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF1e293b),
              Color(0xFF334155),
            ],
          ),
          borderRadius: widget.havespace ? BorderRadius.circular(12) : BorderRadius.zero,
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.info_circle,
              color: Colors.white.withOpacity(0.7),
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              'Aucune flash news disponible',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return AnimatedBuilder(
      animation: Listenable.merge([_slideController, _fadeController]),
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Container(
              margin: widget.havespace 
                ? const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
                : EdgeInsets.zero,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFFef4444),
                    Color(0xFFdc2626),
                    Color(0xFFb91c1c),
                  ],
                ),
                borderRadius: widget.havespace ? BorderRadius.circular(12) : BorderRadius.zero,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFef4444).withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: widget.havespace ? BorderRadius.circular(12) : BorderRadius.zero,
                child: Row(
              children: [
                // Badge "FLASH"
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF991b1b),
                        Color(0xFF7f1d1d),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(2, 0),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          CupertinoIcons.bolt_fill,
                          color: Colors.white,
                          size: size.width >= 1440 ? 16 : size.width >= 1024 ? 14 : 12,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'FLASH',
                        style: TextStyle(
                          fontSize: size.width >= 1440 ? 16 : size.width >= 1024 ? 14 : 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Date et heure
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                  CupertinoIcons.clock_fill,
                  color: Colors.white,
                  size: size.width >= 1440 ? 14 : size.width >= 1024 ? 12 : 10,
                ),
                const SizedBox(width: 6),
                Text(
                  showDate(widget.flashNews[flashNewsUserBloc.indexShow].date!),
                  style: TextStyle(
                      fontSize: size.width >= 1440 ? 12 : size.width >= 1024 ? 11 : 9,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                      ],
                    ),
                  ),
                ),
                
                // Type de flash
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                        widget.flashNews[flashNewsUserBloc.indexShow].type!.toUpperCase(),
                        style: TextStyle(
                            color: const Color(0xFFef4444),
                            fontSize: size.width >= 1440 ? 13 : size.width >= 1024 ? 11 : 9,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.0),
                      ),
                ),
                
                const SizedBox(width: 16),
                
                // Contenu du flash
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                  widget.flashNews[flashNewsUserBloc.indexShow].desc!.toUpperCase(),
                  style: TextStyle(
                      fontSize: size.width >= 1440 ? 15 : size.width >= 1024 ? 13 : 11,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                      height: 1.3),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                  ),
                ),
                
                // Indicateur de position
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${flashNewsUserBloc.indexShow + 1}/${widget.flashNews.length}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size.width >= 1440 ? 12 : size.width >= 1024 ? 11 : 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                
                // Boutons de navigation
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => _animateToPrevious(flashNewsUserBloc),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.4),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                          CupertinoIcons.chevron_left,
                          color: Colors.white,
                          size: size.width >= 1440 ? 18 : size.width >= 1024 ? 16 : 14,
                        ),
                    ),
                  ),
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => _animateToNext(flashNewsUserBloc),
                    child: Container(
                      margin: const EdgeInsets.only(right: 16),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.4),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                          CupertinoIcons.chevron_right,
                          color: Colors.white,
                          size: size.width >= 1440 ? 18 : size.width >= 1024 ? 16 : 14,
                        ),
                    ),
                  ),
                ),
              ],
            ),
              ),
            ),
          ),
        );
      },
    );
  }
}
