import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:very_good_coffee_app/dao/coffee_dao.dart';
import 'package:very_good_coffee_app/dao/image_type_converter.dart';
import 'package:very_good_coffee_app/repositories/coffee/coffee.dart';

part 'database_service.g.dart';

@TypeConverters([ImageTypeConverter])
@Database(version: 1, entities: [Coffee])
abstract class DatabaseService extends FloorDatabase {
  CoffeeDao get coffeeDao;
}
