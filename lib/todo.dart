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
}
