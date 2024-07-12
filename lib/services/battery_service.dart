import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BatteryService {
  final Battery _battery = Battery();

  void initBatteryMonitor(BuildContext context) {
    _battery.onBatteryStateChanged.listen((BatteryState state) {
      if (state == BatteryState.charging) {
        checkBatteryLevel();
      }
    });
  }

  void checkBatteryLevel() async {
    int batteryLevel = await _battery.batteryLevel;
    if (batteryLevel >= 90) {
      Fluttertoast.showToast(msg: 'Battery level at $batteryLevel% while charging');
      // You can add code here to play a ringtone
    }
  }
}
