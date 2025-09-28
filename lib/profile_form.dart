import 'package:flutter/material.dart';

class ProfileFormPage extends StatefulWidget {
  const ProfileFormPage({super.key});

  @override
  State<ProfileFormPage> createState() => _ProfileFormPageState();
}

class _ProfileFormPageState extends State<ProfileFormPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String _selectedGender = "Laki-laki";
  bool _isAgreed = false;
  double _age = 18;

  final List<String> _genders = ["Laki-laki", "Perempuan"];

  // State untuk Hobi
  Map<String, bool> hobbies = {
    "Olahraga": false,
    "Musik": false,
    "Membaca": false,
    "Bermain Game": false,
  };

  void _submitForm() {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        !_isAgreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lengkapi semua data dan setujui syarat!")),
      );
      return;
    }

    final selectedHobbies =
    hobbies.entries.where((e) => e.value).map((e) => e.key).join(", ");

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Profil Anda"),
          content: Text(
            "Nama: ${_nameController.text}\n"
                "Email: ${_emailController.text}\n"
                "Gender: $_selectedGender\n"
                "Usia: ${_age.round()}\n"
                "Hobi: ${selectedHobbies.isNotEmpty ? selectedHobbies : '-'}",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Input Profil")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // Nama
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Nama",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            // Email
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),

            // Dropdown Gender
            DropdownButtonFormField<String>(
              value: _selectedGender,
              items: _genders
                  .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedGender = value!;
                });
              },
              decoration: const InputDecoration(
                labelText: "Jenis Kelamin",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            // Slider Usia
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Usia: ${_age.round()} tahun"),
                Slider(
                  value: _age,
                  min: 10,
                  max: 60,
                  divisions: 50,
                  label: _age.round().toString(),
                  onChanged: (value) {
                    setState(() {
                      _age = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Hobi
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Hobi:"),
                ...hobbies.keys.map((String key) {
                  return CheckboxListTile(
                    title: Text(key),
                    value: hobbies[key],
                    onChanged: (value) {
                      setState(() {
                        hobbies[key] = value!;
                      });
                    },
                  );
                }).toList(),
              ],
            ),
            const SizedBox(height: 12),

            // Persetujuan
            CheckboxListTile(
              title: const Text("Saya menyetujui persyaratan"),
              value: _isAgreed,
              onChanged: (value) {
                setState(() {
                  _isAgreed = value!;
                });
              },
            ),
            const SizedBox(height: 12),

            // Tombol Submit
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
