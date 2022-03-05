import 'package:flutter/material.dart';

class HomePageBuilder extends StatefulWidget {
  const HomePageBuilder({Key? key}) : super(key: key);

  @override
  State<HomePageBuilder> createState() => _HomePageBuilderState();
}

class _HomePageBuilderState extends State<HomePageBuilder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [Text('Home')],
    );
  }
}
