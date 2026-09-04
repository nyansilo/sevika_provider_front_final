import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/params/place_bid_params.dart';
import '../../domain/usecases/place_bid_usecase.dart';
import 'place_bid_state.dart';

class PlaceBidCubit extends Cubit<PlaceBidState> {
  final PlaceBidUseCase useCase;
  PlaceBidCubit({required this.useCase}) : super(PlaceBidInitial());

  Future<void> submitBid(PlaceBidParams params) async {
    emit(PlaceBidLoading());
    final result = await useCase.call(params);
    if (isClosed) return;
    result.fold(
      (error) => emit(PlaceBidFailure(error)),
      (_) => emit(PlaceBidSuccess()),
    );
  }
}
