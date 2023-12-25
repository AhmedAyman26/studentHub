import 'package:equatable/equatable.dart';
import 'package:graduation/common/utils.dart';
import 'package:graduation/features/authentication/domain/models/user_model.dart';

class UsersListState extends Equatable {
  final List<UserData>? users;
  final RequestStatus? getUsersState;
  final String? errorMessage;

  const UsersListState({this.users=const[], this.getUsersState=RequestStatus.initial, this.errorMessage=''});

  UsersListState copyWith({
    final List<UserData>? users,
    final RequestStatus? getUsersState,
    final String? errorMessage,
  }) {
    return UsersListState(
        users: users ?? this.users,
        getUsersState: getUsersState ?? this.getUsersState,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [users,getUsersState,errorMessage];
}
