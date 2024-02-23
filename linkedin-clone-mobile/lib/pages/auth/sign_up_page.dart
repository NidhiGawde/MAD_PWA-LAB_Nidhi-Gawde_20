import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linkedin_mobile_ui/pages/auth/sign_in_page.dart';
import 'package:linkedin_mobile_ui/pages/main/main_page/main_page.dart';
import 'package:linkedin_mobile_ui/theme/styles.dart';
import 'package:linkedin_mobile_ui/widgets/button_container_widget.dart';
import '../../widgets/google_button_container_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isContinued = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 60),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: SvgPicture.asset(
                  "assets/app_logo_svg.svg",
                  width: 50,
                  height: 50,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Join LinkedIn",
                      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10,),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              hintText: "Email ",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10,),
                          if (_isContinued) // Check if the continuation is true
                            Column(
                              children: [
                                TextFormField(
                                  controller: passwordController,
                                  decoration: const InputDecoration(
                                    hintText: "Password",
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15,),
                              ],
                            ),
                          const SizedBox(height: 15,),
                          ButtonContainerWidget(
                            title: "Continue",
                            onTap: () {
                              if (_isContinued) {
                                if (_formKey.currentState!.validate()) {
                                  try {
                                    FirebaseAuth.instance.createUserWithEmailAndPassword(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    );
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (_) => const MainPage()),
                                          (route) => false,
                                    );
                                  } catch (e) {
                                    print(e);
                                  }
                                }
                              } else {
                                setState(() {
                                  _isContinued = true;
                                });
                              }
                            },
                          ),
                          const SizedBox(height: 15,),
                          GoogleButtonContainerWidget(
                            hasIcon: true,
                            icon: SvgPicture.asset("assets/google_logo_svg.svg", width: 30, height: 30,),
                            title: "Sign In with Google",
                          ),
                          const SizedBox(height: 10,),
                          GoogleButtonContainerWidget(
                            hasIcon: true,
                            icon: Icon(FontAwesomeIcons.apple, size: 22,),
                            title: "Sign In with Apple",
                          ),
                          const SizedBox(height: 30,),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: "Already on LinkedIn? ",
                                style: TextStyle(color: linkedInBlack000000, fontSize: 16),
                                children: [
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()..onTap = () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(builder: (_) => const SignInPage()),
                                            (route) => false,
                                      );
                                    },
                                    text: "Sign in",
                                    style: TextStyle(color: linkedInBlue0077B5, fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
