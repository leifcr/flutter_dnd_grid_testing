import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testgrid/add_grid_item.dart';
import 'package:testgrid/dndgrid.dart';
import 'package:testgrid/grid_controller.dart';

// final GridController gridController = GridController(5, 8);

class GridApp extends StatelessWidget {
  const GridApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => GridController(5, 4),
        child: MaterialApp(
          title: 'Drag and Drop Example',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Scaffold(
            body: Container(
              color: Colors.white,
              child: Column(
                children: const [
                  Expanded(
                    flex: 1,
                    child: AddGridItem(),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Dndgrid(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

// class _DragAndDropExampleState extends State<DragAndDropExample> {
//   /// The [Draggable] and [DragTarget] need to be associated with some type of
//   /// data (through their type argument, and `void` doesn't cut it). We keep it
//   /// simple and use a key, since we don't actually need to communicate anything
//   /// about the dragged data.

//   /// Current position of the [DraggableGridItem].
//   // final List<GridItem> gridPositions = [];
//   @override
//   void initState() {
//     super.initState();
//     gridController.add(GridItem(position: GridPosition(0, 0, 1, 1), key: UniqueKey()));
//     gridController.add(GridItem(position: GridPosition(3, 3, 2, 2), key: UniqueKey()));
//   }

//   void gridItemMoved(GridItem item) {
//     setState(() {
//       gridController.move(item, item.position);
//       // if (position.key == draggablePosition.key) {
//       //   draggablePosition = position;
//       // } else if (position.key == draggablePosition2.key) {
//       //   draggablePosition2 = position;
//       // }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutGrid(
//       columnGap: 0,
//       rowGap: 0,
//       columnSizes: repeat(gridController.columnCount, [cellSize.px]),
//       rowSizes: repeat(gridController.rowCount, [cellSize.px]),
//       children: [
//         for (final cell in gridController.cells)
//           Cell(
//             cellData: cell,
//             cellBecameOccupied: gridItemMoved,
//           ).withGridPlacement(columnStart: cell.position.x, rowStart: cell.position.y),
//         // Fill the grid with a `DragTarget` per cell
//         ...buildDraggableItems()
//       ],
//     );
//   }
// }
