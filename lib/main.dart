import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const PajakApp());
}

class PajakApp extends StatelessWidget {
  const PajakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pajakin Aja!',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF002366), // navy
          secondary: Color(0xFF87CEEB), // sky blue
        ),
        scaffoldBackgroundColor: const Color(0xFFEAF6FF),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// =================== HALAMAN UTAMA ===================
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color navy = const Color(0xFF002366);
    final Color sky = const Color(0xFF87CEEB);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pajakin Aja!',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: navy,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header dengan gradient dan logo
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [navy, sky],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                children: [
                  // Gambar logo (pastikan file ada di assets/images/logo.png)
                  Image.asset(
                    'assets/images/logo.png',
                    height: 92,
                    errorBuilder: (context, error, stackTrace) {
                      // Jika logo tidak ditemukan, tampilkan ikon fallback
                      return const Icon(Icons.calculate, size: 92, color: Colors.white);
                    },
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Selamat Datang di Pajakin Aja!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Hitung pajak pribadi, bisnis, dan lainnya dengan cepat & akurat',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  MenuCard(
                    icon: Icons.calculate,
                    title: 'Kalkulator Pajak',
                    subtitle: 'PPh, UMKM, PBB & PPN',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const KalkulatorPage()),
                      );
                    },
                  ),
                  MenuCard(
                    icon: Icons.history,
                    title: 'Riwayat Perhitungan',
                    subtitle: 'Daftar perhitungan tersimpan',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RiwayatPage()),
                      );
                    },
                  ),
                  MenuCard(
                    icon: Icons.info_outline,
                    title: 'Panduan & Tips Pajak',
                    subtitle: 'Aturan dan tips singkat',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TipsPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
          ],
        ),
      ),
    );
  }
}

// =================== MENU CARD ===================
class MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  const MenuCard(
      {super.key, required this.icon, required this.title, this.subtitle, this.onTap});

  @override
  Widget build(BuildContext context) {
    final Color navy = const Color(0xFF002366);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        leading: CircleAvatar(
          radius: 22,
          backgroundColor: navy.withOpacity(0.12),
          child: Icon(icon, color: navy, size: 22),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: navy,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: subtitle == null ? null : Text(subtitle!, style: const TextStyle(fontSize: 12)),
        trailing:
        const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
        onTap: onTap,
      ),
    );
  }
}

// =================== HALAMAN KALKULATOR (semua jenis) ===================
class KalkulatorPage extends StatefulWidget {
  const KalkulatorPage({super.key});

  @override
  State<KalkulatorPage> createState() => _KalkulatorPageState();
}

class _KalkulatorPageState extends State<KalkulatorPage> {
  String _jenisPajak = "PPh Pribadi";
  final TextEditingController _inputController = TextEditingController();
  String _hasil = "";
  String _detail = "";

