import 'package:floor/floor.dart';
import 'package:very_good_coffee_app/repositories/coffee/coffee.dart';

@dao
abstract class CoffeeDao {
  @Query('SELECT * FROM coffees')
  Future<List<Coffee>> selectAllCoffees();

  @Query('SELECT * FROM coffees WHERE id = :id')
  Stream<Coffee?> selectCoffeeById(int id);

  @insert
  Future<void> insertCoffee(Coffee coffee);

  @delete
  Future<void> deleteCoffee(Coffee coffee);
}