import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_services.dart';

class AddProvedPage extends StatefulWidget {
  const AddProvedPage({super.key});

  @override
  State<AddProvedPage> createState() => _AddProvedPageState();
}

class _AddProvedPageState extends State<AddProvedPage> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();
  final TextEditingController direccionController = TextEditingController();
  final TextEditingController idProductosController = TextEditingController();
  final TextEditingController precioController = TextEditingController();
  final TextEditingController marcaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Proveedor')),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(hintText: 'Nombre'),
            ),
            TextField(
              controller: numeroController,
              decoration: const InputDecoration(hintText: 'Número'),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: direccionController,
              decoration: const InputDecoration(hintText: 'Dirección'),
            ),
            TextField(
              controller: idProductosController,
              decoration: const InputDecoration(hintText: 'ID del Producto'),
            ),
            TextField(
              controller: precioController,
              decoration: const InputDecoration(hintText: 'Precio'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: marcaController,
              decoration: const InputDecoration(hintText: 'Marca'),
            ),
            const SizedBox(height: 20),
           ElevatedButton(
            onPressed: () async {
              await addProveedor({
                "nombre": nombreController.text,
                "numero": int.tryParse(numeroController.text) ?? 0,
                "direccion": direccionController.text,
                "id_productos": int.tryParse(idProductosController.text) ?? 0,
                "precio": double.tryParse(precioController.text) ?? 0.0,
                "marca": marcaController.text,
              });
              Navigator.pop(context);
            },
            child: const Text("Guardar"),
          ),
          ],
        ),
      ),
    );
  }
}
