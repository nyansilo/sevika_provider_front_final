import 'package:equatable/equatable.dart';

class GetChatRoomsParams extends Equatable {
  final int page;

  const GetChatRoomsParams({this.page = 1});

  Map<String, dynamic> toQueryParameters() => {'page': page.toString()};

  @override
  List<Object?> get props => [page];
}
