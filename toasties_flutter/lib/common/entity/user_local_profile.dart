
import 'package:toasties_flutter/common/entity/index.dart';

class UserLocalProfile{
  late String? userName;
  UserSettings settings;

  UserLocalProfile({
    this.userName = "",
    required this.settings,
  });

  factory UserLocalProfile.fromJson(Map<String, dynamic> json) {
    return UserLocalProfile(
      userName: json['userName'],
      settings: UserSettings.fromJson(json['settings']),
    );
  }

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'settings': settings.toJson()
      };

  @override
  String toString() {
    return 'UserLocalProfile: {userName: $userName, $settings}';
  }

}
