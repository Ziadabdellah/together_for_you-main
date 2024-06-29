import 'package:connectivity_plus/connectivity_plus.dart';

checkinternet() async {
  final connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult == ConnectivityResult.mobile) {
    // The app is connected to a mobile network.
  } else if (connectivityResult == ConnectivityResult.wifi) {
    // The app is connected to a WiFi network.
  } else if (connectivityResult == ConnectivityResult.ethernet) {
    // The app is connected to an ethernet network.
  } else if (connectivityResult == ConnectivityResult.vpn) {
    // The app is connected to a VPN network.
  } else if (connectivityResult == ConnectivityResult.bluetooth) {
    // The app is connected via Bluetooth.
  } else if (connectivityResult == ConnectivityResult.other) {
    // The app is connected to a network that is not in the above mentioned networks.
  } else if (connectivityResult == ConnectivityResult.none) {
    return false;
    // The app is not connected to any network.
  }
}
