import 'package:equatable/equatable.dart';

class ProviderReviewCustomerEntity extends Equatable {
  final String id;
  final String name;
  final String avatar;

  const ProviderReviewCustomerEntity({
    required this.id,
    required this.name,
    required this.avatar,
  });

  @override
  List<Object?> get props => [id, name, avatar];
}
