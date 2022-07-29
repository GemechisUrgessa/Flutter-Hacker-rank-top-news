import 'package:flutter_news/src/models/item_model.dart';
import 'package:flutter_news/src/resourses/repositories.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

const _root = 'https://hacker-news.firebaseio.com';

class NewsApiProvider implements Source {
  Client client = Client();
  @override
  Future<List<int>> fetchTopIds() async {
    final response = await client.get(Uri.parse('$_root/v0/topstories.json'));
    final ids = json.decode(response.body);

    return ids.cast<int>();
  }

  @override
  Future<ItemModel> fetchItems(int id) async {
    final response = await client.get(Uri.parse('$_root/v0/item/$id.json'));

    final parsedJason = json.decode(response.body);

    return ItemModel.fromJson(parsedJason);
  }
}
