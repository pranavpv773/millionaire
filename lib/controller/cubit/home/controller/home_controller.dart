import 'dart:async';

import 'package:get/get.dart';

class HomeController extends GetxController {
  late Timer _timer;
  RxInt days = 0.obs;
  RxInt hours = 0.obs;
  RxInt minutes = 0.obs;
  RxInt seconds = 0.obs;

  @override
  void onInit() {
    calculateCountdown();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      calculateCountdown();
    });
    super.onInit();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

//Lottery draw countdown
  void calculateCountdown() {
    final now = DateTime.now();
    var sunday = now.add(Duration(days: DateTime.sunday - now.weekday));
    sunday = DateTime(sunday.year, sunday.month, sunday.day, 20, 0, 0);

    if (now.isAfter(sunday)) {
      sunday = sunday.add(const Duration(days: 7)); // Move to next sunday
    }

    final diff = sunday.difference(now);
    days.value = diff.inDays;
    hours.value = diff.inHours.remainder(24);
    minutes.value = diff.inMinutes.remainder(60);
    seconds.value = diff.inSeconds.remainder(60);

    update();
  }
}
