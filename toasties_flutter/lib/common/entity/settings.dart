// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

class UserSettings {
  late bool isDarkMode;
  late Timestamp? lastUpdated;
  late String? lastUpdatedString;

  UserSettings({
    this.isDarkMode = false,
    this.lastUpdated,
    this.lastUpdatedString,
  });

  void updateSettings({
    bool? isDarkMode,
    DateTime? lastUpdated,
    String? lastUpdatedString,
  }) {
    final currrentTimeStamp = Timestamp.now();
    final currrentTimeStampString = currrentTimeStamp.toDate().toIso8601String(); // for debugging

    this.isDarkMode = isDarkMode ?? this.isDarkMode;
    this.lastUpdated = currrentTimeStamp;
    this.lastUpdatedString = currrentTimeStampString;
    print('Settings updated: $this');
  }

  /// DON'T USE THIS YET - Lahiru
  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(
      isDarkMode: json['isDarkMode'],
      lastUpdated: json['lastUpdated'],
      lastUpdatedString: json['lastUpdatedString'],
    );
  }

  Map<String, dynamic> toJson() => {
        'isDarkMode': isDarkMode,
        'lastUpdated': lastUpdated ?? Timestamp.now(),
      };

  @override
  String toString() {
    return 'Settings: {isDarkMode: $isDarkMode, lastUpdated: $lastUpdated, lastUpdatedString: $lastUpdatedString}';
  }

}
