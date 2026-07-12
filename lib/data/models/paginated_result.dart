class PaginatedResult<T> {
  const PaginatedResult({required this.data, required this.count});

  final List<T> data;
  final int count;
}
