import 'package:flutter_news/src/models/item_model.dart';
import 'package:flutter_news/src/resourses/repositories.dart';
import 'package:rxdart/rxdart.dart';

class StoriesBloc {
  final _repositories = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _itemsOutPut = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _itemsFetcher = PublishSubject<int>();

  Stream<Map<int, Future<ItemModel>>> get items => _itemsOutPut.stream;
  StoriesBloc() {
    _itemsFetcher.stream.transform(_itemTransform()).pipe(_itemsOutPut);
  }

  Stream<List<int>> get topIds => _topIds.stream;
  Function(int) get fetchItems => _itemsFetcher.sink.add;

  clearCache() {
    return _repositories.clearCache();
  }

  fetchTopIds() async {
    final ids = await _repositories.fetchTopIds();
    _topIds.sink.add(ids);
  }

  _itemTransform() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, index) {
        print(index);
        cache[id] = _repositories.fetchItems(id);
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }
}
