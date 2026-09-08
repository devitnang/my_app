import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_app/animation/fade_slide_transition.dart';
import 'package:my_app/providers/app_provider.dart';
import 'package:my_app/routes/app_route.dart';
import 'package:my_app/animation/fade_transition.dart';
import 'package:my_app/animation/slide_transition.dart';
import 'package:my_app/screen/home_screen.dart';
import 'package:my_app/screen/login_screen.dart';
import 'package:my_app/screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(
    DevicePreview(
      enabled: kDebugMode,
      defaultDevice: Devices.ios.iPhone16ProMax,
      builder: (context) {
        return MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProvider.getProviders(),
      child: MaterialApp(
        // home: SplashScreen(),
        initialRoute: AppRoutes.root,
        routes: {
          AppRoutes.root: (context) => SplashScreen(),
          AppRoutes.home: (context) => HomeScreen(),
          AppRoutes.login: (context) => LoginScreen(),
        },

        theme: ThemeData(
          fontFamily: 'Poppins',
          primaryColor: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarThemeData(backgroundColor: Colors.blue),
          // useMaterial3: false,
        ),
      ),
    );
  }
}
