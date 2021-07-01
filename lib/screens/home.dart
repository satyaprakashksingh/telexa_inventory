import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String barCode = 'Enter Device ID/Scan Bar Code';
  String qrCode = 'Enter IMEI/Scan QR Code';
  String imei = '';
  String deviceId = '';
  int totalCount = 0;

  @override
  void initState() {
    super.initState();
  }

  String imeiExtractor(String str) {
    List<String> data = [];
    str = str + ';0';
    for (int i = 0; i < str.length; i++) {
      if (str[i] == ':') {
        String newValue = '';
        for (int j = i + 1; j < str.length; j++) {
          if (str[j] == ';') break;
          newValue = newValue + str[j];
        }
        data.add(newValue);
      }
    }
    return data[2];
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);

      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      qrCode = imeiExtractor(barcodeScanRes);
      imei = qrCode;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      barCode = barcodeScanRes;
      deviceId = barCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text('Inventory'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF1EBEA5),
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              backgroundColor: Colors.grey,
              context: context,
              builder: (context) {
                return Container(
                  //backgroundColor: Colors.black12,
                  height: 500,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Center(
                          child: Text(
                            'Add Device',
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'IMEI',
                              hintText: qrCode,
                              suffixIcon: IconButton(
                                onPressed: () => scanQR(),
                                icon: Icon(
                                  Icons.qr_code_scanner,
                                  color: Colors.black87,
                                  size: 35,
                                ),
                              )),
                          onChanged: (newIMEI) {
                            setState(() {
                              imei = newIMEI;
                            });
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Device ID',
                              hintText: barCode,
                              suffixIcon: IconButton(
                                onPressed: () => scanBarcodeNormal(),
                                icon: Icon(
                                  Icons.bar_chart_sharp,
                                  color: Colors.black87,
                                  size: 35,
                                ),
                              )),
                          onChanged: (deviceID) {
                            setState(() {
                              deviceId = deviceID;
                            });
                          },
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(left: 120, right: 120, top: 20.0),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                qrCode = imei;
                                barCode = deviceId;
                              });
                              if (qrCode.length == 15 && barCode.length == 12)
                                setState(() {
                                  totalCount++;
                                });
                              Navigator.pop(context);
                            },
                            child: Text('PROCEED'),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        },
        child: Icon(
          Icons.add,
          size: 35.0,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: Text('Setting'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Help'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: 450,
            width: 350,
            margin: EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Colors.black26,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Total Devices',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                Text(
                  totalCount.toString(),
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text('IMEI : ' +
                    (qrCode.length != 15 ? 'INVALID QR CODE' : qrCode)),
                Text('Device Id : ' +
                    (barCode.length != 12 ? 'INVALID BAR CODE' : barCode)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
