// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_signin_button/button_list.dart';
// import 'package:flutter_signin_button/button_view.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:provider/provider.dart';
// import 'package:smartfoodappwithadminpanel/providers/user_provider.dart';
// import 'package:smartfoodappwithadminpanel/screens/getUserLocation.dart';
//
// class SignIn extends StatefulWidget {
//   const SignIn({Key? key}) : super(key: key);
//
//   @override
//   _SignInState createState() => _SignInState();
// }
//
// class _SignInState extends State<SignIn> {
//   late UserProvider userProvider;
//
//   Future<dynamic> _googleSignUp() async {
//     try {
//       final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
//       final FirebaseAuth _auth = FirebaseAuth.instance;
//       final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
//       final GoogleSignInAuthentication? googleAuth =
//           await googleUser!.authentication;
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth!.accessToken,
//         idToken: googleAuth.idToken,
//       );
//       final User? user = (await _auth.signInWithCredential(credential)).user;
//
//       userProvider.addUserData(
//         currentUser: user,
//         userEmail: user!.email,
//         userImage: user.photoURL,
//         userName: user.displayName,
//       );
//
//       return user;
//     } catch (e) {
//       print("Error is Found");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     userProvider = Provider.of<UserProvider>(context);
//     return Scaffold(
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: BoxDecoration(
//             image: DecorationImage(
//           fit: BoxFit.cover,
//           image: AssetImage("assets/background.png"),
//         )),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               height: 400,
//               width: double.infinity,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Text("Sign in to continue"),
//                   Text(
//                     "Smart Food Express",
//                     style:
//                         TextStyle(fontSize: 28, color: Colors.white, shadows: [
//                       BoxShadow(
//                         blurRadius: 5.0,
//                         color: Colors.green.shade900,
//                         offset: Offset(3, 3),
//                       )
//                     ]),
//                   ),
//                   Column(
//                     children: [
//                       SignInButton(
//                         Buttons.Email,
//                         text: "Sign Up with Email",
//                         onPressed: () {},
//                       ),
//                       SignInButton(
//                         Buttons.Google,
//                         text: "Sign In with Google",
//                         onPressed: () async {
//                           await _googleSignUp().then(
//                             (value) => Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => GetUserLocation(),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       Text(
//                         'By signing in you are agreeing to our',
//                         style: TextStyle(
//                           color: Colors.grey[800],
//                         ),
//                       ),
//                       Text(
//                         'Terms and Pricacy Policy',
//                         style: TextStyle(
//                           color: Colors.grey[800],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
