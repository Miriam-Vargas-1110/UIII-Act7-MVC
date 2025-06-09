import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_services.dart';

class EditProvedPage extends StatefulWidget {
  const EditProvedPage({super.key});

  @override
  State<EditProvedPage> createState() => _EditProvedPageState();
}

class _EditProvedPageState extends State<EditProvedPage> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();
  final TextEditingController direccionController = TextEditingController();
  final TextEditingController idProductosController = TextEditingController();
  final TextEditingController precioController = TextEditingController();
  final TextEditingController marcaController = TextEditingController();

  bool _isInit = false; // Para controlar que se inicialice solo 1 vez
  late Map arguments;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      arguments = ModalRoute.of(context)!.settings.arguments as Map;

      nombreController.text = arguments['nombre'] ?? '';
      numeroController.text = (arguments['numero'] ?? '').toString();
      direccionController.text = arguments['direccion'] ?? '';
      idProductosController.text = (arguments['id_productos'] ?? '').toString();
      precioController.text = (arguments['precio'] ?? '').toString();
      marcaController.text = arguments['marca'] ?? '';

      _isInit = true;
    }
  }

  @override
  void dispose() {
    // No olvides liberar los controladores cuando se destruya el widget
    nombreController.dispose();
    numeroController.dispose();
    direccionController.dispose();
    idProductosController.dispose();
    precioController.dispose();
    marcaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Proveedor')),
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
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: direccionController,
              decoration: const InputDecoration(hintText: 'Dirección'),
            ),
            TextField(
              controller: idProductosController,
              decoration: const InputDecoration(hintText: 'ID del Producto'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: precioController,
              decoration: const InputDecoration(hintText: 'Precio'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            TextField(
              controller: marcaController,
              decoration: const InputDecoration(hintText: 'Marca'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
               await updateProveedor(
                arguments['id'],
                {
                  "nombre": nombreController.text,
                  "numero": int.tryParse(numeroController.text) ?? 0,
                  "direccion": direccionController.text,
                  "id_productos": int.tryParse(idProductosController.text) ?? 0,
                  "precio": double.tryParse(precioController.text) ?? 0.0,
                  "marca": marcaController.text,
                },
              );
                Navigator.pop(context);
              },
              child: const Text("Actualizar"),
            ),
          ],
        ),
      ),
    );
  }
}
