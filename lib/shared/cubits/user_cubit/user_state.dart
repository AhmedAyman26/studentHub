import 'package:equatable/equatable.dart';
import 'package:graduation/features/authentication/domain/models/user_model.dart';
import 'package:graduation/shared/utils.dart';

class UserState extends Equatable
{
  final RequestStatus? userDataState;
  final UserData? userData;
  final RequestStatus? logout;

  const UserState({this.userDataState, this.userData,this.logout});

  UserState copyWith({RequestStatus? userDataState,UserData? userData,RequestStatus? logout})
  {
    return UserState(
      logout:logout??this.logout,
      userData: userData??this.userData,
      userDataState: userDataState??this.userDataState
    );
  }

  @override
  List<Object?> get props => [userDataState,userData,logout];

}