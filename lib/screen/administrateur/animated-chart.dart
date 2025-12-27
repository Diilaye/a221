import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedChart extends StatefulWidget {
  final List<double> data;
  final List<String> labels;
  final Color primaryColor;
  final Color accentColor;
  final double height;

  const AnimatedChart({
    Key? key,
    required this.data,
    required this.labels,
    this.primaryColor = const Color(0xFF06b6d4),
    this.accentColor = const Color(0xFFef4444),
    this.height = 200,
  }) : super(key: key);

  @override
  State<AnimatedChart> createState() => _AnimatedChartState();
}

class _AnimatedChartState extends State<AnimatedChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1a1a2e),
            const Color(0xFF16213e),
            const Color(0xFF0f3460),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: widget.primaryColor.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: widget.primaryColor.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: ChartPainter(
              data: widget.data,
              labels: widget.labels,
              progress: _animation.value,
              primaryColor: widget.primaryColor,
              accentColor: widget.accentColor,
            ),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class ChartPainter extends CustomPainter {
  final List<double> data;
  final List<String> labels;
  final double progress;
  final Color primaryColor;
  final Color accentColor;

  ChartPainter({
    required this.data,
    required this.labels,
    required this.progress,
    required this.primaryColor,
    required this.accentColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final maxValue = data.reduce(math.max);
    final barWidth = (size.width - 40) / data.length;
    final padding = 40.0;

    // Dessiner la grille
    final gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 0.5;

    for (int i = 0; i <= 4; i++) {
      final y = padding + (size.height - padding * 2) * i / 4;
      canvas.drawLine(
        Offset(padding, y),
        Offset(size.width - 20, y),
        gridPaint,
      );
    }

    // Dessiner les barres
    for (int i = 0; i < data.length; i++) {
      final x = padding + i * barWidth + barWidth / 2;
      final barHeight =
          ((size.height - padding * 2) * (data[i] / maxValue)) * progress;
      final y = size.height - padding - barHeight;

      // Ombre de la barre
      final shadowPaint = Paint()
        ..color = primaryColor.withOpacity(0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x - barWidth / 3, y, barWidth * 0.6, barHeight),
          const Radius.circular(8),
        ),
        shadowPaint,
      );

      // Gradient de la barre
      final barPaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            primaryColor,
            accentColor,
          ],
        ).createShader(
          Rect.fromLTWH(x - barWidth / 3, y, barWidth * 0.6, barHeight),
        );

      // Barre principale
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x - barWidth / 3, y, barWidth * 0.6, barHeight),
          const Radius.circular(8),
        ),
        barPaint,
      );

      // Effet de brillance
      final highlightPaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.white.withOpacity(0.5),
            Colors.white.withOpacity(0.0),
          ],
        ).createShader(
          Rect.fromLTWH(x - barWidth / 3, y, barWidth * 0.2, barHeight),
        );

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x - barWidth / 3, y, barWidth * 0.2, barHeight),
          const Radius.circular(8),
        ),
        highlightPaint,
      );

      // Label
      if (i < labels.length) {
        final textPainter = TextPainter(
          text: TextSpan(
            text: labels[i],
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(
            x - textPainter.width / 2,
            size.height - padding + 10,
          ),
        );
      }

      // Valeur
      final valuePainter = TextPainter(
        text: TextSpan(
          text: data[i].toInt().toString(),
          style: TextStyle(
            color: primaryColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      valuePainter.layout();
      valuePainter.paint(
        canvas,
        Offset(
          x - valuePainter.width / 2,
          y - 20,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(ChartPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
