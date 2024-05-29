import 'package:json_annotation/json_annotation.dart';

part 'coffee.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class Coffee {
  const Coffee({
    required this.file,
  });

  /// Connect the generated [_$CoffeeFromJson] function to the `fromJson`
  /// factory.
  factory Coffee.fromJson(Map<String, dynamic> json) => _$CoffeeFromJson(json);

  /// The file path of the coffee image.
  final String file;

  /// Connect the generated [_$CoffeeToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CoffeeToJson(this);
}
