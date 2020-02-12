import 'package:my_api/model/person.dart';
import 'package:my_api/my_api.dart';

class PersonController extends ResourceController {
  PersonController(this.context);

  final ManagedContext context;
  
  @Operation.get()
  Future<Response> getPeople() async {
    final peopleQuery = Query<Person>(context);
    final people = await peopleQuery.fetch();
    return Response.ok(people);
  }

  @Operation.get('parameter')
  Future<Response> getPersonByName(@Bind.path('parameter') String name) async {
    final personQuery = Query<Person>(context)..where((person) => person.name).like(name);
    final person = await personQuery.fetch();
    return Response.ok(person);
  }

  @Operation.post()
  Future<Response> savePerson(@Bind.body(ignore: ['id']) Person person) async {
    final personQuery = Query<Person>(context)..values = person;
    final insertedPerson = await personQuery.insert();
    return Response.ok(insertedPerson);
  }

  @Operation.put('parameter')
  Future<Response> updatePerson(@Bind.path('parameter') int id, @Bind.body() Person person) async {
    final personQuery = Query<Person>(context)..values = person..where((person) => person.id).equalTo(id);
    final updatedPerson = await personQuery.updateOne();
    return Response.ok(updatedPerson);
  }

  @Operation.delete('parameter')
  Future<Response> deletePerson(@Bind.path('parameter') int id) async {
    final personQuery = Query<Person>(context)..where((person) => person.id).equalTo(id);
    final deletePerson = await personQuery.delete();
    return Response.ok(deletePerson);
  }
}
