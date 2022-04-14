import 'package:flutter/material.dart';

const ktaskStrikeThrough = TextStyle(
  decoration: TextDecoration.lineThrough,
  fontSize: 18,
);

const ktaskNormal = TextStyle(
  fontSize: 18,
);

const kInputDecoration = InputDecoration(
  hintText: '',
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
);
