import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:projek_gede/pages/seller/seller_etalase_page.dart';

class AddMenu extends StatefulWidget {
  const AddMenu({super.key});

  @override
  State<AddMenu> createState() => _SellerAddMenuState();
}

class _SellerAddMenuState extends State<AddMenu> {
  get result => null;
  File? _image;
  FilePickerResult? resultFileTemp;

   final TextEditingController _namaProduk = TextEditingController();
   final TextEditingController _hargaProduk = TextEditingController();
   final TextEditingController _descProduk = TextEditingController();
   final TextEditingController _toko = TextEditingController();

  

  @override
  void dispose() {
    _namaProduk.dispose();
    _hargaProduk.dispose();
    _descProduk.dispose();
    _toko.dispose();
    super.dispose();
  }


  void openFiles() async {
  FilePickerResult? resultFile = await FilePicker.platform.pickFiles();
  
  
  if (resultFile != null && resultFile.files.single.path != null) {
    setState(() {
      _image = File(resultFile.files.single.path!);
      resultFileTemp = resultFile;
    });
     
    
  } else {
    print('Path tidak ditemukan');
  }
}
  void uploadFiles() async {
  

  if (_image != null && resultFileTemp!=null) {
    
    File? file = _image;
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("namaFolderDitampung/${resultFileTemp!.files.single.name}");

    UploadTask uploadTask = ref.putFile(file!);

    
    TaskSnapshot snapshot = await uploadTask;

    String downloadUrl = await snapshot.ref.getDownloadURL();

    String namaProduk = _namaProduk.text;
    String harga = _hargaProduk.text;
    String deskripsi = _descProduk.text;
    String toko = _toko.text;


    FirebaseFirestore.instance.collection('products').add({
      'namaProduk': namaProduk,
      'harga': harga,
      'deskripsi': deskripsi,
      'toko': toko,
      'imageUrl': downloadUrl,
    })
    .then((value) => print("Berhasil"))
          .catchError((error) => print("Gagal: $error"));
  } else {
    print('Path tidak ditemukan');
  }
}
    // if(resultFile!=null){
    //   PlatformFile file = resultFile.files.first;
    //   print(file.name);
    //   print(file.bytes);
    //   print(file.extension);
    //   print(file.path);
    // }else{

    // }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(90, 90, 90, 90),
        centerTitle: true,
        title: const Text("Tambah Menu"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: GestureDetector(
                onTap: (){
                  openFiles();
                },
                child: Container(
              
                  padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  color: Colors.lightBlue,
                  child: _image == null
                      ? const Text(
                          "Tambah Gambar",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Image.file(_image!),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
               padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: _toko,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nama Toko',
                  hintText: 'Masukkan Nama Tempat Usaha'),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
               padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: _namaProduk,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nama Produk',
                  hintText: 'Masukkan Nama Produk'),
              ),
            ),
             Padding(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                //obscureText: true,
                controller: _hargaProduk,
                decoration: InputDecoration(
                    
                    border: OutlineInputBorder(),
                    labelText: 'Harga',
                    hintText: 'Masukkan Harga'),
              ),
            ),
             Padding(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                //obscureText: true,
                controller: _descProduk,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Deskripsi',
                    hintText: 'Jelaskan Tentang Produk'),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              padding:
                  const EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: ElevatedButton(
                onPressed: () {
                  uploadFiles();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) =>  const SellerEtalasePage()));
                },
                child: const Text(
                  'Tambah',
                  
                ),
              ),
            ),
            
           
 
          ]
        ),
      )
    );
  }
}