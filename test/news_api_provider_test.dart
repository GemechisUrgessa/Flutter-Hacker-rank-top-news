

import 'dart:convert';

import 'package:flutter_news/src/resourses/news_api_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {

  test("Test our fetchTopIds return list of ids", () async{

    final newsApi = NewsApiProvider();

    newsApi.client = MockClient((request) async{
      return Response(json.encode([1,2,3,4]), 200);
    });

    final ids = await newsApi.fetchTopIds();
    expect(ids, [1,2,3,4]);
    
  });

  test("Test our fetchItem return items", () async{

    final newsApi = NewsApiProvider();

    newsApi.client = MockClient((request) async{
      final jsonMap = {'id': 123};
      return Response(json.encode(jsonMap), 200);
    });

    final item = await newsApi.fetchItems(990);
    expect(item.id, 123);
    
  });
}