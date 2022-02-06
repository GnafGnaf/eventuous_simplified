class Size {
  final int width;
  final int height;

  Size({required this.width, required this.height});
  Size.square(int size)
      : width = size,
        height = size;
}
