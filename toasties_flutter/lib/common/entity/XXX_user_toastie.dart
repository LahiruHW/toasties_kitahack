// import 'package:firebase_auth/firebase_auth.dart';

class UserTest {
  String? username;
  String? email;
  String? password;

  UserTest({
    this.username = 'new_user',
    this.email = '',
    this.password = '',
  });

  UserTest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() => {
        'id': username ?? '',
        'email': email ?? '',
        'password': password ?? '',
      };
}



// extension on User {
  
//   User get user => this;

//   String get username => this.displayName ?? 'new_user';

//   String get email => this.email ?? '';

//   String get password => this.password ?? '';

//   UserTest get userTest => UserTest(
//         username: this.displayName ?? 'new_user',
//         email: this.email ?? '',
//         password: this.password ?? '',
//       );
  
// }
