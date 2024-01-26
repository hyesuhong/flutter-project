import 'dart:convert';

import 'package:flutter_application_1/models/toon_detail_model.dart';
import 'package:flutter_application_1/models/toon_episode_model.dart';
import 'package:flutter_application_1/models/toon_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseURL =
      'https://webtoon-crawler.nomadcoders.workers.dev';

  static const String today = 'today';
  static const String episodes = 'episodes';

  static Future<List<ToonModel>> getTodayToons() async {
    final url = Uri.parse('$baseURL/$today');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Error();
    }

    final List<dynamic> toons = jsonDecode(response.body);
    var toonData = toons.map((e) => ToonModel.fromJson(e)).toList();

    return toonData;
  }

  static Future<ToonDetailModel> getToonById(String id) async {
    final url = Uri.parse('$baseURL/$id');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Error();
    }

    final dynamic detail = jsonDecode(response.body);
    var detailData = ToonDetailModel.fromJson(detail);

    return detailData;
  }

  static Future<List<ToonEpisodeModel>> getLatestEpisodesById(String id) async {
    final url = Uri.parse('$baseURL/$id/$episodes');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Error();
    }

    final dynamic eps = jsonDecode(response.body);
    var episodesData = eps.map((e) => ToonEpisodeModel.fromJson(e)).toList();

    return episodesData;
  }
}
