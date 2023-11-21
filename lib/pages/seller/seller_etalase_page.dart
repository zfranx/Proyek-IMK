import 'package:flutter/material.dart';
import 'package:projek_gede/pages/etalase_page.dart';
import 'package:projek_gede/pages/seller/seller_add_menu.dart';
import 'package:projek_gede/widgets/product_showcase.dart';

class SellerEtalasePage extends StatefulWidget {
  const SellerEtalasePage({super.key});

  @override
  State<SellerEtalasePage> createState() => _SellerEtalasePageState();
}

class _SellerEtalasePageState extends State<SellerEtalasePage> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text("Etalase Penjual"),
      ),
      body: ProductShowcase(
      
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.yellow,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Etalase',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Tambah Menu',
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Riwayat & Transaksi',
          ),
          
        ],
        onTap: (int index){
          if (index == 1){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>AddMenu()));
          };
        },
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}