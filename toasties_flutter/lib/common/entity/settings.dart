// ignore_for_file: avoid_print

class Settings {
  late bool isDarkMode;
  late DateTime? lastUpdated;
  late String? lastUpdatedString;

  Settings({
    this.isDarkMode = true,
    this.lastUpdated,
    this.lastUpdatedString,
  });

  void updateSettings({
    bool? isDarkMode,
    DateTime? lastUpdated,
    String? lastUpdatedString,
  }) {
    final currrentTimeStamp = DateTime.now();
    final currrentTimeStampString = currrentTimeStamp.toIso8601String(); // for debugging

    this.isDarkMode = isDarkMode ?? this.isDarkMode;
    this.lastUpdated = currrentTimeStamp;
    this.lastUpdatedString = currrentTimeStampString;
    print('Settings updated: $this');
  }

  /// DON'T USE THIS YET - Lahiru
  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      isDarkMode: json['isDarkMode'],
      lastUpdated: json['lastUpdated'],
      lastUpdatedString: json['lastUpdatedString'],
    );
  }

  /// DON'T USE THIS YET - Lahiru
  Map<String, dynamic> toJson() => {
        'isDarkMode': isDarkMode,
        'lastUpdated': lastUpdated,
        'lastUpdatedString': lastUpdatedString,
      };

  @override
  String toString() {
    // TODO: implement toString
    return 'Settings: isDarkMode: $isDarkMode, lastUpdated: $lastUpdated, lastUpdatedString: $lastUpdatedString';
  }

}
