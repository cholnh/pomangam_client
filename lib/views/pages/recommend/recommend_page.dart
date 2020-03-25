import 'package:flutter/material.dart';
import 'package:pomangam_client/views/widgets/_bases/tab_selector.dart';

class RecommendPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TabSelector(),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text('recommend page'),
          )
      ),
    );
  }
}
