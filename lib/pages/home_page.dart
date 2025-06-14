import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mi CRUD"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 193, 145, 255),
      ),
      body: FutureBuilder(
        future: getPeople(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length + 1, // +1 para el botón
              itemBuilder: (context, index) {
                // Si es el primer elemento, mostramos el botón
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/home2');
                      },
                      icon: Icon(Icons.arrow_forward),
                      label: Text("Ir a HomePage2"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 193, 145, 255),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  );
                }

                // Ajustamos el índice para acceder correctamente a los datos
                final person = snapshot.data![index - 1];

                return Dismissible(
                  onDismissed: (direction) async {
                    await deletePerson(person['id']);
                    snapshot.data?.removeAt(index - 1);
                  },
                  confirmDismiss: (direction) async {
                    bool result = false;

                    result = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "¿Está seguro de querer eliminar a ${person['name']}?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                return Navigator.pop(context, false);
                              },
                              child: const Text("Cancelar"),
                            ),
                            TextButton(
                              onPressed: () {
                                return Navigator.pop(context, true);
                              },
                              child: const Text("Sí, estoy seguro"),
                            ),
                          ],
                        );
                      },
                    );
                    return result;
                  },
                  background: Container(
                    color: Colors.red,
                    child: const Icon(Icons.delete),
                  ),
                  direction: DismissDirection.endToStart,
                  key: Key(person['id']),
                  child: ListTile(
                    title: Text(person['name']),
                    onTap: () async {
                      await Navigator.pushNamed(
                        context,
                        "/edit",
                        arguments: {
                          "name": person['name'],
                          "id": person['id'],
                        },
                      );
                      setState(() {});
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
