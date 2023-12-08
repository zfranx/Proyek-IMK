import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projek_gede/pages/Authentification/auth_controller.dart';
import 'package:projek_gede/pages/etalase_page.dart';
import 'package:projek_gede/pages/login_page.dart';
import 'package:projek_gede/widgets/form_container_widget.dart';

class RegisPage extends StatefulWidget {
  const RegisPage({super.key});

  @override
  _RegisPageState createState() => _RegisPageState();
}

class _RegisPageState extends State<RegisPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nomorhpController = TextEditingController();

  bool isSigningUp = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nomorhpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("SignUp"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
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
                controller: _nomorhpController,
                hintText: "Nomor WA",
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
              GestureDetector(
                onTap: () {
                  _signUp();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false);
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
                          ? const CircularProgressIndicator(
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
                  Text("Already have an account?"),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                            (route) => true);
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    setState(() {
      isSigningUp = true;
    });

    String username = _usernameController.text;
    String nomorhp = _nomorhpController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);
      FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
      'role': 'buyer', // atau buyer
    });

    FirebaseFirestore.instance
        .collection('idBuyer')
        .add({
          'username': username,
          'nomorhp': nomorhp,
        })
        .then((value) => print("Berhasil"))
        .catchError((error) => print("Gagal: $error"));

    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();
    String role = userDoc['role'];
    
    setState(() {
      isSigningUp = false;
    });
    if (user != null) {
      print("User is successfully created");
      Navigator.pushNamed(context, "/home");
    } else {
      print("Some error happend");
    }
  }
}
//   final FirebaseAuthService _auth = FirebaseAuthService();

//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   bool isSigningUp = false;

//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.yellow,
//       appBar: AppBar(
//         title: const Text("Registration Page"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             const Padding(
//               padding:
//                   EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 15),
//               //padding: EdgeInsets.symmetric(horizontal: 15),
//               child: TextField(
//                 //obscureText: true,
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Nama Lengkap',
//                     hintText: 'Masukkan Nama Lengkap'),
//               ),
//             ),
//              Padding(
//               //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
//               padding: EdgeInsets.symmetric(horizontal: 15),
//               child: TextField(
//                 controller: _usernameController,
//                 decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Username',
//                     hintText: 'Masukkan Nama Pengguna'),
//               ),
//             ),
//             Padding(
//               padding:
//                   EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
//               //padding: EdgeInsets.symmetric(horizontal: 15),
//               child: TextField(
//                 obscureText: true,
//                 controller: _passwordController,
//                 decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Password',
//                     hintText: 'Masukkan Sandi yang Aman'),
//               ),
//             ),
//             Padding(
//               padding:
//                   EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
//               //padding: EdgeInsets.symmetric(horizontal: 15),
//               child: TextField(
//                 //obscureText: true,
//                 controller: _emailController,
//                 decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Email',
//                     hintText: 'Masukkan Email Yang Valid'),
//               ),
//             ),
//             const Padding(
//               padding:
//                   EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
//               //padding: EdgeInsets.symmetric(horizontal: 15),
//               child: TextField(
//                 //obscureText: true,
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Alamat',
//                     hintText: 'Masukkan Alamat'),
//               ),
//             ),
//             GestureDetector(
//                 onTap:  (){
//                   _signup();

//                 },
//                 child: Container(
//                   width: double.infinity,
//                   height: 45,
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Center(
//                       child: isSigningUp ? CircularProgressIndicator(color: Colors.white,):const Text(
//                     "Sign Up",
//                     style: TextStyle(
//                         color: Colors.white, fontWeight: FontWeight.bold),
//                   )),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               const Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("Already have an account?"),
//                   SizedBox(
//                     width: 5,
//                   ),
//           ],
//               ),
//           ]   
//         ),
//       ),
//     );
//   }
//   void _signup() async {

//     setState((){
//       isSigningUp = true;
//     });
//     String username = _usernameController.text;
//     String email = _emailController.text;
//     String password = _passwordController.text;

//     User? user = await _auth.signInWithEmailAndPassword(email, password);

//     setState(() {
//       isSigningUp = false;
//     });

//     if (user != null){
//       print("Sukses");
//       Navigator.pushNamed(context, "/home");

//     }else{
//       print('eror');
//     }
//   }
// }