import 'package:flutter/material.dart';

class Ketiga extends StatefulWidget {
  const Ketiga({super.key});

  @override
  State<Ketiga> createState() => _KetigaState();
}

class _KetigaState extends State<Ketiga> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              alignment: Alignment.topCenter,
              child: const Text(
                "Output dari pabrik otomotif",
                style: TextStyle(fontSize: 24),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Image.asset('assets/images/hasil.png'),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: const [
                            Icon(Icons.engineering, color: Colors.red),
                            SizedBox(height: 8),
                            Text('Quality',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Terjamin'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: const [
                            Icon(Icons.speed, color: Colors.red),
                            SizedBox(height: 8),
                            Text('Performance',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Optimal'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Kembali',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}