import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/TodoList.dart';
import 'package:sqflite/sqflite.dart';
class Tudo extends StatefulWidget {
  const Tudo({Key? key}) : super(key: key);

  @override
  State<Tudo> createState() => _TudoState();
}

class _TudoState extends State<Tudo> {
  TextEditingController myController = TextEditingController();

  RxList tasks = <Map>[].obs;

  late Database myDatabase;

  void saveTask() async {
    tasks.add({
      'title': myController.text,
      'completed': false
    });
    final insertQuery = 'insert into tasks values ("${myController.text}", 0)';
    print(insertQuery);
    await myDatabase.rawInsert(insertQuery);
    myController.clear();
    Get.back();
  }

  void setup() async {
    String databasesFolder = await getDatabasesPath();
    String myDatabaseFile =  databasesFolder + '/mydb.db';
    myDatabase = await openDatabase(myDatabaseFile, version: 1, onCreate: (Database db, v) {
      const sql = 'Create Table tasks (title text, completed int)';
      db.execute(sql);
    });
    deleteAll() async {
      Database db = await myDatabase;
      return await db.rawDelete("Delete * from tasks");
    }
    const query = 'Select * from tasks';
    List savedTasks = await myDatabase.rawQuery(query);

    tasks.value = savedTasks.map((oldElement) {
      return {
        'title': oldElement['title'],
        'completed': oldElement['completed'] == 0 ? false : true
      };
    }).toList();

  }

  @override
  void initState() {
    super.initState();
    setup();
    deleteAll();
  }
  void deleteAll() async {

     await myDatabase.rawDelete('Delete * from tasks"');

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Daily Tasks'),
        actions: [
          IconButton(onPressed: () {
         deleteAll();
          }, icon: const Icon(Icons.delete_forever))
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (ctx) {
                return Container(
                  padding: EdgeInsets.fromLTRB(24, 24, 24, MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: myController,
                        decoration: const InputDecoration(
                            hintText: 'Enter Task'
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(onPressed: saveTask, child: const Text('Save'))
                    ],
                  ),
                );
              }
          );
        },
        child: const Icon(Icons.add),
      ),

      body: buildList(),
    );
  }

  Widget buildList() {
    return Obx(() {
      return ListView.separated(
        itemCount: tasks.length, // 2
        separatorBuilder: (ctx, index) {
          return Divider(color: Colors.red, thickness: 2,);
        },
        itemBuilder: (ctx, int index) {

          Map task = tasks[index];

          return ListTile(
            title: Text(task['title'], style: TextStyle(
                color: task['completed'] ? Colors.grey : Colors.black,
                decoration: task['completed'] ? TextDecoration.lineThrough : TextDecoration.none
            ),),
            leading: Checkbox(
              value: task['completed'],
              onChanged: (bool? val) {
                task['completed'] = val;
                tasks[index] = task;
                tasks.refresh();
              },
            ),

            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: (){}
            ),
          );
        },
      );
    });
  }
}