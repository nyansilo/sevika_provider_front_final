import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/global/presentation/widgets/sevika_button.dart';
import '../../../../core/routes/route_list.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/storage/auth_token_manager.dart';
import '../../../../core/usecases/usecase.dart';

import '../../domain/entities/emergency_claim_entity.dart';
import '../../domain/usecases/listen_live_emergency_usecase.dart';
import '../../domain/usecases/disconnect_live_emergency_usecase.dart';
import '../../domain/usecases/params/live_emergency_params.dart';
import '../cubits/accept_emergency_cubit.dart';
import '../cubits/accept_emergency_state.dart';

class IncomingEmergencyAlert extends StatefulWidget {
  final String dispatchId;
  final String category;
  final String addressText;

  const IncomingEmergencyAlert({
    super.key,
    required this.dispatchId,
    required this.category,
    required this.addressText,
  });

  @override
  State<IncomingEmergencyAlert> createState() => _IncomingEmergencyAlertState();
}

class _IncomingEmergencyAlertState extends State<IncomingEmergencyAlert> {
  StreamSubscription<EmergencyClaimEntity>? _wsSubscription;

  @override
  void initState() {
    super.initState();
    _connectToEmergencyRadar();
  }

  Future<void> _connectToEmergencyRadar() async {
    final tokenManager = sl<AuthTokenManager>();
    final token = await tokenManager.getAccessToken();

    if (token != null) {
      final useCase = sl<ListenLiveEmergencyUseCase>();

      _wsSubscription = useCase
          .call(
            LiveEmergencyParams(dispatchId: widget.dispatchId, token: token),
          )
          .listen((claimEntity) {
            if (mounted) {
              Navigator.of(context).pop();
              context.showSnackBar(
                claimEntity.message,
                type: SnackBarType.warning,
              );
            }
          });
    }
  }

  @override
  void dispose() {
    _wsSubscription?.cancel();
    sl<DisconnectLiveEmergencyUseCase>().call(NoParams());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AcceptEmergencyCubit, AcceptEmergencyState>(
      listener: (context, state) {
        if (state is AcceptEmergencyFailure) {
          Navigator.pop(context);
          context.showSnackBar(
            state.error.message ?? 'Failed to accept emergency.',
            type: SnackBarType.error,
          );
        } else if (state is AcceptEmergencySuccess) {
          final navigator = Navigator.of(context);

          navigator.pop(); // 1. Close Dialog
          navigator.pop(); // 2. Close Notification Screen

          context.showSnackBar(
            'Emergency Claimed!',
            type: SnackBarType.success,
          );

          // 3. Push Dashboard strictly explicitly declaring Tab 1!
          navigator.pushNamed(RouteList.bookingDashboardPage, arguments: 1);
        }
      },
      builder: (context, state) {
        final isLoading = state is AcceptEmergencyLoading;

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          ),
          backgroundColor: context.colorScheme.surface,
          title: Row(
            children: [
              Icon(
                Icons.warning_rounded,
                color: context.colorScheme.error,
                size: 28,
              ),
              AppDimensions.gapS,
              const Text(
                '🚨 SOS Alert!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'A customer needs an emergency ${widget.category} immediately!',
                style: context.textTheme.titleMedium,
              ),
              AppDimensions.gapM,
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: context.colorScheme.primary,
                    size: 20,
                  ),
                  AppDimensions.gapS,
                  Expanded(
                    child: Text(
                      widget.addressText,
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              AppDimensions.gapL,
              const Text(
                'Accepting this will deduct the lead fee from your wallet and create an active job.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: isLoading ? null : () => Navigator.pop(context),
              child: const Text('Ignore', style: TextStyle(color: Colors.grey)),
            ),
            SevikaButton(
              text: 'Accept SOS',
              isLoading: isLoading,
              onPressed: isLoading
                  ? null
                  : () {
                      context.read<AcceptEmergencyCubit>().acceptSOS(
                        widget.dispatchId,
                      );
                    },
            ),
          ],
        );
      },
    );
  }
}
