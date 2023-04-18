import 'package:firebase/Button.dart';
import 'package:firebase/Dashbord/dashbord.dart';
import 'package:firebase/Signup.dart';
import 'package:firebase/Utils/utilities.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool loading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  @override
  // void dispose() {
  //   super.dispose();
  //   emailController.dispose();
  //   passwordController.dispose();
  // }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('LoginFirebase'),
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

                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: TextFormField(
                            // margin: EdgeInsets.symmetric(horizontal: 50),
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
                name: 'Login',
                onTab: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    auth
                        .signInWithEmailAndPassword(
                            email: emailController.text.toString(),
                            password: passwordController.text.toString())
                        .then((value) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => dashbord()));
                      Utils().toastMessage(value.user!.email.toString());
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
                  Text("If you don't have an account"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => SignUp())));
                      },
                      child: Text('Sign up')),
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}
