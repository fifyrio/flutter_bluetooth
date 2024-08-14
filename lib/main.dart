import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bluetooth Earphones',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BluetoothList(),
    );
  }
}

class BluetoothList extends StatefulWidget {
  @override
  _BluetoothListState createState() => _BluetoothListState();
}

class _BluetoothListState extends State<BluetoothList> {
  List<BluetoothDevice> _devices = [];
  final FlutterBlue _flutterBlue = FlutterBlue.instance;

  @override
  void initState() {
    super.initState();
    _getConnectedDevices();
  }

  void _getConnectedDevices() {
    _flutterBlue.connectedDevices.then((List<BluetoothDevice> devices) {
      setState(() {
        _devices = devices;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connected Bluetooth Devices'),
      ),
      body: ListView.builder(
        itemCount: _devices.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_devices[index].name.isEmpty ? 'Unnamed Device' : _devices[index].name),
            subtitle: Text(_devices[index].id.toString()),
          );
        },
      ),
    );
  }
}
