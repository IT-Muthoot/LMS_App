import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'View/HomePageView.dart';
import 'View/VisitPageView.dart';
import 'View/formPageVIiew.dart';
import 'firebase_options.dart';
import 'login1.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(

      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => MyApp(),
      )
  );
  // runApp(
  //    MyApp(),
  // );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home:
      // ,));
    //  HomePageView(),
     //FormPageView(),
  //NewLeadPageView()
    //  VisitPageView()
      //FormPageView(),
        LoginScreen(),
     // SaveData(),
    );
  }
}

