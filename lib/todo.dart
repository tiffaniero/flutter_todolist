class ToDo {
  String _name;
  bool _status = false;

  ToDo(this._name);

  String getName() {
    return _name;
  }

  void setName(String name) {
    _name = name;
  }

  bool getStatus() {
    return _status;
  }

  void setStatus() {
    _status = _status ? true : false;
  }

  ToDo.fromJSON(Map<String, dynamic> json)
      : _name = json['name'],
        _status = json['status'];

  Map<String, dynamic> toJson() => {
        'name': _name,
        'status': _status,
      };

  @override
  String toString() {
    return "${runtimeType.toString()} = {Name : ${getName()}, Statut : ${getName()}}";
  }
}
