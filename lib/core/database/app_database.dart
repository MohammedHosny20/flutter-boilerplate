import 'package:flutter/foundation.dart';
import 'package:flutter_boilerplate/app/wishlist/data/datasource/db/dao/wishlist_dao.dart';
import 'package:flutter_boilerplate/app/wishlist/data/model/db/database_wishlist_item.dart';
import 'package:flutter_boilerplate/core/database/generated/objectbox.g.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class AppDatabase {
  /// The Store of this app.
  late final Store store;

  /// Singleton instance created during the Playx boot phase and reused by
  /// Riverpod providers. ObjectBox does not allow multiple [Store] instances
  /// for the same directory within the same isolate, so we must keep a single
  /// instance across the app lifetime.
  static AppDatabase? _instance;

  AppDatabase._create(this.store) {
    // Add any additional setup code, e.g. build queries.
  }

  /// Create an instance of ObjectBox to use throughout the app.
  ///
  /// If [AppDatabase.init] has already been called during boot, the existing
  /// singleton is returned to avoid opening a second [Store] for the same
  /// directory (which ObjectBox rejects within a single isolate).
  static Future<AppDatabase> create() async {
    final existing = _instance;
    if (existing != null) {
      return existing;
    }

    final docsDir = await getApplicationDocumentsDirectory();
    final dbPath = p.join(docsDir.path, "app_database");

    final store = Store.isOpen(dbPath)
        ? Store.attach(getObjectBoxModel(), dbPath)
        : await openStore(directory: dbPath);

    final db = AppDatabase._create(store);
    _instance = db;
    return db;
  }

  //web app (Data Browser)
  late final Admin admin;
  void runTestWebApp() {
    if (Admin.isAvailable()) {
      admin = Admin(store);
    }
  }

  void close() {
    store.close();
    _instance = null;
  }

  //wishlist box
  late final _wishlistBox = store.box<DatabaseWishlistItem>();

  late final wishlistDao = WishlistDao(box: _wishlistBox);

  /// Initialises the database during the Playx boot phase.
  /// After the Riverpod migration, repositories obtain their data sources
  /// from Riverpod providers rather than from getIt.
  static Future<void> init() async {
    final database = await AppDatabase.create();

    if (kDebugMode) {
      database.runTestWebApp();
    }
  }
}
