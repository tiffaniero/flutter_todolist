import 'package:flutter/material.dart';

class ToDoTile extends StatefulWidget {
  final String text;
  final void Function()? delete;
  final void Function()? update;
  final bool value;

  const ToDoTile(
      {Key? key,
      required this.text,
      this.delete,
      this.update,
      required this.value})
      : super(key: key);

  @override
  State<ToDoTile> createState() => _ToDoTileState();
}

class _ToDoTileState extends State<ToDoTile> {
  bool? value;

  @override
  void initState() {
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: value == true
          ? Text(
              widget.text,
              style: const TextStyle(
                  fontSize: 25, decoration: TextDecoration.lineThrough),
            )
          : Text(
              widget.text,
              style: const TextStyle(fontSize: 25),
            ),
      controlAffinity: ListTileControlAffinity.leading,
      secondary: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            color: Colors.lightBlue,
            onPressed: widget.update,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            color: Colors.red,
            onPressed: widget.delete,
          ),
        ],
      ),
      value: value,
      onChanged: (bool? newValue) {
        setState(() {
          value = newValue;
        });
      },
    );
  }
}
