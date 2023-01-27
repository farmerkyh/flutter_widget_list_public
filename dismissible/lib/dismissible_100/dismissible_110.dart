import 'package:flutter/material.dart';

void main() async {
  runApp(DismissibleApp());
}

class DismissibleApp extends StatelessWidget {
  const DismissibleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Dismissible110());
  }
}

class Dismissible110 extends StatefulWidget {
  Dismissible110({Key? key}) : super(key: key);

  @override
  _Dismissible110State createState() => _Dismissible110State();
}

class _Dismissible110State extends State<Dismissible110> {
  final List<String> _items = List.generate(30, (index) => 'Item ${index + 1}');
  final List<String> _savedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dismissible Widget'),
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) => Dismissible(
          key: Key(_items[index]),
          //swipe 시 collback 함수
          //  confirmDismiss: 속성이 없을 경우 무조건 호출 됨
          //  confirmDismiss: 속성이 존재 시 true면 호출되고, false면 호출이 안됨
          onDismissed: (direction) => _onDismissed(direction, index),

          //swipe 시 collback 함수
          // - swipe한 list를 삭제할지 여부결정 : confirmDismiss의 callback함수의 결과가
          //   true이면 : list삭제하고, onDismissed: callback함수 호출
          //   flase이면 : list원복하고, onDismissed: callback함수 호출 하지 않음
          confirmDismiss: (direction) => _confirmDismiss(direction, context, index),
          background: _buildBackgroundWidget,
          secondaryBackground: _buildSecondBackgroundWidget,
          child: _buildListItem(index),
        ),
      ),
    );
  }

  Future<bool> _confirmDismiss(
    DismissDirection direction,
    BuildContext context,
    int index,
  ) {
    //왼쪽으로 swipe일 경우
    if (direction == DismissDirection.endToStart) {
      return showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('Are you sure?'),
              content: Text('Now I am deleting ${_items[index]}'),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    return Navigator.of(context).pop(false);
                  },
                  child: const Text('CANCEL'),
                ),
                ElevatedButton(
                  onPressed: () {
                    return Navigator.of(context).pop(true);
                  },
                  child: const Text('DELETE'),
                ),
              ],
            );
          }).then((value) => Future.value(value));

      //오른쪽 으로 swipe일 경우
    } else if (direction == DismissDirection.startToEnd) {
      return showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('Are you sure?'),
              content: Text('Now saving ${_items[index]}'),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    return Navigator.of(context).pop(false);
                  },
                  child: const Text('CANCEL'),
                ),
                ElevatedButton(
                  onPressed: () {
                    return Navigator.of(context).pop(true);
                  },
                  child: const Text('SAVE'),
                ),
              ],
            );
          }).then((value) => Future.value(value));
    }
    return Future.value(false);
  }

  void _onDismissed(DismissDirection direction, int index) {
    if (direction == DismissDirection.endToStart) {
      setState(() {
        _items.removeAt(index);
      });
    }
    if (direction == DismissDirection.startToEnd) {
      setState(() {
        _savedItems.add(_items[index]);
        _items.removeAt(index);
      });
    }
  }

  Card _buildListItem(int index) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 8,
      child: ListTile(
        leading: CircleAvatar(
          child: Text('${_items[index].split(' ')[1]}'),
        ),
        title: Text(
          _items[index],
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Container get _buildSecondBackgroundWidget => Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          size: 36,
          color: Colors.white,
        ),
      );

  Container get _buildBackgroundWidget => Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.green,
        alignment: Alignment.centerLeft,
        child: const Icon(
          Icons.save,
          size: 36,
          color: Colors.white,
        ),
      );
}
