import 'package:hive_ce/hive.dart';

abstract class BaseDao<T> {
  final String boxName;

  BaseDao(this.boxName);

  Future<Box<T>> get _box async => await Hive.openBox<T>(boxName);

  Future<T?> get(dynamic key) async {
    final box = await _box;
    return box.get(key);
  }

  Future<List<T>> getAll() async {
    final box = await _box;
    return box.values.toList();
  }

  Future<void> add(T item) async {
    final box = await _box;
    await box.add(item);
  }

  Future<void> addAll(List<T> items) async {
    final box = await _box;
    await box.addAll(items);
  }

  Future<void> update(dynamic key, T item) async {
    final box = await _box;
    await box.put(key, item);
  }

  Future<void> updateAll(Map<dynamic, T> items) async {
    final box = await _box;
    await box.putAll(items);
  }

  Future<void> delete(dynamic key) async {
    final box = await _box;
    await box.delete(key);
  }

  Future<void> clear() async {
    final box = await _box;
    await box.clear();
  }
}
