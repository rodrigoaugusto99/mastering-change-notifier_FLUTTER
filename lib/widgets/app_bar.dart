import 'package:flutter/material.dart';

AppBar getAppBar(String title) {
  return AppBar(
    backgroundColor: Colors.deepPurple,
    centerTitle: true,
    elevation: 0,
    title: Text(title),
  );
}
