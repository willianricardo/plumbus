abstract class IDatabaseAdapter {
  Future<void> close();

  Future<int> delete(
    String table, {
    String where,
    List<dynamic> whereArgs,
  });

  Future<void> execute(String sql, [List<dynamic> arguments]);

  Future<List<Map<String, dynamic>>> query(
    String table, {
    String where,
    List<dynamic> whereArgs,
    String groupBy,
    String having,
    String orderBy,
    int limit,
    int offset,
  });

  Future<int> update(
    String table,
    Map<String, dynamic> values, {
    String where,
    List<dynamic> whereArgs,
  });
}
