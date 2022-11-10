import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static final _instance = SecureStorageHelper._();

  late FlutterSecureStorage flutterSecureStorage;

  factory SecureStorageHelper() {
    return _instance;
  }

  SecureStorageHelper._() {
    flutterSecureStorage = const FlutterSecureStorage();
  }

  Future<String?> readKey({required String key}) async {
    return await flutterSecureStorage.read(key: key);
  }

  Future write({required String key, required String value}) async {
    await flutterSecureStorage.write(key: key, value: value);
  }

  remove({required String key}) async {
    await flutterSecureStorage.delete(key: key);
  }
}
