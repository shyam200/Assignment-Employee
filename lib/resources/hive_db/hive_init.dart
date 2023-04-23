//This class to initialize hiveDB here

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveInit {
  ///Init method for instantiating the hive configuration.
  static hiveInit() async {
    final storageDir = await getApplicationDocumentsDirectory();
    Hive.init(storageDir.path);

    //register all the adapters
    // Hive.registerAdapter(WishlistItemModelAdapter());
  }
}
