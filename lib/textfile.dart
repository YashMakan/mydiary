import 'package:flutter/material.dart';

class TextFile extends StatefulWidget {
  final String text;

  const TextFile({Key key, this.text}) : super(key: key);
  @override
  _TextFileState createState() => _TextFileState();
}

class _TextFileState extends State<TextFile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(widget.text),
      ),
    );
  }
}
