import 'package:flutter/material.dart';

class SlideExample extends StatefulWidget {
  const SlideExample({super.key});

  @override
  State<SlideExample> createState() => _SlideExampleState();
}

class _SlideExampleState extends State<SlideExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    )..forward();

    // Set the left push movement (-1.0) to the actual position (0.0)
    _offsetAnimation = Tween<Offset>(
      begin: Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SlideTransition(
        position: _offsetAnimation,
        child: FlutterLogo(size: 120),
      ),
    );
  }
}
