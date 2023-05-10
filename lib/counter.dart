import 'package:flutter/material.dart';
import 'package:tesst/homepage.dart';

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  var _valslider = 0.0;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            leading: BackButton(onPressed: () {
              Navigator.of(context).pop();
            }),
            title: const Text("Slider + Counter")),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: const Text("Slider + Counter",
                    style: TextStyle(fontSize: 20, color: Colors.red)),
              ),
              Slider(
                min: 0,
                max: 100,
                value: _valslider,
                onChanged: (value) {
                  setState(() {
                    _valslider = value;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        count++;
                      });
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.red,
                    ),
                  ),
                  Text("$count"),
                  const Text("    Count Again")
                ],
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.yellow,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return const HomePage();
              },
            ));
          },
          mini: true,
          child: const Icon(
            Icons.ac_unit,
            size: 40,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
