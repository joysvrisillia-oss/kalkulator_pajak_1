import 'package:flutter/material.dart';
import 'third.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Proses Pabrik"), backgroundColor: Colors.red),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/process.png"),
          SizedBox(height: 10),
          Text(
            "Pasir silika diproses melalui tahap pencucian, pemurnian, "
                "dan pengeringan untuk menghilangkan kotoran serta mineral "
                "pengganggu. Hasilnya adalah pasir silika murni yang kemudian "
                "dipanaskan pada suhu tinggi sebagai bahan utama pembuatan kaca.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ThirdPage()),
              );
            },
            child: Text("Lanjut ke Output"),
          ),
        ],
      ),
    );
  }
}
