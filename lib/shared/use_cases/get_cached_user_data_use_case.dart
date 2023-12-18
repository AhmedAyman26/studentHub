import 'package:graduation/features/authentication/domain/models/user_model.dart';
import 'package:graduation/shared/preference_helper/preference_helper.dart';

class GetCachedUserDataUseCase
{
  final PreferenceHelper _preferenceHelper;

  GetCachedUserDataUseCase(this._preferenceHelper);

  Future<UserData?> call()async
  {
    return await _preferenceHelper.getCachedUserData();
  }
}