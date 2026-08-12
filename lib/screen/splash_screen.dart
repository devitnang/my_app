// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/screen/home_screen.dart';
import 'package:my_app/screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isExpanded = false;
  bool _isVisible = false;
  bool _isMoved = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await Future.delayed(Duration(seconds: 1));
    if (!mounted) return;
    setState(() {
      _isExpanded = true;
      _isVisible = true;
      _isMoved = true;
    });

    await Future.delayed(Duration(milliseconds: 2500));

    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString('sv8.16.pos.tokens');
    if (token == null) {
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false,
      );
    } else {
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: AnimatedScale(
              duration: Duration(milliseconds: 800),
              scale: _isExpanded ? 1.5 : 1.0, // 1.0 =>  100%, 1.5 => 150%
              curve: Curves.easeInOut,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 600),
                opacity: _isVisible ? 1.0 : 0.0,
                curve: Curves.easeInOut,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/group.png',
                      width: 85,
                      height: 85,
                      color: Colors.green,
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(right: 14),
                    Transform.translate(
                      offset: Offset(-14, 0),
                      child: SizedBox(
                        width: 160,
                        height: 60,
                        child: Stack(
                          children: [
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 800),
                              curve: Curves.easeOut,
                              top: _isMoved ? 0 : -40,
                              left: 0,
                              child: AnimatedOpacity(
                                duration: Duration(milliseconds: 800),
                                opacity: _isMoved ? 1.0 : 0.0,
                                child: Text(
                                  'nectar',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 41,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    height: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 800),
                              curve: Curves.easeOut,
                              top: _isMoved ? 46 : 86,
                              left: 0,
                              child: AnimatedOpacity(
                                duration: Duration(milliseconds: 800),
                                opacity: _isMoved ? 1.0 : 0.0,
                                child: Text(
                                  'online groceriet',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.green,
                                    height: 1.0,
                                    letterSpacing: 3.3,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation(Colors.green),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
