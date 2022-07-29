import 'dart:convert';

class ItemModel {
  final int id;
  final bool? deleted;
  final String type;
  final String? by;
  final int? time;
  final String text;
  final bool dead;
  final int? parent;
  final List<dynamic>? kids;
  final String? urls;
  final int? score;
  final String title;
  final int? descendants;

  ItemModel.fromJson(Map<String, dynamic> parsedJason)
      : id = parsedJason['id'],
        deleted = parsedJason['deleted'] ?? false,
        type = parsedJason['type'],
        by = parsedJason['by'],
        time = parsedJason['time'],
        text = parsedJason['text'] ?? '',
        dead = parsedJason['dead'] ?? false,
        parent = parsedJason['parent'] ?? 0,
        kids = parsedJason['kids'] ?? [],
        urls = parsedJason['urls'] ?? '',
        score = parsedJason['score'],
        title = parsedJason['title'],
        descendants = parsedJason['descendants'] ?? 0;

  ItemModel.fromDb(Map<String, dynamic> parsedJason)
      : id = parsedJason['id'],
        deleted = parsedJason['deleted'] == 1,
        type = parsedJason['type'],
        by = parsedJason['by'],
        time = parsedJason['time'],
        text = parsedJason['text'],
        dead = parsedJason['dead'] == 1,
        parent = parsedJason['parent'],
        kids = jsonDecode(parsedJason['kids']),
        urls = parsedJason['urls'],
        score = parsedJason['score'],
        title = parsedJason['title'],
        descendants = parsedJason['descendants'] ?? 0;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'deleted': deleted! ? 1 : 0,
      'type': type,
      'by': by,
      'time': time,
      'text': text,
      'dead': dead ? 1 : 0,
      'parent': parent,
      'kids': jsonEncode(kids),
      'urls': urls,
      'score': score,
      'title': title,
      'descendants': descendants,
    };
  }
}
