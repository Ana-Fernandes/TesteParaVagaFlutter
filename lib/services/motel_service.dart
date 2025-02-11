import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/io_client.dart';

import '../models/motel.dart';

class MotelService {
  final http.Client client;

  MotelService({http.Client? client}) : client = client ?? _createHttpClient();

  static http.Client _createHttpClient() {
    return HttpClientHelper.createClient();
  }

  Future<List<Motel>> fetchMotels() async {
    final response = await client.get(
      Uri.parse("https://jsonkeeper.com/b/1IXK"),
      headers: {"Accept": "application/json"},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return (data['suites'] as List)
          .map((json) => Motel.fromJson(json))
          .toList();
    } else {
      throw Exception('Falha ao carregar motéis');
    }
  }
}

// Classe que ignora SSL
class HttpClientHelper {
  static http.Client createClient() {
    if (kIsWeb) {
      return http.Client(); // No Web, SSL não pode ser ignorado
    } else {
      HttpClient client = HttpClient();
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return IOClient(client);
    }
  }
}
