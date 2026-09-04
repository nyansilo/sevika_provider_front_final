import 'package:equatable/equatable.dart';

class GetMessageStreamParams extends Equatable {
  final String roomId;
  final int page;

  const GetMessageStreamParams({required this.roomId, this.page = 1});

  Map<String, dynamic> toQueryParameters() => {'page': page.toString()};

  @override
  List<Object?> get props => [roomId, page];
}
