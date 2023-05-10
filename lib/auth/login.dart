import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tesst/auth/signup.dart';
import 'package:tesst/homepage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var mymail, mypass;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  late UserCredential usercredential;

  signIn() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      try {
        usercredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: mymail, password: mypass);
        return usercredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text(
                "No user found for that email.",
                style: TextStyle(fontSize: 30),
              ))
            ..show();
        } else if (e.code == 'wrong-password') {
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text(
                "wrong-password.",
                style: TextStyle(fontSize: 30),
              ))
            ..show();
        }
      }
    } else {
      print("not valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                          borderSide: BorderSide(color: Colors.red, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      hintText: "User Name",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.blue),
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
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      hintText: "Password",
                      prefixIcon: Icon(Icons.password),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.blue),
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
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(children: [
                          const Text(
                            "If you don't have account please ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return const SignUp();
                                },
                              ));
                            },
                            child: const Text(
                              "Signup",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                  MaterialButton(
                      onPressed: () async {
                        var user = await signIn();
                        if (user != null) {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return HomePage();
                            },
                          ));
                        }
                      },
                      child: const Text("Login",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic)),
                      color: Colors.yellow,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
