import 'package:flutter/material.dart';
import 'package:nepaliapp/utils/utils.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Utils utils = Utils();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(utils.name),
        backgroundColor: utils.primaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
    );
  }
}
