import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/chat_message_entity.dart';
import '../repositories/chat_repository.dart';
import 'params/send_text_message_params.dart';

class SendTextMessageUseCase
    implements UseCase<ChatMessageEntity, SendTextMessageParams> {
  final ChatRepository repository;
  SendTextMessageUseCase(this.repository);

  @override
  Future<Either<AppError, ChatMessageEntity>> call(
    SendTextMessageParams params,
  ) async {
    return await repository.sendTextMessage(params);
  }
}
