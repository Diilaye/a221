import 'package:actu/models/administrateur/flash-news-model.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class FlashNewsSequential extends StatefulWidget {
  final List<FlashNewsModel> newsList;
  final Duration switchDuration; // Temps avant de passer au prochain flash news
  final Duration scrollDuration; // Durée de défilement

  const FlashNewsSequential({
    Key? key,
    required this.newsList,
    this.switchDuration = const Duration(seconds: 5),
    this.scrollDuration = const Duration(seconds: 10),
  }) : super(key: key);

  @override
  _FlashNewsSequentialState createState() => _FlashNewsSequentialState();
}

class _FlashNewsSequentialState extends State<FlashNewsSequential> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.scrollDuration, // Réduction de la vitesse du défilement
    );

    _animation = Tween<double>(begin: 1.0, end: -1.0).animate(_controller);

    // Démarrer l'animation en boucle
    _controller.repeat();

    // Changer les flash news à intervalle fixe indépendamment de l'animation
    _timer = Timer.periodic(widget.switchDuration, (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % widget.newsList.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Container(
        height: 40,
        width: double.infinity,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(_animation.value * MediaQuery.of(context).size.width, 0),
              child: child,
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: Text(
                widget.newsList[currentIndex].desc!,
                style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }
}
