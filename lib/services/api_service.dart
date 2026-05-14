import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/topic_model.dart';

class ApiService {
  static const String topicsUrl =
      'https://raw.githubusercontent.com/busratekdemir/ders_ajandam_data/main/lgs_topics.json';

  Future<List<TopicModel>> fetchTopics() async {
    final response = await http.get(Uri.parse(topicsUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data.map((item) => TopicModel.fromJson(item)).toList();
    } else {
      throw Exception('Konu listesi servisten alınamadı.');
    }
  }
}