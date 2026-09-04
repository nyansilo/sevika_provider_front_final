import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/chat_room_entity.dart';
import '../repositories/chat_repository.dart';
import 'params/initialize_chat_params.dart';

class InitializeChatUseCase
    implements UseCase<ChatRoomEntity, InitializeChatParams> {
  final ChatRepository repository;
  InitializeChatUseCase(this.repository);

  @override
  Future<Either<AppError, ChatRoomEntity>> call(
    InitializeChatParams params,
  ) async {
    return await repository.initializeRoomContext(params);
  }
}
