import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projek_gede/widgets/product_item.dart';

class ProductShowcase extends StatefulWidget {
  ProductShowcase({Key? key});

  @override
  _ProductShowcaseState createState() => _ProductShowcaseState();
}

class _ProductShowcaseState extends State<ProductShowcase> {
  late Future<List<Map<String, dynamic>>> productsFuture;

  @override
  void initState() {
    super.initState();
    productsFuture = fetchProducts();
  }

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('products').get();

    return snapshot.docs.map((doc) {
      return {
        'image': doc['imageUrl'],
        'title': doc['namaProduk'],
        'description': doc['deskripsi'],
        'price': doc['harga'],
        'Toko': doc['toko'],
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: productsFuture,
      builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Map<String, dynamic>> products = snapshot.data!;
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
                        toko: products[i]['Toko']!,
                      ),
                    ),
                ],
              );
            },
          );
        }
      },
    );
  }
}