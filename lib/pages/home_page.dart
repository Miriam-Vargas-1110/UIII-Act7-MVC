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
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  onDismissed: (direction) async {
                    await deletePerson(snapshot.data?[index]['id']);
                    snapshot.data?.removeAt(index);
                  },
                  confirmDismiss: (direction) async {
                    bool result = false;

                    result = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "Esta seguro de querer eliminar a ${snapshot.data?[index]['name']}?",
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
                              child: const Text("Si, estoy seguro"),
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
                  key: Key(snapshot.data?[index]['id']),
                  child: ListTile(
                    title: Text(snapshot.data?[index]['name']),
                    onTap: (() async {
                      await Navigator.pushNamed(
                        context,
                        "/edit",
                        arguments: {
                          "name": snapshot.data?[index]['name'],
                          "id": snapshot.data?[index]['id'],
                        },
                      );
                      setState(() {});
                    }),
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
