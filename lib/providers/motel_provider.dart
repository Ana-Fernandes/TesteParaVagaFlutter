import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/motel.dart';

class MotelProvider extends ChangeNotifier {
  List<Motel> _motels = [];
  List<Motel> get motels => _motels;

  // Método para carregar os motéis
  Future<void> fetchMotels() async {
    try {
      final response = await http.get(Uri.parse('https://www.npoint.io/docs/e728bb91e0cd56cc0711'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body); // Mudança: Agora esperamos um mapa

        // Se os motéis estiverem dentro de uma chave "motels"
        final List<dynamic> motelsData = data['motels']; // Adapte conforme o formato da API
        _motels = motelsData.map((json) => Motel.fromJson(json)).toList();

        // Atualizando o estado após a requisição, fora do ciclo de construção
        notifyListeners();
      } else {
        throw Exception('Falha ao carregar motéis');
      }
    } catch (error) {
      throw error;
    }
  }
}
