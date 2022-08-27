class ToDo {
  String name;
  bool status = false;

  ToDo({required this.name, this.status = false});

  ToDo.fromJSON(Map<String, dynamic> json)
      : name = json['name'],
        status = json['status'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'status': status,
      };

  @override
  String toString() {
    return "${runtimeType.toString()} = {Name : $name, Statut : $status}";
  }
}
