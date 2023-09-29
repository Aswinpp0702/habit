// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../model/model.dart';
import 'read_screen.dart';

class update_screen extends StatefulWidget {
  final int index;
//  final Data? data;
  final titleController;
  final descriptionController;

  const update_screen(
  {super.key,
  required this.index,
  // this.data,
  this.titleController,
  this.descriptionController});

  @override
  State<update_screen> createState() => _update_screenState();
}

class _update_screenState extends State<update_screen> {
  late final Box dataBox;
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;

  _updateData() {
    Data newData = Data(
      title: titleController.text,
      description: descriptionController.text,
    );
    dataBox.putAt(widget.index, newData);
  }

  @override
  void initState() {
    super.initState();

    dataBox = Hive.box('data_box');
    titleController = TextEditingController(text: widget.titleController);
    descriptionController =
        TextEditingController(text: widget.descriptionController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Today',style: TextStyle(letterSpacing: 2),),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Title',
                labelText: 'Title',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Description',
                labelText: 'Description',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _updateData();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Read_screen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),

            child: const Text('UPDATE DATA'),
          ),
        ],
      ),
    );
  }
}
