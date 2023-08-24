import 'dart:async';

import 'package:flutter/material.dart';
import 'package:millionaire_app/utils/colors.dart';
import 'package:intl/intl.dart';

class HowToUseScreen extends StatefulWidget {
  const HowToUseScreen({super.key});

  @override
  State<HowToUseScreen> createState() => _HowToUseScreenState();
}

class _HowToUseScreenState extends State<HowToUseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("How to use"),
        backgroundColor: AppColors.primary,
      ),
      body: CountdownWidget(),
    );
  }
}

class CountdownWidget extends StatefulWidget {
  const CountdownWidget({super.key});

  @override
  _CountdownWidgetState createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  late DateTime _targetDate;
  late Timer _timer; // Add a Timer variable

  @override
  void initState() {
    super.initState();
    _calculateTargetDate();
    _startTimer(); // Start the timer when the widget initializes
  }

  void _calculateTargetDate() {
    DateTime now = DateTime.now();
    int daysUntilSunday = DateTime.sunday - now.weekday;
    if (daysUntilSunday <= 0) {
      daysUntilSunday += 7;
    }
    _targetDate = now.add(Duration(days: daysUntilSunday));
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _calculateTargetDate();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    return '${duration.inDays}d ${duration.inHours.remainder(24)}h '
        '${duration.inMinutes.remainder(60)}m ${duration.inSeconds.remainder(60)}s';
  }

  @override
  Widget build(BuildContext context) {
    Duration timeUntilTarget = _targetDate.difference(DateTime.now());

    int remainingDays = timeUntilTarget.inDays;
    int remainingHours = timeUntilTarget.inHours.remainder(24);
    int remainingMinutes = timeUntilTarget.inMinutes.remainder(60);
    int remainingSeconds = timeUntilTarget.inSeconds.remainder(60);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Countdown to Sunday:',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),
          Text(
            'Days: $remainingDays\n'
            'Hours: $remainingHours\n'
            'Minutes: $remainingMinutes\n'
            'Seconds: $remainingSeconds',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
