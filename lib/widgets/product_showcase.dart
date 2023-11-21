// product_showcase.dart
import 'package:flutter/material.dart';
import 'package:projek_gede/widgets/product_item.dart';

class ProductShowcase extends StatelessWidget {
  ProductShowcase({Key? key});

  final List<Map<String, String>> products = [
    {
      'image': 'pisang 1.jpg',
      'title': 'Pisang coklat',
      'description': 'Pisang Goreng Enak',
      'price': 'Rp 10.000',
    },
    {
      'image': 'pisang2.jpg',
      'title': 'Pisang Goreng Keju',
      'description': 'Description for Product 2',
      'price': 'Rp 20.000',
    },
    // Add more products as needed
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: (products.length / 2).ceil(),
      itemBuilder: (BuildContext context, int rowIndex) {
        return Row(
          children: [
            for (int i = rowIndex * 2;
                i < (rowIndex + 1) * 2 && i < products.length;
                i++)
              Expanded(
                child: ProductItem(
                  image: products[i]['image']!,
                  title: products[i]['title']!,
                  description: products[i]['description']!,
                  price: products[i]['price']!,
                ),
              ),
          ],
        );
      },
    );
  }
}
