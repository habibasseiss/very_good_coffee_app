import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'coffee.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class Coffee extends Equatable {
  const Coffee({
    required this.file,
    this.image,
  });

  /// Connect the generated [_$CoffeeFromJson] function to the `fromJson`
  /// factory.
  factory Coffee.fromJson(Map<String, dynamic> json) => _$CoffeeFromJson(json);

  /// The file path of the coffee image.
  final String file;

  /// The image data of the coffee.
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Uint8List? image;

  /// Connect the generated [_$CoffeeToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CoffeeToJson(this);

  @override
  List<Object?> get props => [
        file,
        image,
      ];

  @override
  String toString() {
    return 'Coffee($file)';
  }

  Coffee copyWith({
    String? file,
    Uint8List? image,
  }) {
    return Coffee(
      file: file ?? this.file,
      image: image ?? this.image,
    );
  }
}
