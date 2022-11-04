import 'package:flutter/material.dart';
import 'package:get/get.dart';
class TodoList extends StatelessWidget {

  const TodoList({
    Key? key,
    required this.tasks,
  }) : super(key: key);

  final RxList tasks;
  @override
  Widget build(BuildContext context) {
    return Obx(
          () {
        return ListView.separated(
          separatorBuilder: (ctx, index) {
            return Divider(color: Colors.black, thickness: 1);
          },
          itemCount: tasks.length, // number of items shown
          itemBuilder: (ctx, index) {
            Map task = tasks[index];
            return ListTile(
                title: Text(
                  task['title'],
                  style: TextStyle(
                    color: task['completed'] ? Colors.grey : Colors.black,
                    decoration: task['completed']
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                leading: Checkbox(
                  value: task['completed'],
                  onChanged: (bool? val) {
                    task['completed'] = val;
                    tasks[index] = task;
                    tasks.refresh();
                  },
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    tasks.remove(task);
                  },
                ));
          },
        );
      },
    );

  }
}
