import 'package:flutter/material.dart';

class AdvancedResponsiveLayoutBuilder extends StatelessWidget {
  const AdvancedResponsiveLayoutBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Advanced Responsive Demo')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 800;
          final crossAxisCount = isWide ? 4 : 2;
          final aspectRatio = isWide ? 1.2 : 0.8;

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: aspectRatio,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            itemCount: 8,
            itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                color: Colors.primaries[index % Colors.primaries.length],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text('Item ${index + 1}',
                    style: const TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          );
        },
      ),
    );
  }
}
