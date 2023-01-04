import 'package:consultations_app_test/application/domain/chats/entities/chat_list.dart';
import 'package:consultations_app_test/application/domain/chats/repositories/chats_repository.dart';
import 'package:consultations_app_test/core/errors/failure.dart';
import 'package:consultations_app_test/core/useCases/use_case.dart';
import 'package:dartz/dartz.dart';

class GetChatList extends UseCase<EmptyRequest, List<ChatList>> {
  final ChatsRepository _chatsRepository;

  GetChatList({required ChatsRepository chatsRepository})
      : _chatsRepository = chatsRepository;

  @override
  Future<Either<Failure, List<ChatList>>> execute(EmptyRequest request) async {
    try {
      return Right(
        await _chatsRepository.getChatList(),
      );
    } catch (e) {
      return Left(
        Failure(
          error: e.toString(),
        ),
      );
    }
  }
}
