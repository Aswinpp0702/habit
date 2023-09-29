import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/adapters.dart';
import '/screens/create_screen.dart';
import '/screens/update_screen.dart';

class Read_screen extends StatefulWidget {
  const Read_screen({super.key});

  @override
  State<Read_screen> createState() => _Read_screenState();
}

class _Read_screenState extends State<Read_screen> {
  late final Box dataBox;

  @override
  void initState() {
    super.initState();
    dataBox = Hive.box('data_box');
  }
  _deleteData(int index) {
    dataBox.deleteAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Today',style: TextStyle(letterSpacing: 2),),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const create_screen(),
              ),
            ),
            icon: const Icon(Icons.add),
          ),
        ],

      ),
      body: ValueListenableBuilder(
        valueListenable: dataBox.listenable(),
        builder: (BuildContext context, Box, child) {
          if (Box.isEmpty) {
            return const Center(
              child: Text('Database Is Empty'),
            );
          } else {
            return ListView.builder(
              // itemCount: Hive.box('data_box').length, //we can use this code also
                itemCount: dataBox.length,
                itemBuilder: (context, int index) {
                  final result = dataBox.getAt(index);
                  //  final result = Hive.box('data_box').getAt(index); /////we can use this code also
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Slidable(
                      endActionPane: ActionPane(
                        motion: StretchMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context){
                              _deleteData(index);
                            },
                            backgroundColor: Colors.black54,
                            icon: Icons.delete,
                            borderRadius: BorderRadius.circular(12),
                          )
                        ],
                      ),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: IconButton(
                                onPressed: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => update_screen(
                                        index: index,
                                        // data: result,
                                        titleController: result.title,
                                        descriptionController: result.description,
                                      ),
                                    ),
                                  );

                                }, icon: Icon(Icons.edit),
                              ),
                              title:  Text(result.title.toString(),),
                              subtitle: Text(result.description.toString(),),

                            ),

                          ],

                        ),
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
