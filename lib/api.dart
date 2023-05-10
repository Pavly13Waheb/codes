import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


void main() {
  runApp(Api());
}

class Api extends StatefulWidget {
  @override
  State<Api> createState() => _ApiState();
}

class _ApiState extends State<Api> {
  getPost() async {
    var url = Uri.https(
        "https://jsonplaceholder.typicode.com/posts/1/comments");
    var response = await http.post(url);
    var responsebody = jsonDecode(response.body);

    return responsebody;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            title: Text("Applications Programing Interface",
                style: TextStyle(
                    color: Colors.yellowAccent,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Tangerine")),
            backgroundColor: CupertinoColors.darkBackgroundGray),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: 300,
                  child: Image(
                    image: NetworkImage(
                        'https://i.pinimg.com/236x/b8/19/3c/b8193c0c3888be5a86a31376b2b27888.jpg'),
                    fit: BoxFit.fill,
                  )),
              FutureBuilder(
                future: getPost(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){return ListView.builder(
                    itemBuilder: (context, i) {
                      return Container(
                        child: Text("${snapshot.data}"),
                      );
                    },
                    itemCount: snapshot.data.hashCode,
                  );}
                  else {
                    return CircularProgressIndicator();
                  }},
              )
            ],
          ),
        ),
      ),
    );
  }
}
