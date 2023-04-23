import 'dart:developer';

import 'package:hive/hive.dart';

///Hold all the methods for hive get, put and post
class HiveLocalDatabase {
  final HiveInterface hive;
  HiveLocalDatabase({required this.hive});

  ///Store the data object to db
  addDataToLocalHiveDb<T>(T dataObject, String boxKey, String key) async {
    try {
      final hiveBox = await hive.openBox(boxKey);
      // await hiveBox.put(typeId, dataObject);
      await hiveBox.put(key, dataObject);
    } catch (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
    }
  }

  //Remove the data object from db
  Future removeDataFromLocalHiveDb(String boxKey, String key) async {
    final hiveBox = await hive.openBox(boxKey);
    //await hiveBox.delete(typeId);
    await hiveBox.delete(key);
  }

  //Retreive data from local hive db
  Future<dynamic> getDataFromHiveDb<T>(String boxKey) async {
    try {
      final hiveBox = await hive.openBox(boxKey);
      //fetch all the items and return
      final List<T> items = [];

      for (var index in hiveBox.keys) {
        items.add(hiveBox.get(index));
      }
      return items;
    } catch (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
    }
    return null;
  }

  // //Update data in database
  // Future<dynamic> updateDataToDatabase(String boxKey, String key)async{
  //   //open the box first
  //   try{
  //     final hiveBox = await hive.openBox(boxKey);

  //     hiveBox.put(key, value)
  //   }catch(error, stackTrace){
  //     log(error.toString(), stackTrace: stackTrace);
  //   }
  // }
}
