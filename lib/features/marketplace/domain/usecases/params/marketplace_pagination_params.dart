import 'package:equatable/equatable.dart';

class MarketplacePaginationParams extends Equatable {
  final int page;
  final int perPage;

  const MarketplacePaginationParams({required this.page, this.perPage = 15});

  Map<String, dynamic> toQueryParameters() => {
    'page': page,
    'per_page': perPage,
  };

  @override
  List<Object?> get props => [page, perPage];
}
