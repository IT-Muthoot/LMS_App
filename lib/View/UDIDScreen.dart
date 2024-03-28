
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unique_identifier/unique_identifier.dart';

class UDIDScreen extends StatefulWidget {
  @override
  _UDIDScreenState createState() => _UDIDScreenState();
}

class _UDIDScreenState extends State<UDIDScreen> {
  String? _identifier = 'Unknown';

  @override
  void initState() {
    super.initState();
    initUniqueIdentifierState();
  }

  Future<void> initUniqueIdentifierState() async {
    String? identifier;
    try {
      identifier = await UniqueIdentifier.serial;
    } on PlatformException {
      identifier = 'Failed to get Unique Identifier';
    }

    if (!mounted) return;

    setState(() {
      _identifier = identifier;
    });
    print("jfkjbdf");
    print(_identifier);
    //0C073090-B1C6-4A33-A777-84E64F71FF90
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new Center(
          child: new Text('Running on device with id: $_identifier\n'),
        ),
      ),
    );
  }
}