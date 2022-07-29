import 'package:flutter/cupertino.dart';
import 'package:flutter_news/src/blocs/stories_bloc.dart';

class StoriesProvider extends InheritedWidget {
  final StoriesBloc bloc;

  StoriesProvider({Key? key, Widget? child})
      : bloc = StoriesBloc(),
        super(key: key, child: child!);

  @override
  bool updateShouldNotify(_) => true;

  static StoriesBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StoriesProvider>()!.bloc;
  }
}
