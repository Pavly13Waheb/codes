import 'package:flutter/material.dart';
import 'package:tesst/addnotes.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  List notes = [
    {"note": "Google Image", "image": "Images/google.png"},
    {"note": "FaceBook Image", "image": "Images/facebook.png"},
    {"note": "WhatsApp Image", "image": "Images/whatsapp.png"},
    {"note": "Twitter Image", "image": "Images/twitter.png"},
    {"note": "Instagram Image", "image": "Images/instagram.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notes")),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, l) {
              return Dismissible(
                key: Key("$l"),
                child: ListNotes(
                  notes: notes[l],
                ),
              );
            },
          )),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return const AddNotes();
              },
            ));
          },
          child: const Icon(Icons.add)),
    );
  }
}

class ListNotes extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final notes;

  const ListNotes({super.key, this.notes});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: ListTile(
              title: Text("${notes['note']}"),
              trailing:
                  IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
              leading: Image.asset("Images/ironlogo.png"),
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
        ],
      ),
    );
  }
}
