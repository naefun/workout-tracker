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
          color: active ? const Color(0xffCCFFBC) : const Color(0xffF8F8F8),
          borderRadius: BorderRadius.circular(100)),
      child: Text(
        active ? "Active" : "Inactive",
        style: TextStyle(
            color: active ? const Color(0xff2C970C) : const Color(0xffABABAB),
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
