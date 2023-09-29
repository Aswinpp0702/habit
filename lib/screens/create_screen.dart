import 'package:flutter/material.dart';
import 'package:habit_tracker/screens/read_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';



import '../model/model.dart';

class create_screen extends StatefulWidget {
  const create_screen({super.key});

  @override
  State<create_screen> createState() => _create_screenState();
}

class _create_screenState extends State<create_screen> {
  Box? dataBox;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dataBox = Hive.box('data_box');
  }

  _createData() {
    Data newData = Data(
      title: _titleController.text,
      description: _descriptionController.text,
    );
    Hive.box('data_box').add(newData);

    //dataBox?.add(newData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Habits',style: TextStyle(letterSpacing: 2),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _titleController,
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
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Description',
                labelText: 'Description',
              ),
            ),
          ),

          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              _createData();
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Read_screen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal,
            ),
            child: const Text('ADD DATA'),
          )
        ],
      ),
    );
  }
}
