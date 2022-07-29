import 'package:flutter/material.dart';
import 'package:flutter_news/src/blocs/stories_provider.dart';
import 'package:flutter_news/src/widgets/loding_container.dart';
import '../models/item_model.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;
  const NewsListTile(this.itemId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return const LoadingContainer();
        }
        return FutureBuilder(
            future: snapshot.data![itemId],
            builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
              if (!itemSnapshot.hasData) {
                return const LoadingContainer();
              }
              return buildTile(itemSnapshot.data!, context);
            });
      },
    );
  }

  Widget buildTile(ItemModel item, context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return detailsScreen(item);
                },
              ),
            );
          },
          child: ListTile(
            title: Text(
              item.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text("${item.score} points by ${item.by}"),
            trailing: Column(
              children: [
                const Icon(Icons.comment),
                Text('${item.descendants}'),
              ],
            ),
          ),
        ),
        const Divider(
          height: 5.0,
          color: Colors.blueGrey,
        ),
      ],
    );
  }

  Widget detailsScreen(ItemModel item) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Text(
          item.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
