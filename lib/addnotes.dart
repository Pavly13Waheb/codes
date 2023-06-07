// ignore_for_file: deprecated_member_use
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  String title = "";
  String note = "";

  File? image;

  final imagepicker = ImagePicker();

  uplodImage() async {
    var pickedImage = await imagepicker.getImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  galImage() async {
    var gallImage = await imagepicker.getImage(source: ImageSource.gallery);
    if (gallImage != null) {
      setState(() {
        image = File(gallImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios)),
          title: const Text("Add Note")),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  maxLines: 1,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    hintText: "Title Note",
                    prefixIcon: Icon(
                      Icons.note,
                      color: Colors.yellowAccent,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.blue),
                    ),
                  ),
                  onChanged: ($value) {
                    setState(() {
                      title = $value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  minLines: 1,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.yellowAccent, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    hintText: "Note",
                    prefixIcon: Icon(
                      Icons.note,
                      color: Colors.red,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.blue),
                    ),
                  ),
                  onChanged: ($value) {
                    setState(() {
                      note = $value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.black)),
                    onPressed: () {
                      showBottomsheet();
                    },
                    child: const Text("Add image for note")),
                Container(
                  child: image == null
                      ? Text("No Choseen Image")
                      : Image.file(image!),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.green)),
                    onPressed: () {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.infoReverse,
                        animType: AnimType.rightSlide,
                        headerAnimationLoop: true,
                        title: title,
                        desc: note,
                        btnOkOnPress: () {},
                      ).show();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 100,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.add, color: Colors.red, size: 40),
                          Text(
                            "Add Note",
                            style: TextStyle(
                                color: Colors.yellowAccent, fontSize: 13),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  showBottomsheet() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              alignment: Alignment.center,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Please select image"),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: uplodImage,
                        child: Column(
                          children: const [
                            Icon(Icons.camera_alt,
                                size: 50, color: Colors.grey),
                            Text("Camera"),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: galImage,
                        child: Column(
                          children: [
                            Icon(Icons.browse_gallery,
                                size: 50, color: Colors.red.shade200),
                            const Text("Gallery"),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ));
        });
  }
}
