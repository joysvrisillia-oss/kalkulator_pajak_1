import 'package:flutter/material.dart';

class GestureDetectorDemo extends StatefulWidget {
  const GestureDetectorDemo({super.key});

  @override
  State<GestureDetectorDemo> createState() => _GestureDetectorDemoState();
}

class _GestureDetectorDemoState extends State<GestureDetectorDemo> {
  String _gestureText = 'Tap, Double Tap, or Long Press';
  Color _boxColor = Colors.blue;

  void _handleTap() {
    setState(() {
      _boxColor = Colors.green;
      _gestureText = 'Tap Gesture!';
    });
  }

  void _handleDoubleTap() {
    setState(() {
      _boxColor = Colors.orange;
      _gestureText = 'Double Tap Gesture!';
    });
  }

  void _handleLongPress() {
    setState(() {
      _boxColor = Colors.purple;
      _gestureText = 'Long Press Gesture!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gesture Detector Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _handleTap,
              onDoubleTap: _handleDoubleTap,
              onLongPress: _handleLongPress,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: _boxColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    _gestureText,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
