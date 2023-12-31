// product_item.dart
import 'package:flutter/material.dart';
import 'package:projek_gede/pages/rinci_page.dart';

class ProductItem extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String price;
  final String toko;

  const ProductItem({
    required this.image,
    required this.title,
    required this.description,
    required this.toko,
    required this.price, 
  });
  
  

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: TextButton(
        
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RinciPage(
                product: {
                  'image': image,
                  'title': title,
                  'description': description,
                  'price': price,
                  'Toko' : toko,
                },
              ),
            ),
          );
        },
        child: Column(
          children: <Widget>[
            Image.network(
              image,
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
            ListTile(
              title: Text(title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(description),
                  Text(
                    '$price',
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
