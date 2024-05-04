import 'package:flutter/material.dart';

class ListTitle extends StatefulWidget {
  final String title;
  const ListTitle({super.key, required this.title});

  @override
  State<ListTitle> createState() => _ListTitleState();
}

class _ListTitleState extends State<ListTitle> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.title,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold
      ),
    );
  }
}