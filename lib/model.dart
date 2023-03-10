class model {
  int? uniqueID;
  String? name;

  model({this.uniqueID, this.name});

  Map<String, dynamic> toMap() {
    return {
      'uniqueID': uniqueID,
      'name': name,
    };
  }

  model.fromMap(Map<String, dynamic> json)
      : uniqueID = json['uniqueID'],
        name = json['name'];
}
