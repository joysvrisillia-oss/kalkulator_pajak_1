import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praktikum Widget II',
      home: Scaffold(
        appBar: AppBar(title: const Text("Praktikum Widget II")),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              // 🔹 1. Image
              ImageSection(image: 'assets/images/Giyu.png'),

              // 🔹 2. Title + Star
              TitleSection(name: 'Giyu Tomioka', location: 'Japan'),

              // 🔹 3. Button Section
              ButtonSection(),

              // 🔹 4. Text Section
              TextSection(
                description: "Giyu Tomioka adalah karakter dari Kimetsu No Yaiba. "
                    "Dia adalah Hashira Air yang terkenal dingin, tenang, dan sangat kuat.",
              ),

              // 🔹 5. GridView (dibungkus SizedBox biar tinggi fix)
              SizedBox(
                height: 200,
                child: GridExample(),
              ),

              // 🔹 6. ListView (juga dibungkus SizedBox)
              SizedBox(
                height: 200,
                child: ListExample(),
              ),

              // 🔹 7. Stack
              SizedBox(
                height: 250,
                child: StackExample(),
              ),

              // 🔹 8. Card + ListTile
              CardExample(),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== IMAGE SECTION ====================
class ImageSection extends StatelessWidget {
  final String image;
  const ImageSection({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Image.asset(image, width: 600, height: 240, fit: BoxFit.cover);
  }
}

// ==================== TITLE SECTION ====================
class TitleSection extends StatelessWidget {
  final String name;
  final String location;
  const TitleSection({super.key, required this.name, required this.location});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(location, style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          const Icon(Icons.star, color: Colors.red),
          const Text("41"),
        ],
      ),
    );
  }
}

// ==================== BUTTON SECTION ====================
class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButton(color, Icons.call, "CALL"),
        _buildButton(color, Icons.near_me, "ROUTE"),
        _buildButton(color, Icons.share, "SHARE"),
      ],
    );
  }

  Column _buildButton(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color),
        Text(label, style: TextStyle(fontSize: 12, color: color)),
      ],
    );
  }
}

// ==================== TEXT SECTION ====================
class TextSection extends StatelessWidget {
  final String description;
  const TextSection({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Text(description, softWrap: true),
    );
  }
}

// ==================== GRIDVIEW EXAMPLE ====================
class GridExample extends StatelessWidget {
  const GridExample({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(6, (index) {
        return Card(
          color: Colors.blue[(index + 1) * 100],
          child: Center(child: Text('Item $index')),
        );
      }),
    );
  }
}

// ==================== LISTVIEW EXAMPLE ====================
class ListExample extends StatelessWidget {
  const ListExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(title: Text('Tanjiro Kamado')),
        ListTile(title: Text('Nezuko Kamado')),
        ListTile(title: Text('Zenitsu Agatsuma')),
        ListTile(title: Text('Inosuke Hashibira')),
      ],
    );
  }
}

// ==================== STACK EXAMPLE ====================
class StackExample extends StatelessWidget {
  const StackExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.blue,
          width: double.infinity,
        ),
        Container(
          margin: const EdgeInsets.all(20),
          color: Colors.green.withOpacity(0.7),
        ),
        const Center(
          child: Text(
            "Contoh Stack",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}

// ==================== CARD + LISTTILE EXAMPLE ====================
class CardExample extends StatelessWidget {
  const CardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      child: const ListTile(
        leading: Icon(Icons.info, color: Colors.blue),
        title: Text('Contoh Card + ListTile'),
        subtitle: Text('Ini contoh penggunaan Card dengan ListTile di Flutter'),
      ),
    );
  }
}
