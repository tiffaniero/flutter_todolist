import 'package:flutter/material.dart';

class ToDoTile extends StatefulWidget {
  final String text;
  final bool value;
  final ValueChanged<bool> onChanged;
  final void Function() delete;
  final void Function() update;

  const ToDoTile({
    Key? key,
    required this.text,
    required this.value,
    required this.onChanged,
    required this.delete,
    required this.update,
  }) : super(key: key);

  @override
  State<ToDoTile> createState() => _ToDoTileState();
}

class _ToDoTileState extends State<ToDoTile> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: widget.value == true
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
      value: widget.value,
      onChanged: (bool? newValue) {
        widget.onChanged(newValue!);
      },
    );
  }
}
