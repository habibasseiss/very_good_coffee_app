import 'dart:typed_data';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

part 'coffee.g.dart';

@CopyWith()
@Entity(tableName: 'coffees')
class Coffee extends Equatable {
  const Coffee({
    required this.image,
    required this.url,
    this.id,
  });

  @PrimaryKey(autoGenerate: true)
  final int? id;

  /// The url of the Coffee image.
  final String url;

  /// The image data of the Coffee.
  final Uint8List image;

  @override
  List<Object?> get props => [
        id,
        url,
        image,
      ];

  @override
  String toString() {
    return 'Coffee($id)';
  }
}
