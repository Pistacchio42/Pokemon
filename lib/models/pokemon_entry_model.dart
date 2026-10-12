import 'package:flutter/material.dart';

class Entry{


  final double number;
  final String name;
  final String type1;
  final String type2;
  final String sprite;
  bool caught;

  Entry(this.name, this.type1, this.type2, this.sprite, this.caught, {required this.number});

}