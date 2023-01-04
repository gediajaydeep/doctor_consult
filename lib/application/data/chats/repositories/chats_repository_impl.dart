import 'package:consultations_app_test/application/data/chats/dataSources/chats_local_data_source.dart';
import 'package:consultations_app_test/application/domain/chats/entities/chat_list.dart';

import '../../../domain/chats/repositories/chats_repository.dart';

class ChatsRepositoryImpl implements ChatsRepository {
  final ChatsLocalDataSource _localDataSource;

  ChatsRepositoryImpl({required ChatsLocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  @override
  Future<List<ChatList>> getChatList() async {
    return (await _localDataSource.getChatList())
        .map(
          (e) => e.toChatList(),
        )
        .toList();
  }
}
