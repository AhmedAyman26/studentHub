import 'package:equatable/equatable.dart';
import 'package:graduation/features/authentication/domain/models/user_model.dart';
import 'package:graduation/shared/utils.dart';

class UserState extends Equatable
{
  final RequestStatus? userDataState;
  final UserData? userData;

  const UserState({this.userDataState, this.userData});

  UserState copyWith({RequestStatus? userDataState,UserData? userData })
  {
    return UserState(
      userData: userData??this.userData,
      userDataState: userDataState??this.userDataState
    );
  }

  @override
  List<Object?> get props => [userDataState,userData];

}