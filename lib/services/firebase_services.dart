import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getPeople() async {
  List people = [];
  CollectionReference collectionReferencePeople = db.collection("people");
  QuerySnapshot queryPeople = await collectionReferencePeople.get();
  for (var doc in queryPeople.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final person= {
      "name": data['name'],
      "id": doc.id,
    };
    people.add(person);
  }
  return people;
}

//guardar los name
Future<void> addPerson(String name) async {
  await db.collection("people").add({"name": name});
}

//actualizar name
Future<void> updatePerson(String id, String newName) async {
  await db.collection("people").doc(id).update({"name": newName});
}

//borrar name
Future<void> deletePerson(String id) async {
  await db.collection("people").doc(id).delete();
}

