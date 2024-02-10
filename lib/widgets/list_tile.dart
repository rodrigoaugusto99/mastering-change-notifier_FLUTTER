import 'package:flutter/material.dart';

ListTile getListTile(List<String> items, int index) {
  return ListTile(
    leading: CircleAvatar(child: Text(index.toString())),
    contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
    title: Text(items[index]),
  );
}
