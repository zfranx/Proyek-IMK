import 'package:flutter/material.dart';

class Rincian extends StatelessWidget {
  const Rincian({super.key});
  
  get itemCount => 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pisang Goreng"),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget> [
        itemCount: 1, // Set the number of rows per page (2 products per row).
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              Expanded(
                child: ProductItem(
                  image: 'pisang 1.jpg',
                  title: 'Pisang coklat',
                  description: 'Pisang Goreng Enak',
                  price: 'Rp 10.000',
                ),
              ),
        ], 
      ),
    )
    );
  }
}