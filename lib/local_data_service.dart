import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/todo.dart';

class LocalDataService {
  Future<List<ToDo>> getToDoList(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(key);
    print("JsonString : $jsonString");
    List parsedJson = jsonDecode(jsonString!);
    print(
        "Json Parsé: $parsedJson\nLe type du Json Parsé est : ${parsedJson.runtimeType}");
    Iterable<ToDo> toDoListData = parsedJson.map((e) => ToDo.fromJSON(e));
    print(toDoListData.toList());
    return toDoListData.toList();
  }

  void save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  void remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
