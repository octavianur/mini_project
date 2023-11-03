import 'package:flutter/material.dart';
import 'package:mini_project/services/connectivity_status.dart';
import 'package:provider/provider.dart';

class NetworkSensitive extends StatelessWidget {
  final Widget child;
  final Widget offlineChild;

  const NetworkSensitive({Key? key, required this.child, required this.offlineChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    if (connectionStatus == ConnectivityStatus.Online) {
      return child;
    } else if (connectionStatus == ConnectivityStatus.Offline) {
      return offlineChild;
    } else {
      // Handle unexpected connection status, e.g., display an error message
      return const Center(child: Text("Unknown network status"));
    }
  }
}
