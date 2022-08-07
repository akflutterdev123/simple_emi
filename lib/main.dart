//@dart=2.9
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  // MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
  //     testDeviceIds: ['B20E5DB060DC9DD6A77DC115AA2BC39C']));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  Map<int, Color> color = {
    50: const Color(0xffbd5837),
    100: const Color(0xffbd5837),
    200: const Color(0xffbd5837),
    300: const Color(0xffbd5837),
    400: const Color(0xffbd5837),
    500: const Color(0xffbd5837),
    600: const Color(0xffbd5837),
    700: const Color(0xffbd5837),
    800: const Color(0xffbd5837),
    900: const Color(0xffbd5837),
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (p0, p1, p2) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(primarySwatch: MaterialColor(0xffbd5837, color)),
          home: const HomeView(),
        );
      },
    );
  }
}
