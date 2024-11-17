import 'package:hive/hive.dart';

part 'model.g.dart';

@HiveType(typeId: 0)
class AuthModel {
  @HiveField(0)
  String firstName;
  @HiveField(1)
  String lastName;

  AuthModel({
    required this.firstName,
    required this.lastName,
  });

  @override
  String toString() {
    return 'email: $firstName password: $lastName';
  }
}
