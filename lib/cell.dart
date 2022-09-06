import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testgrid/cell_data.dart';
import 'package:testgrid/grid_controller.dart';
import 'package:testgrid/grid_position.dart';
import 'package:testgrid/grid_item.dart';

class Cell extends StatefulWidget {
  const Cell({required Key? key}) : super(key: key);

  @override
  _CellState createState() => _CellState();
}

class _CellState extends State<Cell> {
  GridController? gridController;
  CellData? cellData;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    gridController = Provider.of<GridController>(context);
    cellData = gridController?.getCellData(widget.key!);
    return DragTarget<GridItem>(
      onWillAccept: (data) {
        if (data == null) {
          return false;
        }
        return gridController!.freePosition(data.position, data.key);
      },
      onAccept: (data) {
        gridController?.resetColors();
        gridController?.move(data, GridPosition(cellData!.position.x, cellData!.position.y, data.position.width, data.position.height));
      },
      onMove: (details) {
        gridController?.onMove(details, cellData!);
      },
      onLeave: (details) {
        gridController?.onLeave(details!, cellData!);
      },
      // onLeave: (details) => setState(() => isDragHovering = false),
      builder: (context, candidateData, rejectedData) {
        return Container(
          // margin: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: cellData!.bgColor,
            border: Border.all(
              color: cellData!.borderColor,
              width: 2,
            ),
          ),
        );
      },
    );
  }
}

// class Cell extends StatelessWidget {
//   final CellData cellData;
//   const Cell({required this.cellData, Key? key}) : super(key: key);

//   // Override init state and store grid controller?

//   @override
//   Widget build(BuildContext context) {}
// }

// /// Acts as a position that can be occupied by the [DraggableGridItem] widget.
// class Cell extends StatefulWidget {
//   const Cell({
//     Key? key,
//     required this.cellData,
//     required this.cellBecameOccupied,
//   }) : super(key: key);

//   // final int column;
//   // final int row;
//   final CellData cellData;
//   final DragTargetAccept<GridItem> cellBecameOccupied;

//   @override
//   _CellState createState() => _CellState();
// }

// class _CellState extends State<Cell> {
//   bool isDragHovering = false;

//   @override
//   Widget build(BuildContext context) {
//     return DragTarget<GridItem>(
//       onWillAccept: (data) {
//         if (data == null) {
//           return false;
//         }
//         return Provider.of<GridController>(context).checkFreeAndSetColor(data.position, data.key);
//       },
//       onAccept: (data) {
//         print("onAccept: " + data.key.toString() + " " + data.position.toString());
//         setState(() => isDragHovering = false);
//         widget.cellBecameOccupied(
//             GridItem(position: GridPosition(widget.cellData.position.x, widget.cellData.position.y, data.position.width, data.position.height), key: data.key));
//       },
//       onMove: (details) {
//         // print(details);
//         setState(() => isDragHovering = true);
//       },
//       onLeave: (details) => setState(() => isDragHovering = false),
//       builder: (context, candidateData, rejectedData) {
//         // print("builder: " + data.key.toString() + " " + data.position.toString());
//         // print(candidateData);
//         return Container(
//           margin: const EdgeInsets.all(1),
//           decoration: BoxDecoration(
//             border: isDragHovering
//                 ? Border.all(
//                     color: Colors.purple[400]!,
//                     width: 2,
//                   )
//                 : Border.all(
//                     color: Colors.grey[400]!,
//                   ),
//           ),
//         );
//       },
//     );
//   }
// }
