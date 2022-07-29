import 'package:flutter/material.dart';
import 'package:flutter_news/src/screens/news_list.dart';
import 'blocs/stories_provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoriesProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News!',
        // onGenerateRoute: (RouteSettings settings) {
        //   return MaterialPageRoute(
        //     builder: (context) {
        //       return const
        home: NewsList(),
        //     },
        //   );
        // },
        theme: ThemeData.dark().copyWith(
          primaryColor: Colors.red,
          appBarTheme: AppBarTheme.of(context).copyWith(
            backgroundColor: const Color.fromARGB(255, 175, 43, 41),
          ),
        ),
      ),
    );
  }
}
