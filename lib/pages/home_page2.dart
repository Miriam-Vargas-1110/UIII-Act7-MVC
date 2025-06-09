import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_services.dart';

class Home2 extends StatefulWidget {
  const Home2({super.key});

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Proveedores"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 193, 145, 255),
      ),
      body: FutureBuilder(
        future: getprovedores(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final proveedor = snapshot.data?[index];
                return Dismissible(
                  onDismissed: (direction) async {
                    await deleteprovedores(proveedor['id']);
                    snapshot.data?.removeAt(index);
                  },
                  confirmDismiss: (direction) async {
                    bool result = false;

                    result = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "¿Está seguro de querer eliminar a ${proveedor['nombre']}?",
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
                  key: Key(proveedor['id']),
                  child: ListTile(
                    title: Text(proveedor['nombre']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Número: ${proveedor['numero']}"),
                        Text("Dirección: ${proveedor['direccion']}"),
                        Text("ID Producto: ${proveedor['id_productos']}"),
                        Text("Precio: \$${proveedor['precio']}"),
                        Text("Marca: ${proveedor['marca']}"),
                      ],
                    ),
                    isThreeLine: true,
                    onTap: () async {
                      await Navigator.pushNamed(
                      context,
                      "/edit2",
                      arguments: {
                        "id": proveedor['id'],
                        "nombre": proveedor['nombre'],
                        "numero": proveedor['numero'],
                        "direccion": proveedor['direccion'],
                        "id_productos": proveedor['id_productos'],
                        "precio": proveedor['precio'],
                        "marca": proveedor['marca'],
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
          await Navigator.pushNamed(context, '/add2');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
