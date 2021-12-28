import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../secret/creds.dart' as secret;

const String host = "http://localhost:8080";

final headers = {
  "Content-Type": "application/json",
  "Authorization": secret.authHeader,
};

Map<String, String> _headers() {
  var headers = <String, String>{};
  headers.putIfAbsent("Content-Type", () => "application/json");
  headers.putIfAbsent("Authorization", () => secret.authHeader);
  return headers;
}

Future<Score> postScore(String name, int score) async {
  final response = await http.post(
      Uri.parse(host + "/scores/" + name + "/" + score.toString()),
      headers: headers);
  return Score.fromJson(json.decode(response.body));
}

Future<List> listScores(String name) async {
  final response =
      await http.get(Uri.parse(host + "/scores/" + name), headers: _headers());
  var scores = json.decode(response.body);
  var result = [];
  for (var s in scores) {
    result.add(Score.fromJson(s));
  }
  return result;
}

class Score {
  String? name;
  int? score;
  final String? date;

  Score({this.name, this.score, this.date});
  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
        date: json['formattedDate'], score: json['score'], name: json['name']);
  }
}
