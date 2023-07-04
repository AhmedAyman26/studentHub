import 'dart:ui';

abstract class languageStates{
  //final Locale locale;
//  languageStates(this.locale);
}

class languageInitialState extends languageStates{
 // selectedLanguageState(Locale locale):super(locale);
}
class changeLanguageState extends languageStates{
  final Locale locale;
  changeLanguageState({required this.locale});
}