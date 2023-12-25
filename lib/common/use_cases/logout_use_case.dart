import 'package:graduation/common/preference_helper/preference_helper.dart';

class LogoutUseCase
{
  final PreferenceHelper _preferenceHelper;

  LogoutUseCase(this._preferenceHelper);

  Future<void> call(String key)async
  {
    await _preferenceHelper.removeData(key);
  }
}