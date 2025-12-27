import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

class RealTimeStatCard extends StatefulWidget {
  final String title;
  final int value;
  final double growth;
  final IconData icon;
  final Color primaryColor;
  final Color accentColor;

  const RealTimeStatCard({
    Key? key,
    required this.title,
    required this.value,
    required this.growth,
    required this.icon,
    this.primaryColor = const Color(0xFF06b6d4),
    this.accentColor = const Color(0xFFef4444),
  }) : super(key: key);

  @override
  State<RealTimeStatCard> createState() => _RealTimeStatCardState();
}

class _RealTimeStatCardState extends State<RealTimeStatCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<int> _counterAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller, curve: const Interval(0.0, 0.5)),
    );

    _counterAnimation = IntTween(begin: 0, end: widget.value).animate(
      CurvedAnimation(
          parent: _controller, curve: Curves.easeOutCubic),
    );

    _controller.forward();
  }

  @override
  void didUpdateWidget(RealTimeStatCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _controller.reset();
      _counterAnimation = IntTween(begin: oldWidget.value, end: widget.value)
          .animate(
        CurvedAnimation(
            parent: _controller, curve: Curves.easeOutCubic),
      );
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF1a1a2e),
                    const Color(0xFF16213e),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: widget.primaryColor.withOpacity(0.3),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.primaryColor.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // En-tête avec icône
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              widget.primaryColor.withOpacity(0.3),
                              widget.accentColor.withOpacity(0.3),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: widget.primaryColor.withOpacity(0.5),
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          widget.icon,
                          color: widget.primaryColor,
                          size: 24,
                        ),
                      ),
                      // Indicateur en temps réel
                      _buildLiveIndicator(),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Titre
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Valeur animée
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [
                            widget.primaryColor,
                            widget.accentColor,
                          ],
                        ).createShader(bounds),
                        child: Text(
                          _formatNumber(_counterAnimation.value),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Badge de croissance
                      _buildGrowthBadge(),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Graphique miniature
                  Flexible(child: _buildMiniSparkline()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLiveIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: widget.primaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: widget.primaryColor.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: widget.primaryColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: widget.primaryColor.withOpacity(0.5),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          const Text(
            'LIVE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrowthBadge() {
    final isPositive = widget.growth >= 0;
    final color = isPositive ? const Color(0xFF10b981) : const Color(0xFFef4444);
    final icon = isPositive ? CupertinoIcons.arrow_up : CupertinoIcons.arrow_down;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.3),
            color.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: 14,
          ),
          const SizedBox(width: 4),
          Text(
            '${widget.growth.abs().toStringAsFixed(1)}%',
            style: TextStyle(
              color: color,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniSparkline() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: CustomPaint(
        painter: SparklinePainter(
          color: widget.primaryColor,
          progress: _controller.value,
        ),
        size: const Size(double.infinity, 40),
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
}

class SparklinePainter extends CustomPainter {
  final Color color;
  final double progress;

  SparklinePainter({required this.color, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          color.withOpacity(0.3),
          color.withOpacity(0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // Données simulées pour la sparkline
    final points = <Offset>[];
    final random = math.Random(42);
    
    for (int i = 0; i <= 20; i++) {
      final x = (size.width / 20) * i * progress;
      final y = size.height / 2 +
          math.sin(i * 0.5) * 10 +
          (random.nextDouble() - 0.5) * 8;
      points.add(Offset(x, y));
    }

    // Dessiner la zone remplie
    if (points.length > 1) {
      final path = Path();
      path.moveTo(0, size.height);
      path.lineTo(points.first.dx, points.first.dy);
      
      for (int i = 1; i < points.length; i++) {
        path.lineTo(points[i].dx, points[i].dy);
      }
      
      path.lineTo(points.last.dx, size.height);
      path.close();
      canvas.drawPath(path, fillPaint);
    }

    // Dessiner la ligne
    if (points.length > 1) {
      final linePath = Path();
      linePath.moveTo(points.first.dx, points.first.dy);
      
      for (int i = 1; i < points.length; i++) {
        linePath.lineTo(points[i].dx, points[i].dy);
      }
      
      canvas.drawPath(linePath, paint);
    }

    // Dessiner un point à la fin
    if (points.isNotEmpty) {
      final lastPoint = points.last;
      final dotPaint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;
      
      canvas.drawCircle(lastPoint, 4, dotPaint);
      
      final glowPaint = Paint()
        ..color = color.withOpacity(0.3)
        ..style = PaintingStyle.fill;
      
      canvas.drawCircle(lastPoint, 8, glowPaint);
    }
  }

  @override
  bool shouldRepaint(SparklinePainter oldDelegate) =>
      oldDelegate.progress != progress;
}
