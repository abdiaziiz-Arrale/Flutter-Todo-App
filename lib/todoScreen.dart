import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/TodoList.dart';
class Tudo  extends StatelessWidget {
  Tudo({super.key});

  TextEditingController _taskItem = TextEditingController();

  void saveTask() {
    tasks.add({'title': _taskItem.text, 'completed': false});
    _taskItem.clear();
    Get.back();
  }

  RxList tasks =
      <Map>[].obs; // to make changes to the UI make the list reactive



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Daily Task'),
          actions: [
            IconButton(
                onPressed: () {
                  tasks.clear();
                },
                icon: Icon(Icons.delete_forever))
          ],
        ),
        // bottomSheet: Container(color: Colors.red, height: 200),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (ctx) {
                  return Container(
                    padding: EdgeInsets.fromLTRB(
                        24, 24, 24, MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      children: [
                        TextField(
                          controller: _taskItem,
                          decoration: InputDecoration(hintText: 'Enter Task'),
                        ),
                        SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: saveTask,
                          child: Text('Save'),
                        )
                      ],
                    ),
                  );
                });
          },
          child: const Icon(Icons.add),
        ),
        body: TodoList(tasks: tasks));

  }
}
