import 'package:firebase/Button.dart';
import 'package:firebase/Utils/utilities.dart';
import 'package:firebase/loginFirebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _loginState();
}

class _loginState extends State<SignUp> {
  bool loading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignupFirebase'),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      //  color: Colors.amber,
                      height: 100,
                      width: double.infinity,
                      // margin: EdgeInsets.symmetric(horizontal: 50),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: 'Email',
                              label: Text('Email'),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Email';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: double.infinity,
                      // margin: EdgeInsets.symmetric(horizontal: 50),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              label: Text('Password'),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Password';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                )),
            RoundButton(
              name: 'SignUp',
              onTab: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    loading = true;
                  });
                  auth
                      .createUserWithEmailAndPassword(
                          email: emailController.text.toString(),
                          password: passwordController.text.toString())
                      .then((value) {
                    setState(() {
                      loading = false;
                    });
                  }).onError((error, stackTrace) {
                    setState(() {
                      loading = false;
                    });
                    Utils().toastMessage(error.toString());
                  });
                }
              },
              loading: loading,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("If you have an account"),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: ((context) => login())));
                    },
                    child: Text('Login')),
              ],
            )
          ],
        )),
      ),
    );
  }
}
