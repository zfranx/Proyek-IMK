import 'package:flutter/material.dart';
import 'package:projek_gede/widgets/product_item.dart';

class ProductShowcase extends StatelessWidget {
  const ProductShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2, // Set the number of rows per page (2 products per row).
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
            Expanded(
              child: ProductItem(
                image: 'pisang2.jpg',
                title: 'Pisang Goreng Keju',
                description: 'Description for Product 2',
                price: 'Rp 20.000',
              ),
            ),
          ],
        );
      },
    );
  }
}
