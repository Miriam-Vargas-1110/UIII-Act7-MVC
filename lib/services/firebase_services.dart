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

Future<List> getprovedores() async {
  List provedores = [];
  CollectionReference collectionReferenceprovedores = db.collection("provedores");
  QuerySnapshot queryprovedores = await collectionReferenceprovedores.get();

  for (var doc in queryprovedores.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    final proveedor = {
      "id": doc.id,
      "nombre": data['nombre'] ?? '',
      "numero": data['numero'] ?? 0,
      "direccion": data['direccion'] ?? '',
      "id_productos": data['id_productos'] ?? 0,
      "precio": (data['precio'] != null) ? data['precio'].toDouble() : 0.0,
      "marca": data['marca'] ?? '',
    };

    provedores.add(proveedor);
  }

  return provedores;
}

Future<void> addProveedor(Map<String, dynamic> data) async {
  await db.collection("provedores").add(data);
}


//actualizar name
Future<void> updateProveedor(String id, Map<String, dynamic> data) async {
  await FirebaseFirestore.instance.collection('provedores').doc(id).update(data);
}

//borrar name
Future<void> deleteprovedores(String id) async {
  await db.collection("provedores").doc(id).delete();
}