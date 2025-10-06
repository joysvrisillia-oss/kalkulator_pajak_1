import 'package:flutter/material.dart';

class DragSwipeDemo extends StatefulWidget {
  const DragSwipeDemo({super.key});

  @override
  State<DragSwipeDemo> createState() => _DragSwipeDemoState();
}

class _DragSwipeDemoState extends State<DragSwipeDemo> {
  double _positionX = 100;
  double _positionY = 100;
  String _dragInfo = 'Drag the box!';

  void _onPanStart(DragStartDetails details) {
    setState(() => _dragInfo = 'Drag started!');
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _positionX += details.delta.dx;
      _positionY += details.delta.dy;
      _dragInfo = 'Dragging... X: ${_positionX.toInt()}, Y: ${_positionY.toInt()}';
    });
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() => _dragInfo = 'Drag ended!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Drag & Swipe Demo')),
      body: Stack(
        children: [
          Positioned(
            left: _positionX,
            top: _positionY,
            child: GestureDetector(
              onPanStart: _onPanStart,
              onPanUpdate: _onPanUpdate,
              onPanEnd: _onPanEnd,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.touch_app, color: Colors.white, size: 40),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: Text(_dragInfo, style: const TextStyle(fontSize: 18)),
            ),
          )
        ],
      ),
    );
  }
}
