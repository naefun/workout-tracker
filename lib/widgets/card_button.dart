import 'package:flutter/material.dart';
import 'package:gym_tracker_app/util/color_utils.dart';

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

  final void Function() onTap;
  final IconData? icon;
  final String? label;
  final Color? iconColour;
  final Color? colour;
  final Color? textColour;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      color: colour ?? primaryColour,
      margin: EdgeInsets.all(0),
      elevation: 0,
      child: InkWell(
        splashColor: darken(
          (colour ?? primaryColour),
          0.08,
        ).withValues(alpha: 0.8),
        onTap: onTap,
        child: Padding(
          padding: padding ??
              EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
          child: Center(
            child: Row(
              spacing: 12,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon ?? Icons.face,
                  size: 35,
                  color: iconColour ?? Color(0xff202730),
                ),
                Text(
                  label ?? "Label",
                  style: TextStyle(
                      color: textColour ?? Color(0xFF202730),
                      overflow: TextOverflow.ellipsis,
                      fontSize: 14),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
