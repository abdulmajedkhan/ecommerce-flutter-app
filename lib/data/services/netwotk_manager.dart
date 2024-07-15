import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../util/popups/loaders.dart';

/// Manages the network connectivity status and provides methods to check and handle connectivity changes.
class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeConnectivity();
  }

  /// Initializes the network manager and sets up a stream to continuously check the connection status.
  void _initializeConnectivity() {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  /// Updates the connection status and shows a warning snackbar if there is no internet connection.
  void _updateConnectionStatus(ConnectivityResult result) {
    _connectionStatus.value = result;
    if (result == ConnectivityResult.none) {
      NLoaders.warningSnackBar(title: 'No Internet Connection');
    }
  }

  /// Checks internet connection status.
  /// Returns true if connected, false otherwise.
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      if(result == ConnectivityResult.none){
        return false;
      } else{
        return true;
      }

    } on PlatformException catch (_) {
      return false;
    }
  }
/// Dispose or close the active connectivity stream
  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}
