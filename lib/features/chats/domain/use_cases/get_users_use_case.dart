import 'package:graduation/features/authentication/domain/models/user_model.dart';
import 'package:graduation/features/chats/domain/repository/chats_repository.dart';

class GetUsersUseCase
{
  final ChatsRepository _chatsRepository;

  GetUsersUseCase(this._chatsRepository);

  Future<List<UserData>> call()async
  {
    return await _chatsRepository.getUsers();
  }
}