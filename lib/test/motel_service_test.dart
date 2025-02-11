import 'package:flutter_test/flutter_test.dart';
import 'package:motel_listing/services/motel_service.dart';
import 'package:motel_listing/models/motel.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'dart:convert';

import 'motel_service_test.mocks.dart';

@GenerateMocks([http.Client]) // Gera um mock para http.Client
void main() {
  late MotelService motelService;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    motelService = MotelService(client: mockClient);
  });

  group('MotelService', () {
    test('deve retornar uma lista de motéis quando a resposta for 200', () async {
      when(mockClient.get(Uri.parse("https://jsonkeeper.com/b/1IXK"))).thenAnswer((_) async =>
          http.Response(
            jsonEncode([
              {
                "nome": "Motel A",
                "precoMinimo": 100.0,
                "fotos": ["https://example.com/motel_a.jpg"],
                "itens": [],
                "periodos": [
                  {"valor": 100.0}
                ]
              }
            ]),
            200,
          ));

      final motels = await motelService.fetchMotels();
      expect(motels, isA<List<Motel>>());
      expect(motels.first.nome, "Motel A");
      expect(motels.first.precoMinimo, 100.0);
    });

    test('deve lançar uma exceção quando a resposta for diferente de 200', () async {
      when(mockClient.get(Uri.parse("https://jsonkeeper.com/b/1IXK")))
          .thenAnswer((_) async => http.Response('Erro', 404));

      expect(motelService.fetchMotels(), throwsException);
    });
  });
}
