import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'coffee_response.g.dart';

@CopyWith()
@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class CoffeeResponse extends Equatable {
  const CoffeeResponse({
    required this.file,
  });

  /// Connect the generated [_$CoffeeResponseFromJson] function to the
  /// `fromJson` factory.
  factory CoffeeResponse.fromJson(Map<String, dynamic> json) =>
      _$CoffeeResponseFromJson(json);

  /// The file path of the CoffeeResponse image.
  final String file;

  /// Connect the generated [_$CoffeeResponseToJson] function to the `toJson`
  /// method.
  Map<String, dynamic> toJson() => _$CoffeeResponseToJson(this);

  @override
  List<Object> get props => [
        file,
      ];
}
