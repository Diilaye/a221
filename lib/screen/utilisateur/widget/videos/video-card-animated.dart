import 'package:actu/models/administrateur/video-youtube-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:actu/utils/yWebUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class VideoCardAnimated extends StatefulWidget {
  final VideoYoutubeModel video;
  
  const VideoCardAnimated({super.key, required this.video});

  @override
  State<VideoCardAnimated> createState() => _VideoCardAnimatedState();
}

class _VideoCardAnimatedState extends State<VideoCardAnimated> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _showVideoModal(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (c) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(20),
          child: Container(
            constraints: BoxConstraints(maxWidth: 1100, maxHeight: 700),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: rouge.withOpacity(0.3),
                  blurRadius: 40,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF1A2332).withOpacity(0.95),
                        Color(0xFF0F1620).withOpacity(0.98),
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header avec logo et titre
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              noir.withOpacity(0.5),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: Row(
                          children: [
                            // Logo actu221
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: blanc.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: rouge.withOpacity(0.3), width: 1),
                              ),
                              child: Image.asset(
                                'assets/images/a221-logo.png',
                                height: 40,
                                width: 40,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: rouge.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: rouge.withOpacity(0.5), width: 1),
                                    ),
                                    child: Text(
                                      widget.video.emission!.toUpperCase(),
                                      style: fontFammilyDii(context, 11, rouge, FontWeight.w700, FontStyle.normal),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    widget.video.titre!,
                                    style: fontFammilyDii(context, 18, blanc, FontWeight.w700, FontStyle.normal),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 12),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () => Navigator.of(context).pop(),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: blanc.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: blanc.withOpacity(0.2), width: 1),
                                  ),
                                  child: Icon(CupertinoIcons.xmark, color: blanc, size: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Video player
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: noir.withOpacity(0.5),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: YoutubeHtmlWidget(urlY: widget.video.url!),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => _showVideoModal(context),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          transform: Matrix4.identity()
            ..translate(0.0, _isHovered ? -10.0 : 0.0)
            ..scale(_isHovered ? 1.05 : 1.0),
          width: 340,
          height: 310,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: noir.withOpacity(0.3),
            boxShadow: [
              BoxShadow(
                color: _isHovered ? rouge.withOpacity(0.4) : noir.withOpacity(0.4),
                blurRadius: _isHovered ? 25 : 12,
                offset: Offset(0, _isHovered ? 12 : 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                // Image avec effet de zoom au hover
                AnimatedScale(
                  scale: _isHovered ? 1.1 : 1.0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeOutCubic,
                  child: (widget.video.imageFile != null && 
                         widget.video.imageFile!.url != null && 
                         widget.video.imageFile!.url!.isNotEmpty)
                    ? Image.network(
                        BASE_URL_ASSET + widget.video.imageFile!.url!,
                        height: 190,
                        width: 340,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        'https://cdn.vectorstock.com/i/500p/81/79/no-photo-icon-default-placeholder-vector-41468179.jpg',
                        height: 190,
                        width: 340,
                        fit: BoxFit.cover,
                      ),
                ),
                // Gradient overlay animé
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 190,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        _isHovered ? noir.withOpacity(0.8) : noir.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),
                // Badge "NOUVEAU" animé (optionnel)
                if (_isHovered)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: AnimatedOpacity(
                      opacity: _isHovered ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 300),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: rouge.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: rouge.withOpacity(0.5),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(CupertinoIcons.play_circle_fill, color: blanc, size: 12),
                            SizedBox(width: 4),
                            Text(
                              'REGARDER',
                              style: fontFammilyDii(context, 9, blanc, FontWeight.w700, FontStyle.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                // Bouton play avec animation de pulsation
                Positioned(
                  top: 65,
                  left: 135,
                  child: AnimatedBuilder(
                    animation: _pulseAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _isHovered ? _pulseAnimation.value : 1.0,
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                rouge.withOpacity(0.95),
                                rouge.withOpacity(0.8),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: rouge.withOpacity(_isHovered ? 0.8 : 0.5),
                                blurRadius: _isHovered ? 30 : 20,
                                spreadRadius: _isHovered ? 5 : 2,
                              ),
                            ],
                          ),
                          child: Icon(
                            CupertinoIcons.play_fill,
                            color: blanc,
                            size: 28,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Badge durée vidéo (optionnel)
                Positioned(
                  top: 150,
                  left: 12,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: noir.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        Icon(CupertinoIcons.time, color: blanc, size: 12),
                        SizedBox(width: 4),
                        Text(
                          'HD',
                          style: fontFammilyDii(context, 10, blanc, FontWeight.w600, FontStyle.normal),
                        ),
                      ],
                    ),
                  ),
                ),
                // Section info avec effet glassmorphism
                Positioned(
                  top: 190,
                  child: Container(
                    width: 340,
                    height: 120,
                    constraints: BoxConstraints(maxHeight: 120),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF1A2332).withOpacity(_isHovered ? 1.0 : 0.95),
                          Color(0xFF0F1620).withOpacity(_isHovered ? 1.0 : 0.95),
                        ],
                      ),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: rouge.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: rouge.withOpacity(_isHovered ? 0.6 : 0.4),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            widget.video.emission!.toUpperCase(),
                            style: fontFammilyDii(context, 11, rouge, FontWeight.w700, FontStyle.normal),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        paddingVerticalGlobal(6),
                        Text(
                          widget.video.titre!,
                          style: fontFammilyDii(
                            context,
                            _isHovered ? 15 : 14,
                            blanc,
                            FontWeight.w600,
                            FontStyle.normal,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Icon(CupertinoIcons.play_arrow, color: rouge, size: 12),
                            SizedBox(width: 4),
                            Text(
                              'Regarder maintenant',
                              style: fontFammilyDii(
                                context,
                                11,
                                _isHovered ? blanc : blanc.withOpacity(0.7),
                                FontWeight.w500,
                                FontStyle.normal,
                              ),
                            ),
                            Spacer(),
                            if (_isHovered)
                              Icon(CupertinoIcons.arrow_right_circle_fill, color: rouge, size: 16),
                          ],
                        ),
                      ],
                    ),
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
