import 'package:get_storage/get_storage.dart';

class NLocalStorage {
  late final GetStorage _storage;
  NLocalStorage._internal();
  // SingleTon instance
static NLocalStorage? _instance;
  factory NLocalStorage.instance() {
    _instance ??= NLocalStorage._internal();
    return _instance!;
  }

  // storing user info and other on local storage
  static Future<void> init(String bucketName)async {
    await GetStorage.init(bucketName);
    _instance =NLocalStorage._internal();
    _instance!._storage=GetStorage(bucketName);

  }
  Future<void> writeData<N>(String key, N value) async{
    await _storage.write(key, value);
  }





  // Generic method to save data
  Future<void> saveData<N>(String key, N value) async {
    await _storage.write(key, value);
  }

//Generic method to read the data
  N? readData<N>(String key) {
    return _storage.read<N>(key);
  }

//Generic Method to remove the data
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  Future<void> clearAll() async {
    await _storage.erase();
  }
}
