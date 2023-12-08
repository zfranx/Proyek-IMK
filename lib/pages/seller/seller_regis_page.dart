import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:projek_gede/pages/Authentification/auth_controller.dart';
import 'package:projek_gede/pages/common/toast.dart';
import 'package:projek_gede/pages/etalase_page.dart';
import 'package:projek_gede/pages/seller/seller_etalase_page.dart';
import 'package:projek_gede/pages/seller/seller_login_page.dart';
import 'package:projek_gede/widgets/form_container_widget.dart';

class SellerRegisPage extends StatefulWidget {
  const SellerRegisPage({super.key});

  @override
  _SellerRegisPageState createState() => _SellerRegisPageState();
}

class _SellerRegisPageState extends State<SellerRegisPage> {
  File? _image;
  FilePickerResult? resultFileTemp;

  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController _storeController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _waletController = TextEditingController();

  bool isSigningUp = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _storeController.dispose();
    _waletController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("SignUp"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                FormContainerWidget(
                  controller: _usernameController,
                  hintText: "Username",
                  isPasswordField: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                FormContainerWidget(
                  controller: _storeController,
                  hintText: "Nama Toko",
                  isPasswordField: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                FormContainerWidget(
                  controller: _emailController,
                  hintText: "Email",
                  isPasswordField: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                FormContainerWidget(
                  controller: _passwordController,
                  hintText: "Password",
                  isPasswordField: true,
                ),
                const SizedBox(
                  height: 30,
                ),
                FormContainerWidget(
                  controller: _waletController,
                  hintText: "No. E-Walet (dana/ovo/sebagainya)",
                  isPasswordField: false,
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () async {
                    openFiles();
                  },
                  child: const Text('Upload QR Code'),
                ),
                GestureDetector(
                  onTap: () {
                    _signUp();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: isSigningUp
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Sudah Punya Akun?"),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SellerLoginPage()),
                              (route) => false);
                        },
                        child: const Text(
                          "Masuk",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
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

  void _signUp() async {
    setState(() {
      isSigningUp = true;
    });
    String store = _storeController.text;
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String walet = _waletController.text;
    File? file = _image;

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref =
        storage.ref().child('qrCodes/${resultFileTemp!.files.single.name}');

    UploadTask uploadTask = ref.putFile(file!);

    TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
    String qrUrl = await snapshot.ref.getDownloadURL();

    User? user = await _auth.signUpWithEmailAndPassword(email, password);
    FirebaseFirestore.instance
        .collection('id')
        .add({
          'username': username,
          'toko': store,
          'qrUrl': qrUrl,
          'walet': walet,
        })
        .then((value) => print("Berhasil"))
        .catchError((error) => print("Gagal: $error"));
    FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
      'role': 'seller', // atau buyer
    });

    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();
    String role = userDoc['role'];
    setState(() {
      isSigningUp = false;
    });
    if (user != null) {
      showToast(message: "Pengguna Berhasil Registrasi");
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SellerLoginPage()),
      );
    } else {
      showToast(message: "Ada eror");
    }
  }
}
