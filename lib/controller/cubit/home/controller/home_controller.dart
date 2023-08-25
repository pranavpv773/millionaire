import 'dart:async';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:get/get.dart';

class HomeController extends GetxController {
  late Timer _timer;
  RxInt days = 0.obs;
  RxInt hours = 0.obs;
  RxInt minutes = 0.obs;
  RxInt seconds = 0.obs;
  late tz.Location dubai;
  late tz.TZDateTime nextSunday8PM;

  @override
  void onInit() {
    tz.initializeTimeZones();
    dubai = tz.getLocation('Asia/Dubai');
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
    final now = tz.TZDateTime.now(dubai);
    final nextSunday = tz.TZDateTime(dubai, now.year, now.month,
        now.day + (DateTime.sunday - now.weekday + 7) % 7, 20);
    if (now.isAfter(nextSunday)) {
      nextSunday.add(const Duration(days: 7));
    }
    nextSunday8PM = nextSunday;
    final countdown = nextSunday8PM.difference(now);

    days.value = countdown.inDays;
    hours.value = countdown.inHours.remainder(24);
    minutes.value = countdown.inMinutes.remainder(60);
    seconds.value = countdown.inSeconds.remainder(60);

    update();
  }
}
