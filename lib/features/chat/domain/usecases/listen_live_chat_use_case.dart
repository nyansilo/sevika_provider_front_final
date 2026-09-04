import '../entities/chat_message_entity.dart';
import '../repositories/chat_repository.dart';
import 'params/live_chat_params.dart';

class ListenLiveChatUseCase {
  final ChatRepository repository;
  ListenLiveChatUseCase(this.repository);

  Stream<ChatMessageEntity> call(LiveChatParams params) {
    return repository.initializeLiveChatStream(
      params.userId,
      params.roomId,
      params.token,
    );
  }
}
