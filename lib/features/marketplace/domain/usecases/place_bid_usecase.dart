import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/marketplace_repository.dart';
import 'params/place_bid_params.dart';

class PlaceBidUseCase implements UseCase<void, PlaceBidParams> {
  final MarketplaceRepository repository;
  PlaceBidUseCase(this.repository);

  @override
  Future<Either<AppError, void>> call(PlaceBidParams params) async {
    return await repository.placeBid(params);
  }
}
