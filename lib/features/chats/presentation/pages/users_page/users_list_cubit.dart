import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/features/chats/domain/use_cases/get_users_use_case.dart';
import 'package:graduation/features/chats/presentation/pages/users_page/users_list_state.dart';
import 'package:graduation/shared/utils.dart';

class UsersListCubit extends Cubit<UsersListState>
{
  final GetUsersUseCase _getUsersUseCase;
  UsersListCubit(this._getUsersUseCase):super(const UsersListState());

  static UsersListCubit get(context)=>BlocProvider.of(context);

  void getUsers()async
  {
    emit(state.copyWith(getUsersState: RequestStatus.loading));
    final users=await _getUsersUseCase.call();
    emit(state.copyWith(getUsersState: RequestStatus.success,users: users));
  }
}