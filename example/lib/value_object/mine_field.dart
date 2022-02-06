import 'dart:math';

import 'package:eventuous_simplified_example/value_object/size.dart';

class MineField {
  final List<Cell> cells;

  MineField(this.cells);

  factory MineField.generate({required Size size, required int mineCount}) {
    List<Cell> cells = _createCells(size);
    cells = _setMines(cells, mineCount);
    return MineField(cells);
  }

  List<Cell> get mines => [...cells.where((cell) => cell.isMine)];

  static List<Cell> _createCells(Size size) {
    final fields = <Cell>[];
    for (var column = 0; column < size.width; column++) {
      for (var row = 0; row < size.height; row++) {
        fields.add(Cell(row: row, column: column));
      }
    }

    return fields;
  }

  static List<Cell> _setMines(List<Cell> cells, int mineCount) {
    final fieldsWithoutMines = cells;
    final fieldsWithMines = <Cell>[];

    while (fieldsWithMines.length < mineCount) {
      final randomNumber = Random().nextInt(fieldsWithoutMines.length);
      final fieldToBeMined = fieldsWithoutMines.removeAt(randomNumber);
      fieldsWithMines.add(fieldToBeMined.layMine());
    }

    return [
      ...fieldsWithoutMines,
      ...fieldsWithMines,
    ];
  }
}

class Cell {
  final int row;
  final int column;
  final bool isMine;

  Cell._({required this.row, required this.column, required this.isMine});

  factory Cell({required int row, required int column}) =>
      Cell._(row: row, column: column, isMine: false);

  Cell layMine() => Cell._(
        row: row,
        column: column,
        isMine: true,
      );
}
