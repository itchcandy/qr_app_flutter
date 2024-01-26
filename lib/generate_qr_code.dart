import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQRCode extends StatefulWidget {
  const GenerateQRCode({Key? key}) : super(key: key);

  @override
  _GenerateQRCodeState createState() => _GenerateQRCodeState();
  
}

class _GenerateQRCodeState extends State<GenerateQRCode> {
  var urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Generate QR Code")),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if(urlController.text.isNotEmpty)
                QrImageView(data: urlController.text, size: 200,),
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
              ElevatedButton(
                onPressed: () => setState(() { }),
                child: const Text("Generate QR Code")),
            ],
          ),
        ),
      ),
    );
  }
}