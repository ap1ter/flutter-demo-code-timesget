import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timesget/styles/text_styles.dart';

class BarcodeScanPage extends StatefulWidget {
  @override
  BarcodeScanPageState createState() {
    return new BarcodeScanPageState();
  }
}

class BarcodeScanPageState extends State<BarcodeScanPage> {
  String barcode = "";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: new AppBar(
        title: new Text('Barcode Scanner Example'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: MaterialButton(
                  onPressed: scan, child: new Text("Scan")),
              padding: const EdgeInsets.all(8.0),
            ),
            Text(barcode, style: AppTextStyles.h1),

          ],
        ),
      ),
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() =>
      this.barcode =
      'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}
