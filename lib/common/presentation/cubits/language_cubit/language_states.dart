import 'dart:ui';

abstract class LanguageState{
  //final Locale locale;
//  languageStates(this.locale);
}

class LanguageInitialState extends LanguageState{
 // selectedLanguageState(Locale locale):super(locale);
}
class ChangeLanguageState extends LanguageState{
  final Locale locale;
  ChangeLanguageState({required this.locale});
}