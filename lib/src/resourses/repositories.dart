import 'package:flutter_news/src/models/item_model.dart';
import 'package:flutter_news/src/resourses/news_api_provider.dart';
import 'package:flutter_news/src/resourses/news_db_provider.dart';

class Repository {
  List<Source> sources = <Source>[
    NewsApiProvider(),
    newsDbProvider,
  ];
  List<Cache> caches = <Cache>[
    newsDbProvider,
  ];

  Future<List<int>> fetchTopIds() {
    return sources[0].fetchTopIds()!;
  }

  Future<ItemModel> fetchItems(int id) async {
    ItemModel? item;
    var source;
    for (source in sources) {
      item = await source.fetchItems(id);
      if (item != null) {
        break;
      }
    }
    for (var cache in caches) {
      if (cache != source) {
        cache.addItem(item!);
      }
    }

    return item!;
  }

  clearCache() async {
    for (var cache in caches) {
      await cache.clear();
    }
  }
}

abstract class Source {
  Future<List<int>>? fetchTopIds();
  Future<ItemModel?> fetchItems(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
  Future<int> clear();
}
