import 'dart:core';

import 'package:flutter/material.dart';
import 'package:todolist/todo.dart';
import 'package:todolist/todo_tile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.amber,
        unselectedWidgetColor: Colors.amber,
      ),
      home: const ToDoPage(title: 'To Do List'),
    );
  }
}

class ToDoPage extends StatefulWidget {
  const ToDoPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  List<ToDo> _toDoList = [];
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: _toDoList.length,
          itemBuilder: (context, int index) {
            return ToDoTile(
              text: _toDoList[index].getName(),
              delete: () {
                _deleteToDo(index);
              },
              update: () {
                _updateToDo(index);
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Ajouter une tâche"),
                  content: TextField(
                    autofocus: true,
                    controller: _textEditingController,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          _addToDo(_textEditingController.text);
                          Navigator.of(context).pop();
                        },
                        child: const Text("Ok")),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Annuler"))
                  ],
                );
              });
        },
      ),
    );
  }

  //CREATE
  void _addToDo(String toDoName) {
    setState(() {
      _toDoList.add(ToDo(toDoName));
      _textEditingController.clear();
    });
  }

  //UPDATE
  void _updateToDo(int index) {
    _textEditingController.text = _toDoList[index].getName();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Modifier la tache"),
            content: TextField(
              autofocus: true,
              controller: _textEditingController,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    _toDoList[index].setName(_textEditingController.text);
                    setState(() {});
                    Navigator.of(context).pop();
                    _textEditingController.clear();
                  },
                  child: const Text("Ok")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _textEditingController.clear();
                  },
                  child: const Text("Annuler"))
            ],
          );
        });
  }

  //DELETE
  void _deleteToDo(int index) {
    setState(() {
      _toDoList.removeAt(index);
    });
  }
}
