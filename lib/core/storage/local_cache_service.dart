import 'package:get_storage/get_storage.dart';

/// Non-sensitive key/value cache (e.g. last-viewed filters, theme).
/// Requires `GetStorage.init()` to have completed before use.
class LocalCacheService {
  LocalCacheService({GetStorage? box}) : _box = box ?? GetStorage();

  final GetStorage _box;

  T? read<T>(String key) => _box.read<T>(key);

  Future<void> write(String key, dynamic value) => _box.write(key, value);

  Future<void> remove(String key) => _box.remove(key);
}
