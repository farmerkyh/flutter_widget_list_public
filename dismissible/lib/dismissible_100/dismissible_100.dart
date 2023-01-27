import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: const Dismissible100(),
    );
  }
}

class Dismissible100 extends StatefulWidget {
  const Dismissible100({super.key});

  @override
  State<Dismissible100> createState() => _Dismissible100State();
}

class _Dismissible100State extends State<Dismissible100> {
  List<int> items = List<int>.generate(100, (int index) => index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dismissible')),
      body: ListView.builder(
        itemCount: items.length,
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            //swipe 시 background color
            background: Container(color: Colors.green),

            key: ValueKey<int>(items[index]),

            //swipe 시 collback 함수
            onDismissed: (DismissDirection direction) {
              setState(() {
                items.removeAt(index);
              });
            },

            //각 List생성
            child: ListTile(title: Text('Item ${items[index]}')),
          );
        },
      ),
    );
  }
}
