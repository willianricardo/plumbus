class SearchParams {
  final String where;
  final int first;
  final int skip;
  final String order;

  SearchParams({
    required this.where,
    required this.first,
    required this.skip,
    required this.order,
  });
}
