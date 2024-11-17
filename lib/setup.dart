import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:home_task/models/contacts_model.dart';
import 'package:home_task/models/model.dart';
import 'package:home_task/services/shared_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

// String? token;

late Box<AuthModel> box;
late Box<ContactsModel> box2;
late Box<bool> token;
late final SharedPreferences db;
late final StorageService service;

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AuthModelAdapter());
  Hive.registerAdapter(ContactsModelAdapter());
  box = await Hive.openBox<AuthModel>("user");
  box2 = await Hive.openBox<ContactsModel>("contacts");
  token = await Hive.openBox("token");
  db = await StorageService.init;
  service = StorageService(db: db);
}
