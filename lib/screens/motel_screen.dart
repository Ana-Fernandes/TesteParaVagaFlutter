import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/motel.dart';

class MotelScreen extends StatelessWidget {
  const MotelScreen({super.key});

  Future<List<Motel>> fetchMotels() async {
    final response = await http.get(Uri.parse('https://jsonkeeper.com/b/1IXK'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data.containsKey('data') &&
          data['data'].containsKey('moteis') &&
          (data['data']['moteis'] as List).isNotEmpty) {
        final List suites = data['data']['moteis'][0]['suites'];
        return suites.map((json) => Motel.fromJson(json)).toList();
      } else {
        throw Exception('Formato do JSON inválido ou sem suítes.');
      }
    } else {
      throw Exception('Falha ao carregar motéis');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quartos/Suítes',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: Colors.red,
      body: FutureBuilder<List<Motel>>(
        future: fetchMotels(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.white));
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro: ${snapshot.error}',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum motel encontrado',
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
            );
          }

          final motels = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: motels.length,
            itemBuilder: (context, index) {
              final motel = motels[index];
              return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: motel.fotos.isNotEmpty
                        ? Image.network(
                      motel.fotos[0],
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 80, color: Colors.grey),
                    )
                        : const Icon(Icons.image_not_supported, size: 80, color: Colors.grey),
                  ),
                  title: Text(
                    motel.nome,
                    style: const TextStyle(
                      fontFamily: 'Playfair Display',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    'Preço: R\$ ${motel.precoMinimo.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
