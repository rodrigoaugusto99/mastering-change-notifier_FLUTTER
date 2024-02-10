import 'package:flutter/material.dart';
import 'package:flutter_change_notifier/notifier/item_notifier.dart';
import 'package:flutter_change_notifier/widgets/app_bar.dart';
import 'package:flutter_change_notifier/widgets/list_tile.dart';

class ListenChangeNotifier extends StatefulWidget {
  const ListenChangeNotifier({Key? key}) : super(key: key);

  @override
  State<ListenChangeNotifier> createState() => _ListenChangeNotifierState();
}

// 1
ItemNotifier itemNotifier = ItemNotifier();

class _ListenChangeNotifierState extends State<ListenChangeNotifier> {
  @override
  void initState() {
    super.initState();
    itemNotifier.addListener(() => mounted ? setState(() {}) : null);
  }

  @override
  void dispose() {
    itemNotifier.removeListener(() {});
    super.dispose();
  }

  ListView _getListView() {
    return ListView.builder(
      itemCount: itemNotifier.getSize(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ModifyPage(index: index)),
          ),
          child: getListTile(itemNotifier.getItems(), index),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("Default Change Notifier Example"),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AddPage()),
        ),
        child: const Icon(Icons.add),
      ),
      body: _getListView(),
    );
  }
}

class AddPage extends StatelessWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController =
        TextEditingController(text: "Default Text");

    return Scaffold(
      appBar: getAppBar("Add ToDoItem"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          itemNotifier.add(textEditingController.text);
          Navigator.pop(context);
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: TextField(
            controller: textEditingController,
          ),
        ),
      ),
    );
  }
}

class ModifyPage extends StatelessWidget {
  const ModifyPage({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController =
        TextEditingController(text: itemNotifier.getItems()[index]);

    return Scaffold(
      appBar: getAppBar("Update ToDoItem"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          itemNotifier.modify(index, textEditingController.text);
          Navigator.pop(context);
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: TextField(
            controller: textEditingController,
          ),
        ),
      ),
    );
  }
}
