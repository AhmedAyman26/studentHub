import 'package:graduation/common/preference_helper/preference_helper.dart';
import 'package:graduation/features/authentication/domain/models/user_model.dart';

class CacheUserDataUseCase
{
  final PreferenceHelper _preferenceHelper;

  CacheUserDataUseCase(this._preferenceHelper);

  Future<void> call(UserData userData)async
  {
    return await _preferenceHelper.cacheUserData(userData);
  }

}