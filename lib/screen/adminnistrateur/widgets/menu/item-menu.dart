import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemMenu extends StatefulWidget {
  final String titre;
  final IconData icons;
  final double sizeIcon;
  final bool haveIcon;
  final bool isActive;
  final Function ontap;
  const ItemMenu(
      {super.key,
      required this.titre,
      required this.icons,
      required this.ontap,
      this.haveIcon = true,
      this.sizeIcon = 8,
      this.isActive = false});

  @override
  State<ItemMenu> createState() => _ItemMenuState();
}

class _ItemMenuState extends State<ItemMenu> {
  bool ishover = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) => setState(() {
        ishover = true;
      }),
      onExit: (event) => setState(() {
        ishover = false;
      }),
      child: GestureDetector(
        onTap: () => widget.ontap(),
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: size.width * .015,
            vertical: 3,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: size.width * .015,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            gradient: widget.isActive
                ? LinearGradient(
                    colors: [
                      rouge.withOpacity(0.2),
                      rouge.withOpacity(0.15),
                    ],
                  )
                : ishover
                    ? LinearGradient(
                        colors: [
                          blanc.withOpacity(0.1),
                          blanc.withOpacity(0.05),
                        ],
                      )
                    : null,
            borderRadius: BorderRadius.circular(10),
            border: widget.isActive
                ? Border.all(
                    color: rouge.withOpacity(0.3),
                    width: 1,
                  )
                : ishover
                    ? Border.all(
                        color: blanc.withOpacity(0.1),
                        width: 1,
                      )
                    : null,
          ),
          child: Row(
            children: [
              // Icône avec style moderne
              if (widget.haveIcon)
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: widget.isActive
                        ? rouge.withOpacity(0.2)
                        : ishover
                            ? blanc.withOpacity(0.1)
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    widget.icons,
                    color: widget.isActive
                        ? rouge
                        : ishover
                            ? blanc
                            : blanc.withOpacity(0.7),
                    size: widget.sizeIcon == 8 ? 14 : widget.sizeIcon,
                  ),
                ),
              SizedBox(width: widget.haveIcon ? 12 : 8),
              // Texte
              Expanded(
                child: Text(
                  widget.titre,
                  style: fontFammilyDii(
                    context,
                    widget.haveIcon ? 13 : 14,
                    widget.isActive
                        ? blanc
                        : ishover
                            ? blanc
                            : blanc.withOpacity(0.8),
                    widget.isActive || !widget.haveIcon
                        ? FontWeight.w700
                        : FontWeight.w500,
                    FontStyle.normal,
                  ),
                ),
              ),
              // Indicateur actif
              if (widget.isActive)
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: rouge,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: rouge.withOpacity(0.5),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
