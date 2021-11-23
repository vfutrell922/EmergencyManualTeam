// EMT Medic Manual App for Mountain West Ambulance
// by Molly Clare, Vincent Futrell, Andrew Stender, and Sierra Johnson
// for their Senior Project 2021 at the University of Utah.

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
  final Uint8List Photo;
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
          Uint8List? Photo,
          int? IsQuickLink,
          String? Protocol}) =>
      Chart(
        id: id ?? this.id,
        Name: Name ?? this.Name,
        Photo: Photo ?? this.Photo,
        IsQuickLink: IsQuickLink ?? this.IsQuickLink,
        Protocol: Protocol ?? this.Protocol,
      );

  /// Take the list of data that we receive from the api and turn it into a Uint8List, which is easier to display
  static Uint8List grabPhoto(List<dynamic> rawphoto) {
    Uint8List blob =
        Uint8List.fromList(rawphoto.map((item) => item as int).toList());
    return blob;
  }

  /// Parse a json object as a phone number from the web API response
  static Chart fromWebJson(Map<String, Object?> json) => Chart(
        id: json[ChartFields.id] as int?,
        Name: json[ChartFields.Name] as String,
        Photo: grabPhoto(json[ChartFields.Photo] as List<dynamic>),
        //SQLflite does not accept booleans, so convert to integer
        IsQuickLink: ((json[ChartFields.IsQuickLink] as bool) ? 1 : 0),
        Protocol: json[ChartFields.Protocol] as String,
      );

  static Chart fromJson(Map<String, Object?> json) => Chart(
        id: json[ChartFields.id] as int?,
        Name: json[ChartFields.Name] as String,
        Photo: json[ChartFields.Photo] as Uint8List,
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
