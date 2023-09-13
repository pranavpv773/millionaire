import 'dart:async';
import 'package:flutter/material.dart';
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

  RxList numberList = [].obs;

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

  addOrRemoveFromList({required int item}) {
    if (numberList.contains(item)) {
      numberList.remove(item);
    } else {
      if (numberList.length == 7) {
        Get.snackbar(
          "Warning",
          "You can only be able to select seven numbers",
          icon: const Icon(Icons.dangerous_outlined, color: Colors.white),
          snackPosition: SnackPosition.TOP,
        );
      } else {
        numberList.add(item);
      }
    }
  }

  clearNumberList() {
    numberList.clear();
    update();
  }
}
