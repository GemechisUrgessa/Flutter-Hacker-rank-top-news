import 'package:flutter/material.dart';
import 'package:flutter_news/src/blocs/stories_bloc.dart';
import 'package:flutter_news/src/blocs/stories_provider.dart';
import 'package:flutter_news/src/widgets/news_list_tile.dart';
import 'package:flutter_news/src/widgets/refresh.dart';

import '../models/item_model.dart';
import '../widgets/loding_container.dart';

class NewsList extends StatelessWidget {
  const NewsList({Key? key}) : super(key: key);
  // ItemModel item;
  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    bloc.fetchTopIds();
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Top Trending Hacker News! '),
          ),
        ),
        body: buildList(bloc));
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Refresh(
          child: ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, int index) {
              bloc.fetchItems(snapshot.data![index]);
              return NewsListTile(snapshot.data![index]);
              // onTap: () {
              //   Navigator.push(
              //     context,
              // MaterialPageRoute(
              //   builder: (context) {
              //     final bloc1 = StoriesProvider.of(context);
              //     return StreamBuilder(
              //       stream: bloc1.items,
              //       builder: (context,
              //           AsyncSnapshot<Map<int, Future<ItemModel>>>
              //               snapshot) {
              // if (!snapshot.hasData) {
              //   return const LoadingContainer();
              // }
              // return FutureBuilder(
              //   future: snapshot.data![snapshot.data![index]],
              //   builder: (context,
              // AsyncSnapshot<ItemModel> itemSnapshot) {
              // if (!itemSnapshot.hasData) {
              //   return const LoadingContainer();
              // }
              // return Scaffold(
              //   appBar: AppBar(
              //     title: Text(itemSnapshot.data!.title),
              //   ),
              //   body: Text("by"),
              // );
              // },
              // );
              //       },
              //     );
              //   },
              // ),
            },
          ),
        );
      },
    );
  }
}
