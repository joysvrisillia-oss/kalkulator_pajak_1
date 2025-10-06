import 'package:flutter/material.dart';

class ResponsiveMediaQueryDemo extends StatelessWidget {
  const ResponsiveMediaQueryDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      appBar: AppBar(title: const Text('Responsive Layout Demo')),
      body: isTablet ? _buildTabletLayout() : _buildPhoneLayout(),
    );
  }

  Widget _buildPhoneLayout() => ListView.builder(
    itemCount: 5,
    itemBuilder: (context, index) => ListTile(
      leading: CircleAvatar(child: Text('${index + 1}')),
      title: Text('Phone Item ${index + 1}'),
      subtitle: const Text('Optimized for mobile'),
    ),
  );

  Widget _buildTabletLayout() => GridView.builder(
    gridDelegate:
    const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    itemCount: 6,
    itemBuilder: (context, index) => Card(
      child: Center(child: Text('Tablet Item ${index + 1}')),
    ),
  );
}
