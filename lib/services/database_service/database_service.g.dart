// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_service.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $DatabaseServiceBuilderContract {
  /// Adds migrations to the builder.
  $DatabaseServiceBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $DatabaseServiceBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<DatabaseService> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorDatabaseService {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $DatabaseServiceBuilderContract databaseBuilder(String name) =>
      _$DatabaseServiceBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $DatabaseServiceBuilderContract inMemoryDatabaseBuilder() =>
      _$DatabaseServiceBuilder(null);
}

class _$DatabaseServiceBuilder implements $DatabaseServiceBuilderContract {
  _$DatabaseServiceBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $DatabaseServiceBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $DatabaseServiceBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<DatabaseService> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$DatabaseService();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$DatabaseService extends DatabaseService {
  _$DatabaseService([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CoffeeDao? _coffeeDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `coffees` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `url` TEXT NOT NULL, `image` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CoffeeDao get coffeeDao {
    return _coffeeDaoInstance ??= _$CoffeeDao(database, changeListener);
  }
}

class _$CoffeeDao extends CoffeeDao {
  _$CoffeeDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _coffeeInsertionAdapter = InsertionAdapter(
            database,
            'coffees',
            (Coffee item) => <String, Object?>{
                  'id': item.id,
                  'url': item.url,
                  'image': _imageTypeConverter.encode(item.image)
                },
            changeListener),
        _coffeeDeletionAdapter = DeletionAdapter(
            database,
            'coffees',
            ['id'],
            (Coffee item) => <String, Object?>{
                  'id': item.id,
                  'url': item.url,
                  'image': _imageTypeConverter.encode(item.image)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Coffee> _coffeeInsertionAdapter;

  final DeletionAdapter<Coffee> _coffeeDeletionAdapter;

  @override
  Future<List<Coffee>> selectAllCoffees() async {
    return _queryAdapter.queryList('SELECT * FROM coffees',
        mapper: (Map<String, Object?> row) => Coffee(
            image: _imageTypeConverter.decode(row['image'] as String),
            url: row['url'] as String,
            id: row['id'] as int?));
  }

  @override
  Stream<Coffee?> selectCoffeeById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM coffees WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Coffee(
            image: _imageTypeConverter.decode(row['image'] as String),
            url: row['url'] as String,
            id: row['id'] as int?),
        arguments: [id],
        queryableName: 'coffees',
        isView: false);
  }

  @override
  Future<int> insertCoffee(Coffee coffee) {
    return _coffeeInsertionAdapter.insertAndReturnId(
        coffee, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteCoffee(Coffee coffee) async {
    await _coffeeDeletionAdapter.delete(coffee);
  }
}

// ignore_for_file: unused_element
final _imageTypeConverter = ImageTypeConverter();
