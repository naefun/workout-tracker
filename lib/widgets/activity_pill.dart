import 'package:flutter/material.dart';

class ActivityPill extends StatelessWidget {
  const ActivityPill({
    super.key,
    required this.active,
  });

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 14, right: 14, top: 1, bottom: 1),
      decoration: BoxDecoration(
          border: Border.all(
              color: Color.from(
                  alpha: active ? 0.38 : 0, red: 0.714, green: 0.89, blue: 1)),
          color: active
              ? const Color.from(alpha: .36, red: 0.714, green: 0.89, blue: 1)
              : const Color.from(alpha: 0.08, red: 1, green: 1, blue: 1),
          borderRadius: BorderRadius.circular(100)),
      child: Text(
        active ? "Active" : "Inactive",
        style: TextStyle(
            color: active
                ? const Color.fromARGB(255, 255, 255, 255)
                : const Color(0xffABABAB),
            fontWeight: FontWeight.normal),
      ),
    );
  }
}
