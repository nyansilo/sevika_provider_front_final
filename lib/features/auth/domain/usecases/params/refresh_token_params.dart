import 'package:equatable/equatable.dart';

class RefreshTokenParams extends Equatable {
  final String refreshToken;

  const RefreshTokenParams({required this.refreshToken});

  Map<String, dynamic> toMap() => {'refreshToken': refreshToken};

  @override
  List<Object?> get props => [refreshToken];
}
