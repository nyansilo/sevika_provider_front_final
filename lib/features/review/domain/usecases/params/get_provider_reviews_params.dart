import 'package:equatable/equatable.dart';

class GetProviderReviewsParams extends Equatable {
  final int page;

  const GetProviderReviewsParams({this.page = 1});

  Map<String, dynamic> toQueryParameters() => {'page': page.toString()};

  @override
  List<Object?> get props => [page];
}
