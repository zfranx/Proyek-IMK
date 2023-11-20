

import 'package:flutter/material.dart';
import 'package:projek_gede/widgets/product_showcase.dart';

class EtalasePage extends StatefulWidget {
  const EtalasePage({super.key});

  @override
  State<EtalasePage> createState() => _EtalasePageState();
}

class _EtalasePageState extends State<EtalasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text("Etalase"),
      ),
      body: ProductShowcase(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.yellow,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Etalase',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Riwayat & Transaksi',
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}