import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UDIDScreen extends StatefulWidget {
  @override
  _UDIDScreenState createState() => _UDIDScreenState();
}

class _UDIDScreenState extends State<UDIDScreen> {
  String _udid = 'Unknown';

  @override
  void initState() {
    super.initState();
    _fetchUDID();
  }

  Future<void> _fetchUDID() async {
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Theme.of(context).platform == TargetPlatform.iOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        setState(() {
          _udid = iosInfo.identifierForVendor!; // This may not be UDID but a suitable alternative
        });
      } else {
        setState(() {
          _udid = 'Not available on non-iOS devices';
        });
      }
    } catch (e) {
      setState(() {
        _udid = 'Failed to get UDID';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UDID Fetcher'),
      ),
      body: Center(
        child: Text('UDID: $_udid'),
      ),
    );
  }
}