import 'package:flutter/material.dart';
import 'package:flutter_change_notifier/change%20notifier%20com%20provider/change_notifier_with_provider.dart';
import 'package:flutter_change_notifier/notifier/item_notifier.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ItemNotifier(),
      child: const MaterialApp(
        home: ChangeNotifierWithProvider(),
      ),
    );
  }
}
