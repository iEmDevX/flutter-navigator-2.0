import 'package:flutter/material.dart';

class NotFound404Screen extends StatelessWidget {
  const NotFound404Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red[100],
        child: Center(
          child: Text(
            '404 Not Found',
            style: TextStyle(color: Colors.red[400], fontSize: 18),
          ),
        ),
      ),
    );
  }
}
