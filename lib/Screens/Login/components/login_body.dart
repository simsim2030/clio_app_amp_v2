// import 'package:clio_chess_amp_v2/Screens/Login/components/already_have_an_account_check.dart';
// import 'package:clio_chess_amp_v2/Screens/Login/components/login_background.dart';
// import 'package:clio_chess_amp_v2/Screens/Signup/components/or_divier.dart';
// import 'package:clio_chess_amp_v2/Screens/Signup/signup_page.dart';
// import 'package:clio_chess_amp_v2/components/buttons/rounded_button.dart';
// import 'package:clio_chess_amp_v2/components/fields/rounded_input_field.dart';
// import 'package:clio_chess_amp_v2/components/fields/rounded_password_field.dart';
// import 'package:clio_chess_amp_v2/components/icon/social_icon.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import '../../../components/icon/social_icon.dart';

// class LoginBody extends StatelessWidget {
//   const LoginBody({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Background(
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             SizedBox(height: size.height * 0.025),
//             Text(
//               "Log In",
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20,
//                 color: Colors.white,
//               ),
//             ),
//             // SizedBox(height: size.height * 0.03),
//             // SvgPicture.asset(
//             //   "assets/icons/login.svg",
//             //   height: size.height * 0.35,
//             // ),
//             SizedBox(height: size.height * 0.075),
//             RoundedInputField(
//               hintText: "Email",
//               onChanged: (value) {},
//             ),
//             RoundedPasswordField(
//               hintText: "Password",
//               onChanged: (value) {},
//             ),
//             RoundedButton(
//               text: "Log In",
//               onPressed: () {},
//             ),
//             SizedBox(height: size.height * 0.03),
//             AlreadyHaveAnAccountCheck(
//               press: () {
//                 Navigator.of(context).pushNamed(SignupPage.routeName);
//               },
//             ),
//             OrDivider(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 SocialIcon(
//                   iconSrc: "assets/icons/facebook.svg",
//                   onTap: () {},
//                 ),
//                 SocialIcon(
//                   iconSrc: "assets/icons/twitter.svg",
//                   onTap: () {},
//                 ),
//                 SocialIcon(
//                   iconSrc: "assets/icons/google-plus.svg",
//                   onTap: () {},
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
