import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testgrid/grid_controller.dart';
import 'package:testgrid/grid_item.dart';
import 'package:testgrid/cell.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class Dndgrid extends StatelessWidget {
  const Dndgrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutGrid(
      columnGap: 0,
      rowGap: 0,
      columnSizes: repeat(Provider.of<GridController>(context).columnCount, [32.0.px]),
      rowSizes: repeat(Provider.of<GridController>(context).rowCount, [32.0.px]),
      children: [
        for (final cell in Provider.of<GridController>(context).cells)
          Cell(key: cell.key
                  // cellBecameOccupied: gridItemMoved,
                  )
              .withGridPlacement(columnStart: cell.position.x, rowStart: cell.position.y),
        // Fill the grid with a `DragTarget` per cell
        ...buildDraggableItems(context)
      ],
    );
  }

  List<GridPlacement> buildDraggableItems(BuildContext context) {
    return Provider.of<GridController>(context).gridItems.map((item) {
      return DraggableGridItem(
        onDraggableCanceledCallback: Provider.of<GridController>(context).resetColors,
        color: item.position.height > 1 ? Colors.green : Colors.red,
        key: item.key,
        gridItem: item,
      ).withGridPlacement(
        columnStart: item.position.x,
        rowStart: item.position.y,
        columnSpan: item.position.width,
        rowSpan: item.position.height,
      );
    }).toList();
  }
}
