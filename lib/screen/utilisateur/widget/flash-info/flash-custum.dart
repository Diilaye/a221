import 'package:flutter/material.dart';

class FlashNewsCustom extends StatefulWidget {
  @override
  _FlashNewsCustomState createState() => _FlashNewsCustomState();
}

class _FlashNewsCustomState extends State<FlashNewsCustom> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final List<String> newsList = [
    "🔥 Flash Info : Nouvelle mise à jour Flutter disponible ! 🚀",
    "📢 Promo spéciale cette semaine sur nos services ! 🎉",
    "⚡ Attention : Maintenance prévue demain à 22h 🛠️",
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration:const  Duration(seconds: 10), // Contrôle la vitesse du défilement
    )..repeat();

    _animation = Tween<double>(begin: 1.0, end: -1.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Container(
        height: 45,
        width: 850,
        alignment: Alignment.centerLeft,
        child:  Stack(
          children: newsList.asMap().entries.map((entry) {
            int index = entry.key;
            String news = entry.value;
            return Align(
              alignment: Alignment.centerLeft,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset((_animation.value + index * 2) * MediaQuery.of(context).size.width, 0),
                    child: child,
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    news,
                    style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
