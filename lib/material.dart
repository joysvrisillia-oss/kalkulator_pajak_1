import 'package:flutter/material.dart';

void main() {
  runApp(const PajakApp());
}

class PajakApp extends StatelessWidget {
  const PajakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator Pajak',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
      ),
      home: const HomePage(),
    );
  }
}

//
// ==========================
// 📍 HALAMAN UTAMA
// ==========================
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kalkulator Pajak')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const FlutterLogo(size: 100),
            const SizedBox(height: 16),
            const Text(
              'Selamat Datang di Kalkulator Pajak',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Reusable widget TaxCard
            TaxCard(
              title: 'PPh Pribadi',
              icon: Icons.person,
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const PphPage()));
              },
            ),
            TaxCard(
              title: 'Pajak Bisnis Kecil',
              icon: Icons.store,
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const BisnisPage()));
              },
            ),
            TaxCard(
              title: 'Pajak Lainnya (PBB, PPN)',
              icon: Icons.receipt_long,
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const LainnyaPage()));
              },
            ),
            TaxCard(
              title: 'Riwayat Perhitungan',
              icon: Icons.history,
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const RiwayatPage()));
              },
            ),
            TaxCard(
              title: 'Panduan & Tips Pajak',
              icon: Icons.info_outline,
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const PanduanPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

//
// ==========================
// 🧱 WIDGET TAX CARD
// ==========================
class TaxCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const TaxCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, size: 40, color: Colors.green),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16)
            ],
          ),
        ),
      ),
    );
  }
}

//
// ==========================
// 📄 HALAMAN PPH PRIBADI
// ==========================
class PphPage extends StatefulWidget {
  const PphPage({super.key});

  @override
  State<PphPage> createState() => _PphPageState();
}

class _PphPageState extends State<PphPage> {
  final TextEditingController incomeController = TextEditingController();
  double result = 0;

  void hitungPph() {
    final income = double.tryParse(incomeController.text) ?? 0;
    setState(() {
      result = income * 0.05; // 5% simulasi PPh
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PPh Pribadi')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: incomeController,
              decoration: const InputDecoration(
                labelText: 'Masukkan Penghasilan (Rp)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: hitungPph,
              child: const Text('Hitung Pajak'),
            ),
            const SizedBox(height: 16),
            Text(
              'Hasil Pajak: Rp ${result.toStringAsFixed(0)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

//
// ==========================
// 📄 HALAMAN LAINNYA
// ==========================
class BisnisPage extends StatelessWidget {
  const BisnisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pajak Bisnis Kecil')),
      body: const Center(
        child: Text('Simulasi Pajak Bisnis Kecil'),
      ),
    );
  }
}

class LainnyaPage extends StatelessWidget {
  const LainnyaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pajak Lainnya')),
      body: const Center(
        child: Text('Perhitungan PBB, PPN, dll.'),
      ),
    );
  }
}

class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Pajak')),
      body: const Center(
        child: Text('Riwayat perhitungan pajak akan muncul di sini.'),
      ),
    );
  }
}

class PanduanPage extends StatelessWidget {
  const PanduanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Panduan Pajak')),
        body: const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Tips dan panduan pajak:\n\n'
                  '1. Gunakan NPWP yang valid.\n'
                  '2. Simpan bukti potong pajak.\n'
                  '3. Gunakan e-filing untuk pelaporan.',
              style: TextStyle(fontSize: 16),
            ),
             ),
            );
      }
}