import 'dart:core';

import 'package:flutter/material.dart';
import 'package:todolist/local_data_service.dart';
import 'package:todolist/todo.dart';
import 'package:todolist/todo_tile.dart';

const _toDoListName = 'ToDoList';

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
      debugShowCheckedModeBanner: false,
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
  late final LocalDataService _localDataService;
  final TextEditingController _textEditingController = TextEditingController();
  List<ToDo> _toDoList = [];

  Future loadData() async {
    List<ToDo> list = await _localDataService.getToDoList(_toDoListName);
    setState(() {
      _toDoList = list;
    });
  }

  @override
  void initState() {
    super.initState();
    _localDataService = LocalDataService();
    loadData();
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
              text: _toDoList[index].name,
              value: _toDoList[index].status,
              onChanged: (bool newValue) {
                setState(() {
                  _toDoList[index].status = newValue;
                  _localDataService.save(_toDoListName, _toDoList);
                });
              },
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
                    textCapitalization: TextCapitalization.sentences,
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
      _toDoList.add(ToDo(name: toDoName));
      _textEditingController.clear();
      _localDataService.save(_toDoListName, _toDoList);
    });
  }

  //UPDATE
  void _updateToDo(int index) {
    _textEditingController.text = _toDoList[index].name;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Modifier la tache"),
            content: TextField(
              autofocus: true,
              controller: _textEditingController,
              textCapitalization: TextCapitalization.sentences,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    _toDoList[index].name = _textEditingController.text;
                    setState(() {
                      _localDataService.save(_toDoListName, _toDoList);
                    });
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
      _localDataService.save(_toDoListName, _toDoList);
    });
  }
}
