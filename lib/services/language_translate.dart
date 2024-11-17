import 'package:home_task/services/ru.dart';
import 'package:home_task/services/uz.dart';

import 'en.dart';
import 'language_service.dart';

extension TranslateString on String {
  String get tr {
    switch (LanguageService.getLanguage) {
      case Language.uz:
        {
          return uz[this] ?? this;
        }
      case Language.en:
        {
          return en[this] ?? this;
        }
      case Language.ru:
        {
          return ru[this] ?? this;
        }
    }
  }
}
