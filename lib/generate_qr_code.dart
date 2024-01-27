import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class GenerateQRCode extends StatefulWidget {
  const GenerateQRCode({Key? key}) : super(key: key);

  @override
  _GenerateQRCodeState createState() => _GenerateQRCodeState();
  
}

class _GenerateQRCodeState extends State<GenerateQRCode> {
  var urlController = TextEditingController();

  void _shareImage(QrImageView imgView) async {
    var dir = (await getApplicationDocumentsDirectory()).path;
    var file = File("$dir/qr.png");
    QrPainter painter = QrPainter(data: urlController.text, version: QrVersions.auto, gapless: true, errorCorrectionLevel: QrErrorCorrectLevel.L);
    var imageData = await painter.toImageData(600.0);
    await file.writeAsBytes(imageData!.buffer.asUint8List());
    XFile xfile = XFile(file.path);
    Share.shareXFiles([xfile]);
  }

  @override
  Widget build(BuildContext context) {
    var qrImg = QrImageView(data: urlController.text, size: 200,);
    return Scaffold(
      appBar: AppBar(title: const Text("Generate QR Code")),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if(urlController.text.isNotEmpty)
                qrImg,
              const SizedBox(height: 10,),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  controller: urlController,
                  decoration: InputDecoration(
                    hintText: "Enter your data",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    labelText: "Enter your data"
                  ),
                )
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () => setState(() { /* qr code must update */ }),
                    child: const Text("Generate")
                  ),
                  if(Platform.isAndroid && urlController.text.isNotEmpty) ...[
                    const SizedBox(width: 4,),
                    ElevatedButton(
                      onPressed: () {
                        _shareImage(qrImg);
                      },
                      child: const Icon(Icons.share),
                    ),
                  ]
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}