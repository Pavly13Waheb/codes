import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tesst/homepage.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  var myuser, mymail, mypass;
  late UserCredential usercredential;

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  signup() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      try {
        usercredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: mymail,
          password: mypass,
        );
        return usercredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text(
                "weak-password",
                style: TextStyle(fontSize: 30),
              ))
            ..show();
        } else if (e.code == 'email-already-in-use') {
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text(
                "email-already-in-use",
                style: TextStyle(fontSize: 30),
              ))
            ..show();
        }
      } catch (e) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset("Images/ironlogo.png",
                  fit: BoxFit.fill, width: 100, height: 100),
            ),
            Form(
                key: formstate,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          hintText: "User Name",
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.blue),
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onSaved: (newValue) {
                          myuser = newValue;
                        },
                        onChanged: (value) {
                          myuser = value;
                        },
                        validator: (value) {
                          if (value!.length > 100) {
                            return "Username can't be more than 100 letter";
                          }
                          if (value.length < 5) {
                            return "Username can't be less than 5 letter";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          hintText: "E-Mail",
                          prefixIcon: Icon(Icons.password),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.blue),
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onSaved: (newValue) {
                          mymail = newValue;
                        },
                        onChanged: (value) {
                          mymail = value;
                        },
                        validator: (value) {
                          if (value!.length > 100) {
                            return "E-mail can't be more than 100 letter";
                          }
                          if (value.length < 5) {
                            return "E-mail can't be less than 5 letter";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.yellow, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          hintText: "Password",
                          prefixIcon: Icon(Icons.password),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.blue),
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onSaved: (newValue) {
                          mypass = newValue;
                        },
                        onChanged: (value) {
                          mypass = value;
                        },
                        validator: (value) {
                          if (value!.length > 100) {
                            return "Password can't be more than 100 letter";
                          }
                          if (value.length < 5) {
                            return "Password can't be less than 5 letter";
                          }
                          return null;
                        },
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  child: Image.asset(
                                    "Images/google.png",
                                    height: 30,
                                    width: 30,
                                  ),
                                  onTap: () async {
                                    await signInWithGoogle();
                                  },
                                ),
                                InkWell(
                                  child: Image.asset(
                                    "Images/facebook.png",
                                    height: 50,
                                    width: 50,
                                  ),
                                  onTap: () async {
                                    final LoginResult result = await FacebookAuth
                                        .instance
                                        .login(); // by default we request the email and the public profile
                                    if (result.status == LoginStatus.success) {
                                      // ignore: unused_local_variable
                                      final AccessToken accessToken =
                                          result.accessToken!;
                                    } else {
                                      print(result.status);
                                      print(result.message);
                                    }
                                  },
                                ),
                              ],
                            ),
                            Row(children: [
                              const Text("If you have account please "),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Login",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 15,
                                    )),
                              ),
                            ]),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          UserCredential response = await signup();
                          // ignore: unnecessary_null_comparison
                          if (response != null) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return HomePage();
                              },
                            ));
                          }
                        },
                        child: const Text("Create Account"),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
