import 'package:flutter/material.dart';
import 'package:testgrid/coordinate.dart';

class CellData {
  CellData({required this.position, required this.key});
  final Key key;
  final Coordinate position;
  Color borderColor = Colors.grey[400]!;
  Color bgColor = Colors.white;

  @override
  String toString() {
    return "CellData: " + key.toString() + " " + position.toString() + " bg" + bgColor.toString() + " border " + borderColor.toString();
  }
}
