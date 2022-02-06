class FieldCoordinates {
  final int column;
  final int row;

  FieldCoordinates({required this.column, required this.row});

  Map<String, dynamic> toJson() => {'column': column, 'row': row};
  factory FieldCoordinates.fromJson(Map<String, dynamic> json) =>
      FieldCoordinates(column: json['column'], row: json['row']);
}
