import 'package:flutter/material.dart';
import 'dart:async';
import 'package:projek_gede/pages/etalase_page.dart';
import 'package:projek_gede/pages/seller/seller_add_menu.dart';
import 'package:projek_gede/pages/seller/seller_delete_menu.dart';
import 'package:projek_gede/pages/seller/seller_report_page.dart';
import 'package:projek_gede/widgets/product_showcase.dart';

class SellerEtalasePage extends StatefulWidget {
  const SellerEtalasePage({super.key});

  @override
  State<SellerEtalasePage> createState() => _SellerEtalasePageState();
}

class _SellerEtalasePageState extends State<SellerEtalasePage> {
  final refreshKey = GlobalKey<RefreshIndicatorState>();
  final refreshController = StreamController<void>();

  Future<void> refresh() async {
    refreshController.sink.add(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text("Etalase Penjual"),
      ),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: refresh,
        child: StreamBuilder(
          stream: refreshController.stream,
          builder: (context, snapshot) {
            return ProductShowcase();
          },
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.yellow,
        items: const [
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.home),
          //   label: 'Etalase',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Tambah Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete),
            label: 'Delete Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.align_vertical_bottom),
            label: 'Laporan',
          ),
        ],
        onTap: (int index) {
          if (index == 0) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddMenu()));
          } else if (index == 1) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SellerDeleteMenu()));
          } else if (index == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ReportPage()));
          }
        },
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
