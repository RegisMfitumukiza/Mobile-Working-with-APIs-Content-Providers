import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  void initConnectivity(BuildContext context) {
    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
      // Get the current connectivity result
      final ConnectivityResult result = results.isNotEmpty ? results.first : ConnectivityResult.none;

      String message = result != ConnectivityResult.none
          ? 'Internet connected'
          : 'Internet disconnected';
      Fluttertoast.showToast(msg: message);
    });
  }
}
