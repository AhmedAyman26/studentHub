import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bloc/bloc.dart';
import 'language_cach_helper.dart';
import 'language_states.dart';


class LanguageCubit extends Cubit<LanguageState>{
  LanguageCubit():super(LanguageInitialState());

  Future<void>getSavedLanguage()async{
     final String cachhedLanguageCode =
     await LanguageCacheHelper().getCachedLanguageCode();
     emit(ChangeLanguageState(locale: Locale(cachhedLanguageCode)));
  }
  Future<void>changeLanguage(String languageCode)async{
    await LanguageCacheHelper().cacheLanguageCode(languageCode);
    emit(ChangeLanguageState(locale: Locale(languageCode)));
  }
 // void toArabic()=>emit(selectedLanguageState(Locale('ar')));

 // void toEnglish()=>emit(selectedLanguageState(Locale('en')));
}

class RadioListTileCubit extends Cubit<int> {
  RadioListTileCubit() : super(0);

  void selectItem(int index) {
    emit(index);
  }
}