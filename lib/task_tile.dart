import 'package:flutter/material.dart';

class TaskTile extends StatefulWidget {
  final String text;
  final void Function()? delete;
  final void Function()? update;

  const TaskTile({Key? key, required this.text, this.delete, this.update})
      : super(key: key);

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool? value = false;

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
