import 'package:equatable/equatable.dart';

class GridPosition extends Equatable {
  const GridPosition(this.x, this.y, this.width, this.height);
  final int x;
  final int y;
  final int width;
  final int height;

  @override
  String toString() => 'x: $x y: $y w: $width h: $height';

  @override
  List<Object> get props => [x, y, width, height];
}