  // Simpan ke SharedPreferences (riwayat)
  Future<void> _simpanRiwayat(String entry) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> list = prefs.getStringList('riwayat') ?? [];
    list.insert(0, entry); // baru paling atas
    await prefs.setStringList('riwayat', list);
  }

  void _hitungPajak() {
    double input = double.tryParse(_inputController.text.replaceAll(',', '')) ?? 0;
    double pajak = 0;
    String keterangan = "";
    String detail = "";

    if (_jenisPajak == "PPh Pribadi") {
      double ptkp = 54000000;
      double pkp = input - ptkp;
      detail = "Penghasilan Bruto: Rp${_formatRupiah(input)}\nPTKP: Rp54.000.000\n";
      if (pkp <= 0) {
        pajak = 0;
        detail += "PKP ≤ 0 → Tidak kena pajak.";
      } else {
        detail += "PKP: Rp${_formatRupiah(pkp)}\n";
        double remaining = pkp;
        double acc = 0;
        // 0-60 jt 5%
        double band = 60000000;
        double take = remaining < band ? remaining : band;
        acc += take * 0.05;
        detail += "0 - 60.000.000 -> ${_formatRupiah(take)} x 5% = ${_formatRupiah(take * 0.05)}\n";
        remaining -= take;
        if (remaining > 0) {
          // 60-250 jt 15%
          band = 250000000 - 60000000;
          take = remaining < band ? remaining : band;
          acc += take * 0.15;
          detail += "60.000.001 - 250.000.000 -> ${_formatRupiah(take)} x 15% = ${_formatRupiah(take * 0.15)}\n";
          remaining -= take;
        }
        if (remaining > 0) {
          // 250-500 jt 25%
          band = 500000000 - 250000000;
          take = remaining < band ? remaining : band;
          acc += take * 0.25;
          detail += "250.000.001 - 500.000.000 -> ${_formatRupiah(take)} x 25% = ${_formatRupiah(take * 0.25)}\n";
          remaining -= take;
        }
        if (remaining > 0) {
          // 500 jt - 5 M : 30%
          band = 5000000000 - 500000000;
          take = remaining < band ? remaining : band;
          acc += take * 0.30;
          detail += "500.000.001 - 5.000.000.000 -> ${_formatRupiah(take)} x 30% = ${_formatRupiah(take * 0.30)}\n";
          remaining -= take;
        }
        if (remaining > 0) {
          acc += remaining * 0.35;
          detail += "> 5.000.000.000 -> ${_formatRupiah(remaining)} x 35% = ${_formatRupiah(remaining * 0.35)}\n";
        }
        pajak = acc;
      }
      keterangan = "PPh Pribadi";
    } else if (_jenisPajak == "Pajak Bisnis (UMKM)") {
      // input dianggap omzet tahunan
      pajak = input * 0.005; // 0.5%
      keterangan = "Pajak UMKM (0.5% dari omzet tahunan)";
      _detail = "Omzet: Rp${_formatRupiah(input)}\nPajak = 0.5% x Omzet = Rp${_formatRupiah(pajak)}";
      detail = _detail;
    } else if (_jenisPajak == "Pajak Lainnya (PBB & PPN)") {
      // input dianggap nilai properti atau nilai penjualan (untuk PPN)
      double pbb = input * 0.001; // 0.1%
      double ppn = input * 0.11; // 11%
      pajak = pbb + ppn;
      keterangan = "PBB (0.1%) + PPN (11%)";
      detail = "Dasar nilai: Rp${_formatRupiah(input)}\nPBB (0.1%) = Rp${_formatRupiah(pbb)}\nPPN (11%) = Rp${_formatRupiah(ppn)}\nTotal = Rp${_formatRupiah(pajak)}";
    }

    // Hasil string ringkas
    final hasilRingkas = "$keterangan • Rp${_formatRupiah(pajak)}";

    // Simpan ke riwayat lengkap (dengan timestamp sederhana)
    final waktu = DateTime.now();
    final entry = "${waktu.toIso8601String()}|$keterangan|${_formatRupiah(input)}|${pajak.toStringAsFixed(0)}|$detail";

    // Update UI dan simpan
    setState(() {
      _hasil = hasilRingkas;
      _detail = detail;
    });

    // Simpan ke SharedPreferences
    _simpanRiwayat(entry);

    // Tampilkan snackbar konfirmasi
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Hasil disimpan ke riwayat"),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Format angka sederhana (tanpa library tambahan)
  String _formatRupiah(double value) {
    if (value == value.roundToDouble()) {
      // jika bilangan bulat
      return value.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+$)'), (m) => '${m[1]}.');
    } else {
      return value.toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+\.)'), (m) => '${m[1]}.');
    }
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color navy = const Color(0xFF002366);
    final Color sky = const Color(0xFF87CEEB);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Kalkulator Pajak Lengkap",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: navy,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          DropdownButtonFormField<String>(
            value: _jenisPajak,
            items: const [
              DropdownMenuItem(value: "PPh Pribadi", child: Text("PPh Pribadi")),
              DropdownMenuItem(value: "Pajak Bisnis (UMKM)", child: Text("Pajak Bisnis (UMKM)")),
              DropdownMenuItem(value: "Pajak Lainnya (PBB & PPN)", child: Text("Pajak Lainnya (PBB & PPN)")),
            ],
            onChanged: (value) {
              setState(() => _jenisPajak = value!);
            },
            decoration: InputDecoration(
              labelText: "Pilih Jenis Pajak",
              prefixIcon: const Icon(Icons.list_alt),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 18),
          TextField(
            controller: _inputController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: _jenisPajak == "PPh Pribadi"
                  ? "Masukkan penghasilan bruto tahunan (Rp)"
                  : _jenisPajak == "Pajak Bisnis (UMKM)"
                  ? "Masukkan omzet tahunan (Rp)"
                  : "Masukkan nilai properti/barang (Rp)",
              prefixIcon: const Icon(Icons.money),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _hitungPajak,
            icon: const Icon(Icons.calculate),
            label: const Text("Hitung & Simpan"),
            style: ElevatedButton.styleFrom(
              backgroundColor: navy,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 22),
          if (_hasil.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: sky.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: sky.withOpacity(0.6)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    _hasil,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  const Text("Rincian perhitungan:", style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Text(_detail),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// =================== HALAMAN RIWAYAT ===================
class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  List<String> _riwayat = [];

  Future<void> _loadRiwayat() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _riwayat = prefs.getStringList('riwayat') ?? [];
    });
  }

  Future<void> _hapusAll() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text("Hapus semua riwayat?"),
        content: const Text("Semua data riwayat akan dihapus permanen."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: const Text("Batal")),
          TextButton(onPressed: () => Navigator.pop(c, true), child: const Text("Hapus", style: TextStyle(color: Colors.red))),
        ],
      ),
    );
    if (confirm == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('riwayat');
      await _loadRiwayat();
    }
  }

  Future<void> _hapusItem(int index) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text("Hapus riwayat ini?"),
        content: const Text("Item akan dihapus dari penyimpanan lokal."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: const Text("Batal")),
          TextButton(onPressed: () => Navigator.pop(c, true), child: const Text("Hapus", style: TextStyle(color: Colors.red))),
        ],
      ),
    );
    if (confirm == true) {
      final prefs = await SharedPreferences.getInstance();
      List<String> list = prefs.getStringList('riwayat') ?? [];
      list.removeAt(index);
      await prefs.setStringList('riwayat', list);
      await _loadRiwayat();
    }
  }

  @override
  void initState() {
    super.initState();
    _loadRiwayat();
  }

  // Membaca format entry yang kita simpan:
  // "${iso}|$keterangan|${inputFormatted}|${pajakInt}|${detail}"
  Map<String, String> _parseEntry(String raw) {
    final parts = raw.split('|');
    return {
      'time': parts.isNotEmpty ? parts[0] : '',
      'type': parts.length > 1 ? parts[1] : '',
      'input': parts.length > 2 ? parts[2] : '',
      'pajak': parts.length > 3 ? parts[3] : '',
      'detail': parts.length > 4 ? parts.sublist(4).join('|') : '',
    };
  }

  @override
  Widget build(BuildContext context) {
    final Color navy = const Color(0xFF002366);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Perhitungan"),
        backgroundColor: navy,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: _riwayat.isEmpty ? null : _hapusAll,
            tooltip: "Hapus semua",
          ),
        ],
      ),
      body: _riwayat.isEmpty
          ? const Center(child: Text("Belum ada riwayat perhitungan"))
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _riwayat.length,
        itemBuilder: (context, index) {
          final entry = _parseEntry(_riwayat[index]);
          final time = entry['time'] ?? '';
          final type = entry['type'] ?? '';
          final input = entry['input'] ?? '';
          final pajak = entry['pajak'] ?? '';
          final detail = entry['detail'] ?? '';
          String title = "$type • Rp${_formatDisplay(pajak)}";
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              leading: CircleAvatar(backgroundColor: navy.withOpacity(0.12), child: Icon(Icons.receipt_long, color: navy)),
              title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text("Input: Rp$input\nWaktu: ${_formatTime(time)}"),
              isThreeLine: true,
              trailing: PopupMenuButton<String>(
                onSelected: (v) {
                  if (v == 'hapus') _hapusItem(index);
                  if (v == 'detail') {
                    showDialog(context: context, builder: (c) => AlertDialog(
                      title: const Text("Detail Perhitungan"),
                      content: SingleChildScrollView(child: Text(detail)),
                      actions: [TextButton(onPressed: () => Navigator.pop(c), child: const Text("Tutup"))],
                    ));
                  }
                },
                itemBuilder: (c) => [
                  const PopupMenuItem(value: 'detail', child: Text('Lihat detail')),
                  const PopupMenuItem(value: 'hapus', child: Text('Hapus', style: TextStyle(color: Colors.red))),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatTime(String iso) {
    try {
      final dt = DateTime.parse(iso);
      return "${dt.day.toString().padLeft(2,'0')}/${dt.month.toString().padLeft(2,'0')}/${dt.year} ${dt.hour.toString().padLeft(2,'0')}:${dt.minute.toString().padLeft(2,'0')}";
    } catch (e) {
      return iso;
    }
  }

  String _formatDisplay(String numStr) {
    // numStr adalah angka tanpa titik misal "1234567.0" -> kita format sederhana
    try {
      final val = double.tryParse(numStr) ?? 0.0;
      return val.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+$)'), (m) => '${m[1]}.');
    } catch (e) {
      return numStr;
    }
  }
}

// =================== HALAMAN TIPS & PANDUAN ===================
class TipsPage extends StatelessWidget {
  const TipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color navy = const Color(0xFF002366);

    return Scaffold(
      appBar: AppBar(title: const Text('Panduan & Tips Pajak'), backgroundColor: navy),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text("Deskripsi:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 8),
          Text(
              "Aplikasi ini membantu pengguna menghitung pajak pribadi atau bisnis berdasarkan aturan perpajakan yang berlaku. Fitur utamanya antara lain:"),
          SizedBox(height: 8),
          Text("1. Perhitungan pajak penghasilan (PPh) berdasarkan pendapatan."),
          Text("2. Simulasi pajak untuk usaha atau bisnis kecil (UMKM)."),
          Text("3. Fitur kalkulasi pajak tambahan (PBB, PPN)."),
          Text("4. Riwayat perhitungan pajak untuk keperluan arsip."),
          Text("5. Panduan dan tips perpajakan sesuai aturan terbaru."),
          SizedBox(height: 14),
          Text("Tips singkat:", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text("• Catat semua pemasukan dan pengeluaran usaha secara teratur."),
          Text("• Simpan bukti transaksi untuk memudahkan pelaporan."),
          Text("• Manfaatkan PTKP jika memenuhi syarat (Rp54.000.000 untuk TK/0)."),
          Text("• Bayar dan lapor pajak tepat waktu untuk menghindari denda."),
        ],
      ),
    );
  }
}
