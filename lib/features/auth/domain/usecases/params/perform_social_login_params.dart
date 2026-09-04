import 'package:equatable/equatable.dart';
import '../../entities/social_provider.dart';

/// Clean payload passed from the UI to the UseCase.
class PerformSocialLoginParams extends Equatable {
  final SocialProvider provider;

  const PerformSocialLoginParams(this.provider);

  @override
  List<Object?> get props => [provider];
}
