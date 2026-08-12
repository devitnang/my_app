import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DialogError extends StatelessWidget {
  final String title;
  final String message;
  final String buttonLabel;
  final VoidCallback? onPressed;

  const DialogError({
    super.key,
    this.title = 'Oops!',
    this.message = 'Something went wrong. Please try again.',
    this.buttonLabel = 'Try Again',
    this.onPressed,
  });

  static Future<void> show(
    BuildContext context, {
    String title = 'Oops!',
    String message = 'Something went wrong. Please try again.',
    String buttonLabel = 'Try Again',
    VoidCallback? onPressed, //function to close the dialog
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => DialogError(
        title: title,
        message: message,
        buttonLabel: buttonLabel,
        onPressed: onPressed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(child: _buildContent(context));
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 30,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            'assets/lotties/error.json',
            width: 140,
            height: 140,
            repeat: false,
            fit: BoxFit.cover,
          ),

          SizedBox(height: 12),

          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A2E),
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 10),

          Text(
            message,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black54,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 28),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: onPressed ?? () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFE53935),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                buttonLabel,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
