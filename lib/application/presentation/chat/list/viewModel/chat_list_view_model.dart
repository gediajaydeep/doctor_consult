import 'package:consultations_app_test/application/domain/chats/useCases/get_chat_list.dart';
import 'package:consultations_app_test/core/useCases/use_case.dart';
import 'package:flutter/cupertino.dart';

import '../../../../domain/chats/entities/chat_list.dart';

class ChatListViewModel extends ChangeNotifier {
  final GetChatList _getChatList;

  bool isLoading = true;
  List<ChatList>? chatList;
  String? error;

  ChatListViewModel({required GetChatList getChatList})
      : _getChatList = getChatList;

  init() {
    _loadChatList();
  }

  Future<void> _loadChatList() async {
    final chatsOrFailure = await _getChatList.execute(
      const EmptyRequest(),
    );
    chatsOrFailure.fold(
      (l) => _setError(
        l.getMessage(),
      ),
      (r) => _setChatList(r),
    );
  }

  _setChatList(List<ChatList> list) {
    error = null;
    chatList = list;
    isLoading = false;
    notifyListeners();
  }

  _setError(String message) {
    error = message;
    isLoading = false;
    notifyListeners();
  }
}
