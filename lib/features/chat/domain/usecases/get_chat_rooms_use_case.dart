import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/chat_rooms_response_entity.dart';
import '../repositories/chat_repository.dart';
import 'params/get_chat_rooms_params.dart';

class GetChatRoomsUseCase
    implements UseCase<ChatRoomsResponseEntity, GetChatRoomsParams> {
  final ChatRepository repository;
  GetChatRoomsUseCase(this.repository);

  @override
  Future<Either<AppError, ChatRoomsResponseEntity>> call(
    GetChatRoomsParams params,
  ) async {
    return await repository.fetchChatRooms(params);
  }
}
