import 'package:flutter/material.dart';

// import 'checkbox_example.dart';
// import 'dropdown_example.dart';
// import 'slider_example.dart';
// import 'textfield_example.dart';

import 'profile_form.dart'; // ini halaman tugas akhir

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Praktikum 05 - Basic Interactivity & Control Input',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      // 👉 Ganti baris "home:" sesuai halaman yang mau kamu jalankan
      // home: CheckboxExampleApp(),
      // home: DropdownMenuApp(),
      // home: SliderApp(),
      // home: TextFieldExampleApp(),
      home: ProfileFormPage(), // halaman akhir dengan tambahan Hobi
    );
  }
}
