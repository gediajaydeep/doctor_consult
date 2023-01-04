import 'package:consultations_app_test/application/domain/chats/entities/chat_list.dart';

abstract class ChatsRepository {
  Future<List<ChatList>> getChatList();
}
