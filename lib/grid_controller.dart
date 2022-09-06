import 'package:flutter/material.dart';
import 'package:testgrid/cell_data.dart';
import 'package:testgrid/coordinate.dart';
import 'package:testgrid/grid_position.dart';
import 'package:testgrid/grid_item.dart';

class GridController extends ChangeNotifier {
  final List<GridItem> gridItems = [];
  final List<CellData> cells = [];
  final int rowCount;
  final int columnCount;
  bool? lastIsFree;
  GridPosition? lastPosition;

  // final List<GridPosition> gridPositions = [];
  GridController(this.rowCount, this.columnCount) {
    for (int i = 0; i < columnCount; i++) {
      for (int j = 0; j < rowCount; j++) {
        cells.add(CellData(position: Coordinate(i, j), key: UniqueKey()));
      }
    }
    print("Init grid controller");
  }

  bool add(GridItem gridItem) {
    // Check if the position is free, if so, add
    if (freePosition(gridItem.position, gridItem.key)) {
      gridItems.add(gridItem);
      print("Added: " + gridItem.key.toString());
      notifyListeners();
      return true;
    }
    return false;
  }

  // bool insideGrid() {}

  void resetColors() {
    for (CellData cell in cells) {
      cell.bgColor = Colors.white;
      // cell.borderColor = Colors.grey[400]!;
    }
    notifyListeners();
  }

  void setColor(GridPosition position, Color color) {
    for (int i = position.x; i < position.x + position.width; i++) {
      for (int j = position.y; j < position.y + position.height; j++) {
        // Ensure that the cell exists, as the width/height might be larger than the grid
        if (i * rowCount + j < cells.length) {
          cells[i * rowCount + j].bgColor = color;
          // cells[i * rowCount + j].borderColor = color;
        }
      }
    }
  }

  // void onMove(GridItem? griditem) {}
  // void onLeave(GridItem? griditem) {}

  void onMove(DragTargetDetails<GridItem> griditem, CellData celldata) {
    // print(griditem);
    final GridPosition newPos = GridPosition(celldata.position.x, celldata.position.y, griditem.data.position.width, griditem.data.position.height);
    bool isFree = freePosition(newPos, griditem.data.key);
    // no need to notify if last free state and position is same.
    // print(newPos);
    // print(lastPosition);
    if ((lastIsFree = isFree) && (newPos == lastPosition)) {
      return;
    }
    if (lastPosition != null) {
      print("Reset color for: " + lastPosition.toString());
      setColor(lastPosition!, Colors.white);
    }
    lastPosition = newPos;

    if (isFree == false) {
      notifyListeners();
      return;
    }
    lastIsFree = isFree;
    setColor(newPos, Colors.green);
    notifyListeners();
    // print(griditem);
  }

  void onLeave(GridItem griditem, CellData celldata) {
    // Check if there are cells that should 'reset' their color
    // TODO Improve instead of reseting all cells
    // print("BEFORE UPDATE");
    // print(cells.firstWhere((element) => element.key == celldata.key));
    // // cells.firstWhere((element) => element.key == celldata.key).bgColor = Colors.orange;
    // print("AFTER UPDATE");
    // print(cells.firstWhere((element) => element.key == celldata.key));
    // print(celldata);
    // print(griditem);
    // notifyListeners();
  }

  CellData getCellData(Key key) {
    return cells.firstWhere((element) => element.key == key);
  }

  bool freePosition(GridPosition position, Key itemKey) {
    // Check if the position is free, if so, add
    // Check if item is within borders of entre grid
    if ((position.x + position.width > columnCount) || (position.y + position.height > rowCount)) {
      // print("Outside grid");
      return false;
    }
    // create new array of positions that must be 'free'
    final List<GridPosition> positionsToCheck = [];
    for (int i = 0; i < position.width; i++) {
      for (int j = 0; j < position.height; j++) {
        positionsToCheck.add(GridPosition(position.x + i, position.y + j, 1, 1));
      }
    }
    for (final item in gridItems) {
      if (item.key == itemKey) {
        continue;
      }
      for (final positionToCheck in positionsToCheck) {
        if ((item.position.x == positionToCheck.x) && (item.position.y == positionToCheck.y)) {
          return false;
        }
      }
    }
    // position is free, so set color on position
    return true;
  }

  void move(GridItem gridItem, GridPosition newPosition) {
    bool isfree = freePosition(newPosition, gridItem.key);
    if (isfree == false) {
      // print(gridItem.key);
      // print(isfree);
      return;
    }
    // Remove stored position and free state, since object is moved/stored
    lastIsFree = null;
    lastPosition = null;
    resetColors();
    int index = gridItems.lastIndexWhere((element) => element.key == gridItem.key);
    if (index != -1) {
      gridItems[index].updatePosition(newPosition);
    }
    notifyListeners();
  }
}
