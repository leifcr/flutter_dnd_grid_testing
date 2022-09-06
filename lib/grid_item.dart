import 'package:flutter/material.dart';
import 'package:testgrid/grid_position.dart';

// Calculate cell size from available space when drawing...
double cellSize = 32.0;

class GridItem {
  GridItem({required this.position, required this.key});
  final Key key;
  GridPosition position;

  updatePosition(GridPosition position) {
    this.position = position;
  }

  @override
  String toString() {
    return "GridItem: " + position.toString() + " " + key.toString();
  }
}

class DraggableGridItem extends StatelessWidget {
  final Color color;
  final GridItem gridItem;
  final Function onDraggableCanceledCallback;
  const DraggableGridItem({
    required this.color,
    required this.gridItem,
    required this.onDraggableCanceledCallback,
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final square = Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: color,
          width: 5,
        ),
      ),
    );

    return Draggable<GridItem>(
      data: gridItem,
      onDraggableCanceled: (velocity, offset) {
        onDraggableCanceledCallback();
      },
      // onDrag
      feedback: Opacity(
        opacity: 0.5,
        child: Transform.scale(
          scale: 1.2,
          // SizedBox is required here, because the feedback widget isn't bound
          // by a cell and wants to be zero-sized.
          child: SizedBox(
            width: cellSize * gridItem.position.width,
            height: cellSize * gridItem.position.height,
            child: square,
          ),
        ),
      ),
      // Fade a bit for style
      childWhenDragging: Opacity(
        opacity: 0.25,
        child: square,
      ),
      child: square,
    );
  }
}
