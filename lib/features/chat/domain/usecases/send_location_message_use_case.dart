import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/chat_message_entity.dart';
import '../repositories/chat_repository.dart';
import 'params/send_location_message_params.dart';

class SendLocationMessageUseCase
    implements UseCase<ChatMessageEntity, SendLocationMessageParams> {
  final ChatRepository repository;
  SendLocationMessageUseCase(this.repository);

  @override
  Future<Either<AppError, ChatMessageEntity>> call(
    SendLocationMessageParams params,
  ) async {
    return await repository.sendLocationMessage(params);
  }
}
