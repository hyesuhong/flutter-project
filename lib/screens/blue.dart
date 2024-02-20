import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/bottom_navigation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({super.key});

  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;
  late StreamSubscription<BluetoothAdapterState> _adapterStateSubscription;

  StreamSubscription<BluetoothAdapterState> _getBluetoothAdapterSubscription() {
    return FlutterBluePlus.adapterState.listen(
      (state) {
        print('Current Adapter State: ${state.name}');
        if (state == BluetoothAdapterState.on) {
          setState(() {
            _adapterState = state;
          });

          _scanDevices();
        } else {
          print(state.name);
        }
      },
      onError: (error) {
        print('onAdapterStateChange Error: ${error.toString()}');
      },
      onDone: () {
        print('onAdapterStateChange Done');
      },
    );
  }

  void _scanDevices() async {
    final StreamSubscription<List<ScanResult>> scanSubscription =
        FlutterBluePlus.onScanResults.listen(
      (results) {
        // print(results);
        if (results.isNotEmpty) {
          ScanResult r = results.last; // the most recently found device
          print(
              '${r.device.remoteId}: "${r.advertisementData.advName}" found!');
        }
      },
      onError: (error) {
        print('onScan Error: ${error.toString()}');
      },
      onDone: () {
        print('onScan Done!');
      },
    );

    FlutterBluePlus.cancelWhenScanComplete(scanSubscription);

    await FlutterBluePlus.startScan(
      timeout: Duration(seconds: 15),
    );

    FlutterBluePlus.isScanning.listen((event) {
      print('Scanning?: $event');
    });
  }

  @override
  void initState() async {
    super.initState();

    bool isSupported = await FlutterBluePlus.isSupported;

    if (!isSupported) {
      print('Bluetooth not supported by this device');
      return;
    }

    if (mounted) {
      setState(() {
        _adapterStateSubscription = _getBluetoothAdapterSubscription();
      });
    }
  }

  @override
  void dispose() {
    _adapterStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bluetooth State'),
            Text(_adapterState.name),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(index: 2),
    );
  }
}
