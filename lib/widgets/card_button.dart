import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  const CardButton({
    super.key,
    required this.onTap,
    this.icon,
    this.label,
    this.iconColour,
    this.colour,
    this.textColour,
    this.padding,
  });

  final Function onTap;
  final IconData? icon;
  final String? label;
  final Color? iconColour;
  final Color? colour;
  final Color? textColour;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Card(
        color: colour ?? Color.fromARGB(255, 247, 236, 255),
        margin: EdgeInsets.all(0),
        elevation: 0,
        child: Padding(
          padding: padding ??
              EdgeInsets.only(top: 21, bottom: 21, left: 10, right: 10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon ?? Icons.face,
                  size: 34,
                  color: iconColour ?? Color(0xff65558F),
                ),
                Text(
                  label ?? "Label",
                  style: TextStyle(
                      color: textColour ?? Color.fromARGB(255, 80, 80, 80),
                      overflow: TextOverflow.ellipsis),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
