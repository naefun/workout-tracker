import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class TimerCount extends ConsumerStatefulWidget {
  const TimerCount({
    super.key,
    required this.startTime,
    this.includeHours = false,
    this.isSecondary = false,
  });

  final DateTime startTime;
  final bool includeHours;
  final bool isSecondary;
  @override
  ConsumerState<TimerCount> createState() => _TimerCountState();
}

class _TimerCountState extends ConsumerState<TimerCount> {
  late Duration _elapsed;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _updateElapsed();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateElapsed();
    });
  }

  void _updateElapsed() {
    setState(() {
      _elapsed = DateTime.now().difference(widget.startTime);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return widget.includeHours
        ? '$hours:$minutes:$seconds'
        : '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Icon(
          Icons.timer,
          color: widget.isSecondary ? Color(0xffC0C0C0) : Color(0xff454545),
        ),
        Text(
          _formatDuration(_elapsed),
          style: GoogleFonts.kodeMono(
            color: widget.isSecondary ? Color(0xffC0C0C0) : Color(0xff454545),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
