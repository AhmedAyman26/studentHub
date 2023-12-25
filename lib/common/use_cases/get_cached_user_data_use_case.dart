import 'package:graduation/common/preference_helper/preference_helper.dart';
import 'package:graduation/features/authentication/domain/models/user_model.dart';

class GetCachedUserDataUseCase
{
  final PreferenceHelper _preferenceHelper;

  GetCachedUserDataUseCase(this._preferenceHelper);

  Future<UserData?> call()async
  {
    return await _preferenceHelper.getCachedUserData();
  }
}