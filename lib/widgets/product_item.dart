import 'package:flutter/material.dart';
import 'package:projek_gede/pages/rinci_page.dart';

class ProductItem extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String price;

  const ProductItem({
    required this.image,
    required this.title,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          onPressed: () {
            print("ki");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RinciPage(),
              ),
            );
          },
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/$image', // Assuming images are in the "assets" directory
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              ListTile(
                title: Text(title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(description),
                    Text(
                      'Price: $price',
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
        ));
  }
}
