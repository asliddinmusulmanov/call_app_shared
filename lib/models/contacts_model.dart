import 'package:hive/hive.dart';

part 'contacts_model.g.dart';

@HiveType(typeId: 1)
class ContactsModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  String number;

  ContactsModel({required this.name, required this.number});
}
