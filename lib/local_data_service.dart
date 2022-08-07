import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/todo.dart';

class LocalDataService {
  Future<List<ToDo>> getToDoList(String key) async {
    List<ToDo> list = [];
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(key);
    print("JsonString : $jsonString");
    if (jsonString != null) {
      List parsedJson = jsonDecode(jsonString);
      final dataMap = parsedJson.map((e) => ToDo.fromJSON(e));
      print("Json Parsé: $parsedJson");
      print("Le type du Json Parsé est : ${parsedJson.runtimeType}");
      print("$dataMap, ${dataMap.runtimeType}");
      dataMap.map((e) => list.add(e));
    }
    return list;
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

/*// ignore: depend_on_referenced_packages


class SharedPreferenceData extends StatefulWidget {
  const SharedPreferenceData({Key? key}) : super(key: key);

  @override
  State<SharedPreferenceData> createState() => _SharedPreferenceDataState();
}

class _SharedPreferenceDataState extends State<SharedPreferenceData> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late List<dynamic> _list = [];

  Future<void> addNewItem(String item) async {
    final SharedPreferences prefs = await _prefs;
    final List list = prefs.getStringList('todos') ?? [];

    setState() {
      _list =
          prefs.setStringList('todos', list as List<String>).then((success) {
        return list;
      }) as List;
    }
  }

  @override
  void initState() {
    super.initState();
    _list = _prefs.then((SharedPreferences prefs) {
      prefs.getStringList('items') ?? [];
    }) as List;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }}*/
