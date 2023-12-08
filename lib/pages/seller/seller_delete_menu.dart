import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SellerDeleteMenu extends StatefulWidget {
  const SellerDeleteMenu({Key? key}) : super(key: key);

  @override
  _SellerDeleteMenuState createState() => _SellerDeleteMenuState();
}

class _SellerDeleteMenuState extends State<SellerDeleteMenu> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Menu'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _db.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot doc = snapshot.data!.docs[index];
              return ListTile(
                title: Text(doc['namaProduk']),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _db.collection('products').doc(doc.id).delete();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}