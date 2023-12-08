import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:projek_gede/pages/Authentification/auth_controller.dart';
import 'package:projek_gede/pages/common/toast.dart';
import 'package:projek_gede/pages/etalase_page.dart';
import 'package:projek_gede/pages/seller/seller_etalase_page.dart';
import 'package:projek_gede/pages/seller/seller_regis_page.dart';
import 'package:projek_gede/widgets/form_container_widget.dart';

class SellerLoginPage extends StatefulWidget {
  const SellerLoginPage({super.key});

  @override
  
  _SellerLoginPageState createState() => _SellerLoginPageState();
}

class _SellerLoginPageState extends State<SellerLoginPage> {
  bool _isSigning = false;
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 247, 0),
      appBar: AppBar(
        title: const Text("Masuk Sebagai Penjuall"),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
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
                  _signIn();
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: _isSigning ? const CircularProgressIndicator(
                      color: Colors.white,) : const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: () {
                  _signInWithGoogle();

                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon(FontAwesomeIcons.google, color: Colors.white,),
                        SizedBox(width: 5,),
                        Text(
                          "Sign in with Google",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),


              const SizedBox(
                height: 20,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => SellerRegisPage()),
                            (route) => false,
                      );
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    setState(() {
      _isSigning = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      showToast(message: "User is successfully signed in");
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SellerEtalasePage()),);
    } else {
      showToast(message: "some error occured");
    }
  }


  _signInWithGoogle()async{

    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {

      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      if(googleSignInAccount != null ){
        final GoogleSignInAuthentication googleSignInAuthentication = await
        googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await _firebaseAuth.signInWithCredential(credential);
        // ignore: use_build_context_synchronously
        Navigator.push(context, MaterialPageRoute(builder: (context) => const SellerEtalasePage()),);
      }

    }catch(e) {
        showToast(message: "some error occured $e");
    }


  }


}

//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(top: 60.0),
//               child: Center(
//                 child: SizedBox(
//                     width: 200,
//                     height: 150,
//                     /*decoration: BoxDecoration(
//                         color: Colors.red,
//                         borderRadius: BorderRadius.circular(50.0)),*/
//                     child: Image.asset('assets/pisang2.jpg')),
//               ),
//             ),
//             const Padding(
//               //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
//               padding: EdgeInsets.symmetric(horizontal: 15),
//               child: TextField(
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Nama Pengguna',
//                     hintText: 'Masukkan Nama Pengguna'),
//               ),
//             ),
//             const Padding(
//               padding:
//                   EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
//               //padding: EdgeInsets.symmetric(horizontal: 15),
//               child: TextField(
//                 obscureText: true,
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Password',
//                     hintText: 'Enter secure password'),
//               ),
//             ),
//             // TextButton(
//             //   onPressed: () {
//             //     //TODO FORGOT PASSWORD SCREEN GOES HERE
//             //   },
//             //   child: const Text(
//             //     'Forgot Password',
//             //     style: TextStyle(color: Colors.blue, fontSize: 15),
//             //   ),
//             // ),
//             Container(
//               height: 50,
//               width: 250,
//               padding:
//                   EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
//               child: ElevatedButton(
                
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (_) =>  const SellerEtalasePage()));
//                 },
//                 child: const Text(
//                   'Masuk',
                  
//                 ),
//               ),
//             ),
//             Container(
//               height: 60,
//               width: 260,
              
//               padding:
//                   EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (_) => SellerRegisPage()));
//                 },
//                 child: const Text(
//                   'Registrasi',
               
//                 ),
//               ),
//             ),
             
           
//           ],
//         ),
//       ),  
//     );
//   }
// }