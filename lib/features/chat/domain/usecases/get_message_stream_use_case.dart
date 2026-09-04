import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/chat_stream_response_entity.dart';
import '../repositories/chat_repository.dart';
import 'params/get_message_stream_params.dart';

class GetMessageStreamUseCase
    implements UseCase<ChatStreamResponseEntity, GetMessageStreamParams> {
  final ChatRepository repository;
  GetMessageStreamUseCase(this.repository);

  @override
  Future<Either<AppError, ChatStreamResponseEntity>> call(
    GetMessageStreamParams params,
  ) async {
    return await repository.fetchMessageStream(params);
  }
}
