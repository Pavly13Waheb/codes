import 'package:flutter/material.dart';
import 'package:tesst/addnotes.dart';
import 'package:tesst/api.dart';
import 'package:tesst/auth/maps.dart';
import 'package:tesst/test.dart';
import 'package:tesst/homepage.dart';
import 'package:tesst/counter.dart';
import 'package:tesst/notes.dart';

void main() {
  runApp(const WorkTab());
}

class WorkTab extends StatefulWidget {
  const WorkTab({super.key});

  @override
  State<WorkTab> createState() => _WorkTabState();
}

class _WorkTabState extends State<WorkTab> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> mailstate = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController passs = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return Api();
                        },
                      ));
                    },
                    child: const Text("Application Programing Interface")),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const Counter();
                      }));
                    },
                    child: const Text("Slider + Counter")),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const AddNotes();
                      }));
                    },
                    child: const Text("Add Notes")),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const Notes();
                      }));
                    },
                    child: const Text("Notes")),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const Maps();
                      }));
                    },
                    child: const Text("Maps")),
                SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return Test();
                      },));
                    },
                    child: const Text("FireStore")),

              ],
            ),
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
