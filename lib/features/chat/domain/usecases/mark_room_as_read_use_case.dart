import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/chat_repository.dart';

class MarkRoomAsReadUseCase implements UseCase<void, String> {
  final ChatRepository repository;
  MarkRoomAsReadUseCase(this.repository);

  @override
  Future<Either<AppError, void>> call(String roomId) async {
    return await repository.markRoomAsRead(roomId: roomId);
  }
}
