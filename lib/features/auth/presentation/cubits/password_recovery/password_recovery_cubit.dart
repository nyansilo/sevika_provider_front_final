import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/forgot_password_usecase.dart';
import '../../../domain/usecases/reset_password_usecase.dart';
import '../../../domain/usecases/params/forgot_password_params.dart';
import '../../../domain/usecases/params/reset_password_params.dart';
import 'password_recovery_state.dart.dart';

class PasswordRecoveryCubit extends Cubit<PasswordRecoveryState> {
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;

  PasswordRecoveryCubit({
    required this.forgotPasswordUseCase,
    required this.resetPasswordUseCase,
  }) : super(PasswordRecoveryInitial());

  /// INITIATE FORGOT PASSWORD (OTP/EMAIL DISPATCH)
  Future<void> forgotPassword(ForgotPasswordParams params) async {
    emit(PasswordRecoveryLoading());

    final result = await forgotPasswordUseCase.call(params);

    result.fold(
      (error) => emit(PasswordRecoveryError(error)),
      (_) => emit(
        const ForgotPasswordSuccess(
          message: 'A reset code has been sent to your account.',
        ),
      ),
    );
  }

  /// EXECUTE PASSWORD RESET
  Future<void> resetPassword(ResetPasswordParams params) async {
    emit(PasswordRecoveryLoading());

    final result = await resetPasswordUseCase.call(params);

    result.fold(
      (error) => emit(PasswordRecoveryError(error)),
      (_) => emit(
        const ResetPasswordSuccess(
          message:
              'Your password has been successfully reset. You may now sign in.',
        ),
      ),
    );
  }
}
