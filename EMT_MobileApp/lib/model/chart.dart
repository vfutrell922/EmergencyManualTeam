import 'dart:typed_data';

final String tableCharts = 'charts';

class ChartFields {
  static final List<String> values = [
    id,
    Name,
    Photo,
    IsQuickLink,
  ];

  static final String id = '_id';
  static final String Name = 'Name';
  static final String Photo = 'Photo';
  static final String IsQuickLink = 'IsQuickLink';
}

class Chart {
  final int? id;
  final String Name;
  final Uint8List Photo;
  final int IsQuickLink;

  const Chart({
    this.id,
    required this.Name,
    required this.Photo,
    required this.IsQuickLink,
  });

  Chart copy({int? id, String? Name, Uint8List? Photo, int? IsQuickLink}) =>
      Chart(
        id: id ?? this.id,
        Name: Name ?? this.Name,
        Photo: Photo ?? this.Photo,
        IsQuickLink: IsQuickLink ?? this.IsQuickLink,
      );

  static Chart fromWebJson(Map<String, Object?> json) => Chart(
        id: json[ChartFields.id] as int?,
        Name: json[ChartFields.Name] as String,
        Photo: json[ChartFields.Photo] as Uint8List,
        IsQuickLink: ((json[ChartFields.IsQuickLink] as bool) ? 1 : 0),
      );

  static Chart fromJson(Map<String, Object?> json) => Chart(
        id: json[ChartFields.id] as int?,
        Name: json[ChartFields.Name] as String,
        Photo: json[ChartFields.Photo] as Uint8List,
        IsQuickLink: json[ChartFields.IsQuickLink] as int,
      );

  Map<String, Object?> toJson() => {
        ChartFields.id: id,
        ChartFields.Name: Name,
        ChartFields.Photo: Photo,
        ChartFields.IsQuickLink: IsQuickLink,
      };
}
