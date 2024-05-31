import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'coffees')
class Coffee extends Equatable {
  const Coffee({
    required this.image,
    this.id,
    this.url,
  });

  @PrimaryKey(autoGenerate: true)
  final int? id;

  /// The url of the Coffee image.
  final String? url;

  /// The image data of the Coffee.
  final Uint8List? image;

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

  Coffee copyWith({
    int? id,
    String? url,
    Uint8List? image,
  }) {
    return Coffee(
      id: id ?? this.id,
      url: url ?? this.url,
      image: image ?? this.image,
    );
  }
}
