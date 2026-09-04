import 'package:equatable/equatable.dart';

class GetNotificationsParams extends Equatable {
  final int perPage;
  final int page;

  const GetNotificationsParams({this.perPage = 25, this.page = 1});

  Map<String, dynamic> toQueryParameters() {
    return {'per_page': perPage.toString(), 'page': page.toString()};
  }

  @override
  List<Object?> get props => [perPage, page];
}
