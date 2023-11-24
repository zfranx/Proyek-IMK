import 'package:flutter/material.dart';
import 'package:projek_gede/pages/buy_page.dart';

class RinciPage extends StatelessWidget {
  final Map<String, String> product;

  const RinciPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['title'] ?? 'Product Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Product Image
            Image.asset(
              'assets/${product['image']}',
              height: 250,
              fit: BoxFit.cover,
            ),

            // Product Details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Title
                  Text(
                    product['title'] ?? '',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Product Price
                  SizedBox(height: 8),
                  Text(
                    'Price: ${product['price'] ?? ''}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),

                  // Product Description
                  SizedBox(height: 16),
                  Text(
                    product['description'] ?? '',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 8.0), // Add some space on the right
              child: ElevatedButton(
                 onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const BuyPage()));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  
                  child: Text(
                    'Buy Now',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
            // Expanded(
            //   child: ElevatedButton(
            //     onPressed: () {
            //       // Implement logic for adding to cart or buying the product
            //     },
            //     style: ElevatedButton.styleFrom(
            //       primary: Colors.orange,
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.all(12.0),
            //       child: Text(
            //         'Add to Cart',
            //         style: TextStyle(fontSize: 18),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
