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
  List<ScanResult> _deviceList = [];
  BluetoothDevice? _currentDevice;

  late StreamSubscription<BluetoothAdapterState> _adapterStateSubscription;

  void _initBluetooth() async {
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
        if (results.isNotEmpty) {
          ScanResult res = results.last;
          // print(res);

          setState(() {
            _deviceList.add(res);
          });
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

  void _connectDevice(BluetoothDevice device) async {
    print(device);

    StreamSubscription<BluetoothConnectionState> subscription =
        device.connectionState.listen((BluetoothConnectionState state) {
      print(state);
      if (state == BluetoothConnectionState.disconnected) {
        print(device.disconnectReason);
      } else if (state == BluetoothConnectionState.connected) {
        print(device);
      }
    });

    device.cancelWhenDisconnected(subscription, delayed: true, next: true);

    await device.connect();

    await device.disconnect();

    subscription.cancel();
  }

  @override
  void initState() {
    super.initState();

    _initBluetooth();
  }

  @override
  void dispose() {
    _adapterStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Bluetooth State'),
                Text(_adapterState.name),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _deviceList.length,
                  padding: EdgeInsets.all(8),
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemBuilder: (context, index) {
                    ScanResult res = _deviceList[index];
                    return Column(
                      children: [
                        Text(
                          res.device.remoteId.toString(),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          res.advertisementData.advName,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        if (res.advertisementData.connectable)
                          TextButton(
                            onPressed: () {
                              _connectDevice(res.device);
                            },
                            child: Text('Connect'),
                          ),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(index: 2),
    );
  }
}
