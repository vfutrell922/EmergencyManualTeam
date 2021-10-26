import 'dart:typed_data';

final String tableCharts = 'charts';

class ChartFields {
  static final List<String> values = [
    id,
    Name,
    Photo,
    IsQuickLink,
    Protocol,
  ];

  static final String id = '_id';
  static final String Name = 'Name';
  static final String Photo = 'Photo';
  static final String IsQuickLink = 'IsQuickLink';
  static final String Protocol = 'Protocol';
}

class Chart {
  final int? id;
  final String Name;
  final String Photo;
  final int IsQuickLink;
  final String? Protocol;

  const Chart({
    this.id,
    required this.Name,
    required this.Photo,
    required this.IsQuickLink,
    this.Protocol,
  });

  Chart copy(
          {int? id,
          String? Name,
          String? Photo,
          int? IsQuickLink,
          String? Protocol}) =>
      Chart(
        id: id ?? this.id,
        Name: Name ?? this.Name,
        Photo: Photo ?? this.Photo,
        IsQuickLink: IsQuickLink ?? this.IsQuickLink,
        Protocol: Protocol ?? this.Protocol,
      );

  static Chart fromWebJson(Map<String, Object?> json) => Chart(
        id: json[ChartFields.id] as int?,
        Name: json[ChartFields.Name] as String,
        Photo: (json[ChartFields.Photo] as List<int>).join(","),
        IsQuickLink: ((json[ChartFields.IsQuickLink] as bool) ? 1 : 0),
        Protocol: json[ChartFields.Protocol] as String,
      );

  static Chart fromJson(Map<String, Object?> json) => Chart(
        id: json[ChartFields.id] as int?,
        Name: json[ChartFields.Name] as String,
        Photo: json[ChartFields.Photo] as String,
        IsQuickLink: json[ChartFields.IsQuickLink] as int,
        Protocol: json[ChartFields.Protocol] as String,
      );

  Map<String, Object?> toJson() => {
        ChartFields.id: id,
        ChartFields.Name: Name,
        ChartFields.Photo: Photo,
        ChartFields.IsQuickLink: IsQuickLink,
        ChartFields.Protocol: Protocol,
      };
}
