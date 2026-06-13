/// A standalone gallery photo that is NOT attached to a food record.
/// Created when the user takes a photo from the Gallery tab and skips
/// filling in a full record.
class GalleryPhoto {
  // MARK: - Properties
  final String path;
  final DateTime date;

  // MARK: - Init
  GalleryPhoto({
    required this.path,
    required this.date,
  });

  // MARK: - Serialization
  Map<String, dynamic> toJson() {
    return {
      'path': path,
      'date': date.toIso8601String(),
    };
  }

  factory GalleryPhoto.fromJson(Map<String, dynamic> json) {
    return GalleryPhoto(
      path: json['path'] as String,
      date: DateTime.parse(json['date'] as String),
    );
  }
}
