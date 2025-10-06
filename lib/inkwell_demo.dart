import 'package:flutter/material.dart';

class InkWellDemo extends StatefulWidget {
  const InkWellDemo({super.key});

  @override
  State<InkWellDemo> createState() => _InkWellDemoState();
}

class _InkWellDemoState extends State<InkWellDemo> {
  int _tapCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('InkWell Demo')),
      body: Center(
        child: InkWell(
          onTap: () => setState(() => _tapCount++),
          borderRadius: BorderRadius.circular(20),
          splashColor: Colors.white.withOpacity(0.5),
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                'Tap Count: $_tapCount',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
