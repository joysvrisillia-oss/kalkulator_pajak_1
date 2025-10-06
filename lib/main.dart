import 'package:flutter/material.dart';

// Import semua file praktikum
import 'gesture_detector_demo.dart';
import 'drag_swipe_demo.dart';
import 'responsive_mediaquery_demo.dart';
import 'advanced_responsive_layoutbuilder.dart';
import 'inkwell_demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestures & Responsivity Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> demos = [
      {
        'title': '1️⃣ Gesture Detector Demo',
        'page': const GestureDetectorDemo(),
      },
      {
        'title': '2️⃣ Drag & Swipe Demo',
        'page': const DragSwipeDemo(),
      },
      {
        'title': '3️⃣ Responsive (MediaQuery)',
        'page': const ResponsiveMediaQueryDemo(),
      },
      {
        'title': '4️⃣ Advanced Responsive (LayoutBuilder)',
        'page': const AdvancedResponsiveLayoutBuilder(),
      },
      {
        'title': '5️⃣ InkWell with Ripple Effect',
        'page': const InkWellDemo(),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestures & Responsivity'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: demos.length,
        itemBuilder: (context, index) {
          final item = demos[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 4,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor:
                Colors.primaries[index % Colors.primaries.length],
                child: Text('${index + 1}',
                    style: const TextStyle(color: Colors.white)),
              ),
              title: Text(item['title']),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => item['page']),
              ),
            ),
          );
        },
      ),
    );
  }
}