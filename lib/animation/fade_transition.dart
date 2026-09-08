import 'package:flutter/material.dart';

class FadeExample extends StatefulWidget {
  const FadeExample({super.key});

  @override
  State<FadeExample> createState() => _FadeExampleState();
}

class _FadeExampleState extends State<FadeExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..forward(); // started Animation

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: _animation,
        child: const FlutterLogo(size: 100),
      ),
    );
  }
}
