import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  Test({Key? key}): super(key : key);
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  getData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        print("================================================");
        print("Username : ${element.data()}");
      });
    });
  }

  addData() async {
    CollectionReference usersRef =
        FirebaseFirestore.instance.collection("users");
    usersRef.add({"username": "pop", "age": "35", "email": "pop@gmail.com"});
  }

  void iniState() {
    super.initState();
    getData();
    addData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FireStore"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
                onPressed: () {
                 getData();
                },
                child: Text(
                  "Get Data",
                  style: TextStyle(fontSize: 30),
                )),
          )
        ],
      ),
    );
  }
}
