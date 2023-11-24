import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:projek_gede/pages/seller/seller_etalase_page.dart';

class AddMenu extends StatefulWidget {
  const AddMenu({super.key});

  @override
  State<AddMenu> createState() => _SellerAddMenuState();
}

class _SellerAddMenuState extends State<AddMenu> {
  
  void openFiles() async {
    FilePickerResult? resultFile=await FilePicker.platform.pickFiles();
    if(resultFile!=null){
      PlatformFile file = resultFile.files.first;
      print(file.name);
      print(file.bytes);
      print(file.extension);
      print(file.path);
    }else{

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(90, 90, 90, 90),
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
                  width: 100,
                  height: 50,
                  padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
                  color: Colors.lightBlue,
                  child: const Text("Tambah Gambar",
                  style: TextStyle(color: Color.fromARGB(255, 24, 23, 23), fontWeight: FontWeight.bold) ,
                  ),
                ),
              ),
            ),
            const Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nama Produk',
                    hintText: 'Masukkan Nama Produk'),
              ),
            ),
            const Padding(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Harga',
                    hintText: 'Masukkan Harga'),
              ),
            ),
            const Padding(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                obscureText: true,
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
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: ElevatedButton(
                onPressed: () {
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