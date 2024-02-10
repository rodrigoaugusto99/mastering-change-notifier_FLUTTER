import 'package:flutter/material.dart';
import 'package:flutter_change_notifier/notifier/item_notifier.dart';
import 'package:flutter_change_notifier/widgets/app_bar.dart';

class AnimatedChangeNotifierExample extends StatefulWidget {
  const AnimatedChangeNotifierExample({Key? key}) : super(key: key);

  @override
  State<AnimatedChangeNotifierExample> createState() =>
      _AnimatedChangeNotifierExampleState();
}

// 1
ItemNotifier itemNotifier = ItemNotifier();

class _AnimatedChangeNotifierExampleState
    extends State<AnimatedChangeNotifierExample> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: itemNotifier,
      builder: (context, child) {
        return Scaffold(
          appBar: getAppBar("AnimatedBuilder Change Notifier Example"),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddPage(),
              ),
            ),
            child: const Icon(Icons.add),
          ),
          body: ListView.builder(
            itemCount: itemNotifier.getSize(),
            itemBuilder: (context, index) {
              return GestureDetector(
                //navegar para ModifyPage caso clique num item da lista
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ModifyPage(
                        index:
                            index), //index para saber qual elemento foi clicado
                  ),
                ),
                child: ListTile(
                  leading: CircleAvatar(child: Text(index.toString())),
                  //conteúdo da lista no indice dado
                  //chama função getItems do notifier
                  title: Text(itemNotifier.getItems()[index]),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class AddPage extends StatelessWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    return Scaffold(
      appBar: getAppBar("Adicionar ListTile"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //chama função add do notifier
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
      appBar: getAppBar("Atualizar lista"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //chama função modify do notifier
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
