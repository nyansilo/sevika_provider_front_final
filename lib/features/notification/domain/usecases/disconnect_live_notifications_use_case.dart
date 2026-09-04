// import '../../../../core/usecases/usecase.dart';
// import '../repositories/notification_repository.dart';

// class DisconnectLiveNotificationsUseCase {
//   final NotificationRepository repository;

//   DisconnectLiveNotificationsUseCase(this.repository);

//   void call(NoParams params) {
//     repository.disposeWebSocketStream();
//   }
// }

import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/notification_repository.dart';

// 🎯 FIXED: Now properly implements the core UseCase contract
class DisconnectLiveNotificationsUseCase implements UseCase<void, NoParams> {
  final NotificationRepository repository;

  DisconnectLiveNotificationsUseCase(this.repository);

  @override
  // 🎯 FIXED: The UseCase acts strictly as a pure pipe, delegating to the Repository.
  Future<Either<AppError, void>> call(NoParams params) async {
    return await repository.disposeWebSocketStream();
  }
}
