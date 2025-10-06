import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const PajakinAjaApp());
}

class PajakinAjaApp extends StatelessWidget {
  const PajakinAjaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pajakin Aja!',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const KalkulatorPage(),
    const RiwayatPage(),
    const TipsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: "Kalkulator"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Riwayat"),
          BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: "Tips"),
        ],
      ),
    );
  }
}

// ================= HALAMAN KALKULATOR =================
class KalkulatorPage extends StatefulWidget {
  const KalkulatorPage({super.key});

  @override
  State<KalkulatorPage> createState() => _KalkulatorPageState();
}

class _KalkulatorPageState extends State<KalkulatorPage> {
  final TextEditingController _controller = TextEditingController();
  String _hasil = "";

  // ================= FUNGSI HITUNG PAJAK =================
  double hitungPajak(double penghasilan) {
    double ptkp = 54000000; // PTKP dasar (TK/0)
    double pkp = penghasilan - ptkp;

    if (pkp <= 0) {
      return 0;
    }

    double pajak = 0;

    if (pkp <= 60000000) {
      pajak = pkp * 0.05;
    } else if (pkp <= 250000000) {
      pajak = 60000000 * 0.05 + (pkp - 60000000) * 0.15;
    } else if (pkp <= 500000000) {
      pajak = 60000000 * 0.05 +
          (250000000 - 60000000) * 0.15 +
          (pkp - 250000000) * 0.25;
    } else if (pkp <= 5000000000) {
      pajak = 60000000 * 0.05 +
          (250000000 - 60000000) * 0.15 +
          (500000000 - 250000000) * 0.25 +
          (pkp - 500000000) * 0.30;
    } else {
      pajak = 60000000 * 0.05 +
          (250000000 - 60000000) * 0.15 +
          (500000000 - 250000000) * 0.25 +
          (5000000000 - 500000000) * 0.30 +
          (pkp - 5000000000) * 0.35;
    }

    return pajak;
  }

  // ================= SIMPAN RIWAYAT =================
  Future<void> simpanRiwayat(String teks) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> riwayat = prefs.getStringList('riwayat') ?? [];
    riwayat.add(teks);
    await prefs.setStringList('riwayat', riwayat);
  }

  // ================= PROSES HITUNG =================
  void _prosesHitung() {
    if (_controller.text.isEmpty) return;

    double penghasilan = double.tryParse(_controller.text) ?? 0;
    double pajak = hitungPajak(penghasilan);

    String teks = "Penghasilan: Rp${penghasilan.toStringAsFixed(0)}\n"
        "PTKP: Rp54.000.000\n"
        "Pajak Terutang: Rp${pajak.toStringAsFixed(0)}";

    setState(() {
      _hasil = teks;
    });

    simpanRiwayat(teks);
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pajakin Aja! - Kalkulator Pajak 2025")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Hitung pajak penghasilan pribadi sesuai tarif terbaru (2025)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Masukkan penghasilan bruto tahunan (Rp)",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.money),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _prosesHitung,
              child: const Text("Hitung Pajak"),
            ),
            const SizedBox(height: 16),
            Text(
              _hasil,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= HALAMAN RIWAYAT =================
class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  List<String> _riwayat = [];

  Future<void> loadRiwayat() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _riwayat = prefs.getStringList('riwayat') ?? [];
    });
  }

  Future<void> hapusRiwayat() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('riwayat');
    loadRiwayat();
  }

  @override
  void initState() {
    super.initState();
    loadRiwayat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pajakin Aja! - Riwayat Perhitungan"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: hapusRiwayat,
          ),
        ],
      ),
      body: _riwayat.isEmpty
          ? const Center(child: Text("Belum ada riwayat perhitungan"))
          : ListView.builder(
        itemCount: _riwayat.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: const Icon(Icons.receipt_long),
              title: Text(_riwayat[index]),
            ),
          );
        },
      ),
    );
  }
}

// ================= HALAMAN TIPS =================
class TipsPage extends StatelessWidget {
  const TipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pajakin Aja! - Tips Pajak 2025")),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            "Tips Mengelola Pajak Pribadi (2025):\n\n"
                "1️. Gunakan tarif pajak terbaru: 5%, 15%, 25%, 30%, dan 35% sesuai UU HPP.\n\n"
                "2️. Catat semua pemasukan dan pengeluaran usahamu secara teratur.\n\n"
                "3️. Simpan bukti transaksi & laporan keuangan dengan rapi.\n\n"
                "4️. Manfaatkan PTKP Rp54 juta untuk wajib pajak individu.\n\n"
                "5️. Gunakan aplikasi Pajakin Aja! untuk menghitung pajak dengan cepat & akurat.\n\n"
                "6️. Lapor dan bayar pajak tepat waktu untuk menghindari denda keterlambatan.\n\n",
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
      ),
    );
  }
}
