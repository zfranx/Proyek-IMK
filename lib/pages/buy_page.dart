import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BuyPage extends StatefulWidget {
  final Map<String, String> product;

  const BuyPage({Key? key, required this.product}) : super(key: key);

  @override
  State<BuyPage> createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  late Future<DocumentSnapshot> qrFuture;

  @override
  void initState() {
    super.initState();
    qrFuture = fetchQrCode();
  }

  Future<DocumentSnapshot> fetchQrCode() {
    return FirebaseFirestore.instance
        .collection('id')
        .doc(widget.product['toko'])
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(90, 90, 90, 90),
        centerTitle: true,
        title: const Text("Pembelian"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(widget.product['image']!),
              Text(widget.product['title']!, style: TextStyle(fontSize: 24)),
              Text(widget.product['description']!),
              Text('Price: ${widget.product['price']}'),
              Text('Toko: ${widget.product['toko']}'),
              FutureBuilder<DocumentSnapshot>(
                future: qrFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Image.network(snapshot.data!['qrUrl']);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}