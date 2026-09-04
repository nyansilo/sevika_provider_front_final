// import 'package:flutter/material.dart';
// import '../../../../core/constants/app_dimensions.dart';

// import '../widgets/system_permission/permission_toggle_tile.dart';

// class SystemPermissionsScreen extends StatefulWidget {
//   const SystemPermissionsScreen({super.key});

//   @override
//   State<SystemPermissionsScreen> createState() =>
//       _SystemPermissionsScreenState();
// }

// class _SystemPermissionsScreenState extends State<SystemPermissionsScreen> {
//   // Application permission state flags
//   bool _locationGranted = true;
//   bool _notificationsGranted = true;
//   bool _cameraGranted = false;
//   bool _storageGranted = true;

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Scaffold(
//       backgroundColor: theme.colorScheme.surface,
//       appBar: AppBar(
//         backgroundColor: theme.colorScheme.surface,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'Data & Permissions',
//           style: theme.textTheme.titleMedium?.copyWith(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: Center(
//           child: ConstrainedBox(
//             constraints: const BoxConstraints(
//               maxWidth: AppDimensions.maxDashboardWidth,
//             ),
//             child: ListView(
//               padding: const EdgeInsets.all(AppDimensions.paddingM),
//               children: [
//                 // Informative Data Security Summary Top Banner
//                 Container(
//                   padding: const EdgeInsets.all(AppDimensions.paddingM),
//                   decoration: BoxDecoration(
//                     color: theme.colorScheme.primaryContainer.withValues(
//                       alpha: 0.15,
//                     ),
//                     borderRadius: BorderRadius.circular(AppDimensions.radiusM),
//                   ),
//                   child: Row(
//                     children: [
//                       Icon(
//                         Icons.shield_outlined,
//                         color: theme.colorScheme.primary,
//                       ),
//                       AppDimensions.gapM,
//                       Expanded(
//                         child: Text(
//                           'Control which device diagnostic channels and hardware tools our system parameters are authorized to interact with.',
//                           style: theme.textTheme.bodyMedium?.copyWith(
//                             color: theme.colorScheme.onPrimaryContainer,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 AppDimensions.gapL,

//                 // Permission Matrix Modules Checklist Block
//                 PermissionToggleTile(
//                   title: 'Location Services',
//                   description:
//                       'Allows providers to locate your coordinates precisely for optimized route routing matches during service arrival tracking.',
//                   icon: Icons.location_on_outlined,
//                   isEnabled: _locationGranted,
//                   onChanged: (val) => setState(() => _locationGranted = val),
//                 ),
//                 AppDimensions.gapM,

//                 PermissionToggleTile(
//                   title: 'Push Notifications',
//                   description:
//                       'Receive real-time transactional alert dispatches regarding status updates, confirmations, and technician assignment updates.',
//                   icon: Icons.notifications_none_rounded,
//                   isEnabled: _notificationsGranted,
//                   onChanged: (val) =>
//                       setState(() => _notificationsGranted = val),
//                 ),
//                 AppDimensions.gapM,

//                 PermissionToggleTile(
//                   title: 'Camera Access',
//                   description:
//                       'Used to upload on-site context reference captures or scan QR confirmation tickets during service completions.',
//                   icon: Icons.camera_alt_outlined,
//                   isEnabled: _cameraGranted,
//                   onChanged: (val) => setState(() => _cameraGranted = val),
//                 ),
//                 AppDimensions.gapM,

//                 PermissionToggleTile(
//                   title: 'Storage & Media',
//                   description:
//                       'Enables caching configurations, storing PDF invoice printouts locally, and picking existing system image attachments.',
//                   icon: Icons.folder_open_rounded,
//                   isEnabled: _storageGranted,
//                   onChanged: (val) => setState(() => _storageGranted = val),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart'; // 🎯 Required for the Permission enum types

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart'; // 🎯 Using your custom context shortcuts!
import '../../../../core/di/service_locator.dart'; // 🎯 Access to Service Locator
import '../../../../core/services/permission_service.dart'; // 🎯 Using our clean abstract service

import '../widgets/system_permission/permission_toggle_tile.dart';

class SystemPermissionsScreen extends StatefulWidget {
  const SystemPermissionsScreen({super.key});

  @override
  State<SystemPermissionsScreen> createState() =>
      _SystemPermissionsScreenState();
}

// 🎯 WidgetsBindingObserver allows us to detect when the user comes back to the app from the OS Settings
class _SystemPermissionsScreenState extends State<SystemPermissionsScreen>
    with WidgetsBindingObserver {
  // 🎯 Access your new abstract service via GetIt
  final PermissionService _permissionService = sl<PermissionService>();

  // Application permission state flags (now dynamically synced with OS)
  bool _locationGranted = false;
  bool _notificationsGranted = false;
  bool _cameraGranted = false;
  bool _storageGranted = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkAllPermissions(); // Check hardware status on load
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // 🔄 Fired automatically when app is resumed from background (e.g., returning from OS Settings)
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkAllPermissions();
    }
  }

  /// 📡 Checks the hardware OS status using our clean Service
  Future<void> _checkAllPermissions() async {
    final loc = await _permissionService.isGranted(Permission.location);
    final notif = await _permissionService.isGranted(Permission.notification);
    final cam = await _permissionService.isGranted(Permission.camera);
    final storage = await _permissionService.isGranted(Permission.storage);

    if (mounted) {
      setState(() {
        _locationGranted = loc;
        _notificationsGranted = notif;
        _cameraGranted = cam;
        _storageGranted = storage;
      });
    }
  }

  /// 🛠️ Standardized OS Permission Toggle Logic via Service
  Future<void> _handlePermissionToggle(
    Permission permission,
    bool isCurrentlyGranted,
    String permissionName,
  ) async {
    if (isCurrentlyGranted) {
      // 🚫 USER WANTS TO TURN IT OFF
      // iOS & Android do NOT allow apps to revoke their own permissions.
      // We must redirect the user to the System App Settings via our Service.
      context.showSnackBar(
        'To disable $permissionName, please revoke it in your device settings.',
        type: SnackBarType.info,
      );
      await Future.delayed(const Duration(seconds: 2));
      await _permissionService.openSettings(); // 🎯 Delegate to service
    } else {
      // ✅ USER WANTS TO TURN IT ON
      final isPermanentlyDenied = await _permissionService.isPermanentlyDenied(
        permission,
      );

      if (isPermanentlyDenied) {
        // OS blocked the popup because it was denied too many times
        context.showSnackBar(
          '$permissionName is blocked. Please enable it in your device settings.',
          type: SnackBarType.warning,
        );
        await Future.delayed(const Duration(seconds: 2));
        await _permissionService.openSettings(); // 🎯 Delegate to service
      } else {
        // Request it using our Service
        final granted = await _permissionService.requestPermission(permission);
        if (granted && mounted) {
          context.showSnackBar(
            '$permissionName enabled successfully.',
            type: SnackBarType.success,
          );
        }
      }

      // Re-sync UI with hardware
      _checkAllPermissions();
    }
  }

  @override
  Widget build(BuildContext context) {
    // 🎯 Leveraging your BuildContextX extensions!
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: context.colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Data & Permissions',
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppDimensions.maxDashboardWidth,
            ),
            child: ListView(
              padding: const EdgeInsets.all(AppDimensions.paddingM),
              children: [
                // Informative Data Security Summary Top Banner
                Container(
                  padding: const EdgeInsets.all(AppDimensions.paddingM),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primaryContainer.withValues(
                      alpha: 0.15,
                    ),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.shield_outlined,
                        color: context.colorScheme.primary,
                      ),
                      AppDimensions.gapM,
                      Expanded(
                        child: Text(
                          'Control which device diagnostic channels and hardware tools our system parameters are authorized to interact with.',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AppDimensions.gapL,

                // Permission Matrix Modules Checklist Block
                PermissionToggleTile(
                  title: 'Location Services',
                  description:
                      'Allows providers to locate your coordinates precisely for optimized route routing matches during service arrival tracking.',
                  icon: Icons.location_on_outlined,
                  isEnabled: _locationGranted,
                  onChanged: (val) => _handlePermissionToggle(
                    Permission.location,
                    _locationGranted,
                    'Location',
                  ),
                ),
                AppDimensions.gapM,

                PermissionToggleTile(
                  title: 'Push Notifications',
                  description:
                      'Receive real-time transactional alert dispatches regarding status updates, confirmations, and technician assignment updates.',
                  icon: Icons.notifications_none_rounded,
                  isEnabled: _notificationsGranted,
                  onChanged: (val) => _handlePermissionToggle(
                    Permission.notification,
                    _notificationsGranted,
                    'Notifications',
                  ),
                ),
                AppDimensions.gapM,

                PermissionToggleTile(
                  title: 'Camera Access',
                  description:
                      'Used to upload on-site context reference captures or scan QR confirmation tickets during service completions.',
                  icon: Icons.camera_alt_outlined,
                  isEnabled: _cameraGranted,
                  onChanged: (val) => _handlePermissionToggle(
                    Permission.camera,
                    _cameraGranted,
                    'Camera',
                  ),
                ),
                AppDimensions.gapM,

                PermissionToggleTile(
                  title: 'Storage & Media',
                  description:
                      'Enables caching configurations, storing PDF invoice printouts locally, and picking existing system image attachments.',
                  icon: Icons.folder_open_rounded,
                  isEnabled: _storageGranted,
                  onChanged: (val) => _handlePermissionToggle(
                    Permission
                        .storage, // (Handled safely in the service for iOS 14+)
                    _storageGranted,
                    'Storage',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
