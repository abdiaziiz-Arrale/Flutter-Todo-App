import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
class Counters extends StatefulWidget {
  const Counters({Key? key}) : super(key: key);

  @override
  State<Counters> createState() => _CountersState();
}

var counter = 0.obs;
class _CountersState extends State<Counters> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final savedcounter = GetStorage().read('counter');
    if (savedcounter != null) {
      counter.value = savedcounter;
    }
  }

  @override
  Widget build(BuildContext context) {
    var counter = 0.obs;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
child: Obx((){
  return Text("waxaad Maraysaa $counter");
}),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()
        {counter ++;
          GetStorage().write('counter', counter.value);},
        child: Icon(Icons.add),
      ),
    );
  }
}
