import 'package:my_api/my_api.dart';

class Person extends ManagedObject<_Person> implements _Person{}

class _Person extends Serializable{
  @primaryKey
  int id;
  String name;
  @Column(unique: true)
  String email;

  @override
  Map<String, dynamic> asMap() {
    return {'id': id, 'name': name, 'email': email};
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    id = object[0] as int;
    name = object[1] as String;
    email = object[2] as String;
  }
}
