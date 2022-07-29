import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: buildContainer(),
          subtitle: buildContainer(),
        ),
        const Divider(
          height: 5,
          color: Colors.grey,
        )
      ],
    );
  }

  Widget buildContainer() {
    return Container(
      height: 20,
      width: 50,
      color: Colors.grey[200],
      margin: const EdgeInsets.only(
        top: 5.0,
        bottom: 5.0,
      ),
    );
  }
}
