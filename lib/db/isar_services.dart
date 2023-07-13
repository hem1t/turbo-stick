import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timers/db/entities/presets.dart';

class IsarService extends ChangeNotifier {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open([PresetsSchema],
          directory: dir.path, inspector: true);
    }

    return Future.value(Isar.getInstance());
  }

  Future<void> savePreset(
      String presetName, String timerCode, List<int> vals) async {
    final isar = await db;
    final preset = Presets()
      ..presetName = presetName
      ..timerCode = timerCode
      ..timerVals = vals;
    isar.writeTxn(() => isar.presets.put(preset));
    notifyListeners();
  }

  Stream<List<Presets>> getPresets() async* {
    final isar = await db;
    yield* isar.presets.where().watch(fireImmediately: true);
  }
}
