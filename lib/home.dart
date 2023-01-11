import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Todo> items = [];
  List<String> newitems = [];
  final textController = TextEditingController();
  Future<SharedPreferences> sharedStorage = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      // appBar: AppBar(
      //   title: const Text("Daily Todo App"),
      // ),
      body: TodoContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTodo();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget EmptyContent() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            title: Text(
              "No Content",
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  Widget TodoContent() {
    return Container(
      margin: EdgeInsets.only(top: 70),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Todo Work",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
                ),
                Text(
                  "Jan 12, 2023",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          items.isNotEmpty
              ? Expanded(
                  child: Align(
                    child: Transform.translate(
                      offset: Offset(0, -30),
                      child: Container(
                        // color: Colors.red,
                        margin: EdgeInsets.only(top: 0),
                        child: ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              return BuildTodoCard(items[index], index);
                            }),
                      ),
                    ),
                  ),
                )
              : EmptyContent()
        ],
      ),
    );
  }

  Widget BuildTodoCard(Todo item, index) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        onTap: () {
          changeItemCompleteness(item);
        },
        leading: Icon(
          item.completed ? Icons.check_circle : Icons.circle_outlined,
          color: item.completed ? Colors.green : Colors.grey,
        ),
        title: Text(
          item.title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: item.completed ? Colors.black54 : Colors.black,
            decoration: item.completed ? TextDecoration.lineThrough : null,
          ),
        ),
      ),
    );
  }

  void addTodo() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext content) {
          return AlertDialog(
            title: Text("Add your task"),
            content: TextField(
              controller: textController,
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      items.insert(0, Todo(title: textController.text));
                    });
                    textController.text = "";
                    Navigator.pop(context);
                  },
                  child: Text("Save"))
            ],
          );
        });

    print("floating button tapped");
  }

  void changeItemCompleteness(Todo item) {
    setState(() {
      item.completed = !item.completed;
    });
  }
}
