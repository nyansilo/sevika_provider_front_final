// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:open_filex/open_filex.dart'; // 🎯 REAL NATIVE FILE OPENER

// // 🎯 CORE IMPORTS
// import '../../../../core/constants/app_dimensions.dart';
// import '../../../../core/extensions/build_context_extensions.dart';
// import '../../../../core/presentation/widgets/sevika_button.dart';
// import '../../../../core/extensions/currency_formatter_extensions.dart'; // 🎯 CENTRALIZED CURRENCY FORMATTER

// // 🎯 DOMAIN & CUBIT IMPORTS
// import '../../domain/entities/booking_entity.dart';
// import '../../domain/entities/booking_status.dart';
// import '../../domain/usecases/params/update_booking_status_params.dart';
// import '../cubits/invoice/invoice_state.dart';
// import '../cubits/manage_job/manage_job_cubit.dart';
// import '../cubits/manage_job/manage_job_state.dart';
// import '../cubits/invoice/invoice_cubit.dart'; // 🎯 INVOICE CUBIT ADDED
// import '../helpers/provider_booking_action_helper.dart';

// class ProviderBookingDetailScreen extends StatefulWidget {
//   final BookingEntity booking;

//   const ProviderBookingDetailScreen({super.key, required this.booking});

//   @override
//   State<ProviderBookingDetailScreen> createState() =>
//       _ProviderBookingDetailScreenState();
// }

// class _ProviderBookingDetailScreenState
//     extends State<ProviderBookingDetailScreen> {
//   // 🎯 Local state holds the latest booking data from the API.
//   // We use this so the UI can update instantly without waiting for a full dashboard refresh.
//   late BookingEntity _currentBooking;

//   @override
//   void initState() {
//     super.initState();
//     _currentBooking = widget.booking;
//   }

//   // 💰 HELPER: Safely parses numeric currency strings into clean integers
//   int _parseAmount(String? amountStr) {
//     if (amountStr == null || amountStr.isEmpty) return 0;
//     final cleanStr = amountStr.replaceAll(RegExp(r'[^0-9.]'), '');
//     return (double.tryParse(cleanStr) ?? 0.0).round();
//   }

//   // ====================================================================
//   // ⚙️ THE STATE MACHINE LOGIC (Wires UI buttons directly to Cubit/API)
//   //
//   // This function acts as the "Brain" of the screen. Instead of having
//   // 5 different buttons, we have ONE button that intelligently figures
//   // out what API call to make based on the current job phase.
//   // ====================================================================
//   Future<void> _handlePrimaryAction() async {
//     final status = _currentBooking.status;
//     final cubit = context.read<ManageJobCubit>();

//     // 0️⃣ ACCEPT JOB -> {"status": "accepted"}
//     // When the provider accepts a new incoming lead (instant booking) from the details screen.
//     if (status == BookingStatus.pending) {
//       cubit.updateJobStatus(
//         UpdateBookingStatusParams(
//           bookingReference: _currentBooking.bookingReference,
//           status: 'accepted',
//         ),
//       );
//     }
//     // 1️⃣ START TRAVEL -> {"status": "en_route"}
//     // When the provider is ready to leave their house/shop to go to the customer.
//     else if (status == BookingStatus.accepted ||
//         status == BookingStatus.confirmed) {
//       cubit.updateJobStatus(
//         UpdateBookingStatusParams(
//           bookingReference: _currentBooking.bookingReference,
//           status: 'en_route',
//         ),
//       );
//     }
//     // 2️⃣ ARRIVED & START JOB -> {"status": "in_progress", "verification_code": "3490"}
//     // The provider has arrived. They MUST ask the customer for the 4-digit PIN.
//     else if (status == BookingStatus.enRoute) {
//       final pin = await _showVerificationPinDialog();
//       if (pin != null && pin.length >= 4) {
//         cubit.updateJobStatus(
//           UpdateBookingStatusParams(
//             bookingReference: _currentBooking.bookingReference,
//             status: 'in_progress',
//             verificationCode: pin, // 🔐 Sends the PIN to Laravel securely
//           ),
//         );
//       }
//     }
//     // 3️⃣ COMPLETE JOB -> {"status": "completed"} OR {"status": "pending_payment", "final_price": 55000}
//     // Note: If the backend logic requires it to go to 'pending_payment' instead (like for cash),
//     // the Laravel Action class will intercept this 'completed' request and alter it automatically!
//     else if (status == BookingStatus.ongoing) {
//       // 🚀 SOS EMERGENCY POST-JOB BILLING INTERCEPTOR
//       // If the job is an emergency, we don't know the price yet! We must ask the provider.
//       if (_currentBooking.isEmergency) {
//         final String? finalPriceStr = await _showFinalPriceDialog();

//         if (finalPriceStr != null && finalPriceStr.isNotEmpty) {
//           cubit.updateJobStatus(
//             UpdateBookingStatusParams(
//               bookingReference: _currentBooking.bookingReference,
//               // We send 'completed', and Laravel's UpdateBookingStatusAction will automatically
//               // intercept it and downgrade it to 'pending_payment' because it sees the finalPrice!
//               status: 'completed',
//               finalPrice: double.parse(
//                 finalPriceStr,
//               ), // 💰 Sends { "final_price": 55000 }
//             ),
//           );
//         }
//       }
//       // Normal Jobs (Instant / Custom Quotes where the price is already locked in)
//       else {
//         cubit.updateJobStatus(
//           UpdateBookingStatusParams(
//             bookingReference: _currentBooking.bookingReference,
//             status: 'completed',
//           ),
//         );
//       }
//     }
//     // 4️⃣ CONFIRM CASH -> POST /confirm-cash
//     // The job is done, but the customer chose "Cash". The provider must confirm they received it.
//     else if (status == BookingStatus.pendingPayment) {
//       // 🛡️ GUARD: Double check the payment method is actually cash before proceeding!
//       if (_currentBooking.paymentMethod?.toLowerCase() != 'cash') return;

//       // 🎯 THE CASH FIX: If paying by cash, the Provider MUST collect the FULL TOTAL (Service + Safety Fee).
//       // They do NOT collect just their payout amount. They collect the full amount,
//       // and Laravel deducts the commission from their virtual wallet.
//       final int amountToCollect = _parseAmount(_currentBooking.totalAmount);

//       final didCollect = await ProviderBookingActionHelper.confirmCashHandover(
//         context,
//         amountToCollect.toDouble(), // 💰 Forces them to collect the full 52,000 from customer
//       );

//       if (didCollect) {
//         cubit.confirmCashCollection(_currentBooking.bookingReference);
//       }
//     }
//   }

//   // ====================================================================
//   // 💰 POST-JOB BILLING DIALOG (For Emergency SOS Only)
//   // Forces the provider to enter the final bill before stopping the clock.
//   // ====================================================================
//   Future<String?> _showFinalPriceDialog() {
//     final TextEditingController priceController = TextEditingController();
//     return showDialog<String>(
//       context: context,
//       barrierDismissible: false,
//       builder: (ctx) => AlertDialog(
//         title: const Text('Submit Final Invoice'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text(
//               'This is an Emergency SOS dispatch. Please enter the final total amount the customer needs to pay for your service today.',
//             ),
//             AppDimensions.gapM,
//             TextField(
//               controller: priceController,
//               keyboardType: const TextInputType.numberWithOptions(
//                 decimal: true,
//               ),
//               inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//               style: context.textTheme.titleLarge?.copyWith(
//                 fontWeight: FontWeight.bold,
//               ),
//               decoration: InputDecoration(
//                 hintText: 'e.g. 50000',
//                 prefixText: 'TSh ',
//                 filled: true,
//                 fillColor: context.colorScheme.surfaceContainerLowest,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(AppDimensions.radiusM),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(ctx, null),
//             child: const Text('Cancel'),
//           ),
//           FilledButton(
//             onPressed: () => Navigator.pop(ctx, priceController.text),
//             child: const Text('Submit to Customer'),
//           ),
//         ],
//       ),
//     );
//   }

//   // ====================================================================
//   // 🔐 VERIFICATION PIN DIALOG
//   // Prevents the provider from starting the stopwatch before actually
//   // meeting the customer face-to-face.
//   // ====================================================================
//   Future<String?> _showVerificationPinDialog() {
//     final TextEditingController pinController = TextEditingController();
//     return showDialog<String>(
//       context: context,
//       barrierDismissible: false,
//       builder: (ctx) => AlertDialog(
//         title: const Text('Enter Security PIN'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text(
//               'Please ask the customer for their 4-digit verification PIN to officially start the stopwatch for this job.',
//             ),
//             AppDimensions.gapM,
//             TextField(
//               controller: pinController,
//               keyboardType: TextInputType.number,
//               textAlign: TextAlign.center,
//               maxLength: 4,
//               style: context.textTheme.headlineMedium?.copyWith(
//                 letterSpacing: 8.0,
//                 fontWeight: FontWeight.bold,
//               ),
//               inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//               decoration: InputDecoration(
//                 hintText: '----',
//                 filled: true,
//                 fillColor: context.colorScheme.surfaceContainerLowest,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(AppDimensions.radiusM),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(ctx, null),
//             child: const Text('Cancel'),
//           ),
//           FilledButton(
//             onPressed: () => Navigator.pop(ctx, pinController.text),
//             child: const Text('Verify & Start'),
//           ),
//         ],
//       ),
//     );
//   }

//   // ====================================================================
//   // 🎨 UI BUILDER & MULTI-BLOC CONSUMER
//   // ====================================================================
//   @override
//   Widget build(BuildContext context) {
//     // 🎯 We use MultiBlocListener because this screen handles TWO separate actions:
//     // 1. Updating the Job Status
//     // 2. Downloading the Invoice
//     return MultiBlocListener(
//       listeners: [
//         // 🎧 LISTENER 1: Reacts to Job Status API responses
//         BlocListener<ManageJobCubit, ManageJobState>(
//           listener: (context, state) {
//             if (state is ManageJobFailure) {
//               context.showSnackBar(
//                 state.error.message ?? 'Failed to update job status.',
//                 type: SnackBarType.error,
//               );
//             } else if (state is ManageJobSuccess) {
//               context.showSnackBar(
//                 'Job status updated successfully!',
//                 type: SnackBarType.success,
//               );
//               // 🔄 Update local state with fresh data from Laravel
//               setState(() {
//                 _currentBooking = state.booking;
//               });
//             }
//           },
//         ),
//         // 🎧 LISTENER 2: Reacts to Invoice Download API responses
//         BlocListener<InvoiceCubit, InvoiceState>(
//           listener: (context, state) {
//             if (state is InvoiceDownloadFailure) {
//               context.showSnackBar(
//                 state.error.message ?? 'Failed to download receipt.',
//                 type: SnackBarType.error,
//               );
//             } else if (state is InvoiceDownloadSuccess) {
//               context.showSnackBar(
//                 'Receipt downloaded successfully!',
//                 type: SnackBarType.success,
//               );
//               // 🎯 NATIVE INTEGRATION: Opens the PDF immediately on the device!
//               OpenFilex.open(state.filePath);
//             }
//           },
//         ),
//       ],
//       // 🏗️ BUILDER: Rebuilds UI based on ManageJob state
//       child: BlocBuilder<ManageJobCubit, ManageJobState>(
//         builder: (context, state) {
//           final bool isLoading = state is ManageJobLoading;

//           // 🚨 Hide the action button entirely if the job is already finished!
//           final bool isPastJob =
//               _currentBooking.status == BookingStatus.completed ||
//               _currentBooking.status == BookingStatus.cancelled;

//           // 🎯 THE SOS PAYMENT FIX: Calculate if we are waiting for the customer to choose how to pay
//           bool isWaitingForCustomerPayment = false;
//           String? customButtonText;

//           if (_currentBooking.status == BookingStatus.pendingPayment) {
//             final String method =
//                 _currentBooking.paymentMethod?.toLowerCase() ?? '';
//             // If it's NOT cash, or if it's completely empty, the provider must wait!
//             if (method != 'cash') {
//               isWaitingForCustomerPayment = true;
//               customButtonText = 'Waiting for Customer to Pay...';
//             }
//           }

//           return Scaffold(
//             backgroundColor: context.colorScheme.surfaceContainerLowest,
//             appBar: AppBar(
//               title: Text('Job ${_currentBooking.bookingReference}'),
//               centerTitle: true,
//               backgroundColor: context.colorScheme.surfaceContainerLowest,
//               elevation: 0,
//             ),

//             // 🔽 THE DYNAMIC ACTION BAR
//             // Only renders if the job is still active/pending
//             bottomNavigationBar: isPastJob
//                 ? null
//                 : Container(
//                     padding: EdgeInsets.only(
//                       left: AppDimensions.paddingM,
//                       right: AppDimensions.paddingM,
//                       top: AppDimensions.paddingM,
//                       bottom:
//                           MediaQuery.of(context).padding.bottom +
//                           AppDimensions.paddingM,
//                     ),
//                     decoration: BoxDecoration(
//                       color: context.colorScheme.surface,
//                       boxShadow: [
//                         BoxShadow(
//                           color: context.colorScheme.shadow.withValues(
//                             alpha: 0.05,
//                           ),
//                           offset: const Offset(0, -4),
//                           blurRadius: 16,
//                         ),
//                       ],
//                     ),
//                     child: SafeArea(
//                       child: SevikaButton(
//                         // 🎯 Apply our custom "Waiting..." text if needed
//                         text:
//                             customButtonText ??
//                             ProviderBookingActionHelper.getPrimaryActionText(
//                               _currentBooking,
//                             ),
//                         isLoading: isLoading,
//                         // 🎯 FIXED: Disable the button if loading OR if waiting on the customer!
//                         onPressed:
//                             (isLoading ||
//                                 _currentBooking.status ==
//                                     BookingStatus.quoteProvided ||
//                                 isWaitingForCustomerPayment)
//                             ? null
//                             : _handlePrimaryAction,
//                       ),
//                     ),
//                   ),

//             body: SingleChildScrollView(
//               padding: const EdgeInsets.all(AppDimensions.paddingM),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildStatusBanner(),
//                   AppDimensions.gapL,
//                   _buildCustomerCard(),
//                   AppDimensions.gapL,
//                   _buildLogisticsSection(),
//                   AppDimensions.gapL,
//                   _buildFinancialsSection(), // 🚀 NEW TRANSPARENT BREAKDOWN UI
//                   AppDimensions.gapXXXL, // Prevents content from hiding behind the floating bottom bar
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   // --- SUB WIDGETS ---

//   Widget _buildStatusBanner() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(AppDimensions.paddingM),
//       decoration: BoxDecoration(
//         color: context.colorScheme.primaryContainer.withValues(alpha: 0.5),
//         borderRadius: BorderRadius.circular(AppDimensions.radiusM),
//         border: Border.all(
//           color: context.colorScheme.primary.withValues(alpha: 0.3),
//         ),
//       ),
//       child: Column(
//         children: [
//           Text(
//             'Current Job Phase',
//             style: context.textTheme.labelMedium?.copyWith(
//               color: context.colorScheme.primary,
//             ),
//           ),
//           AppDimensions.gapXS,
//           Text(
//             _currentBooking.status.name.toUpperCase(),
//             style: context.textTheme.headlineSmall?.copyWith(
//               fontWeight: FontWeight.bold,
//               color: context.colorScheme.primary,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCustomerCard() {
//     return Container(
//       padding: const EdgeInsets.all(AppDimensions.paddingM),
//       decoration: BoxDecoration(
//         color: context.colorScheme.surface,
//         borderRadius: BorderRadius.circular(AppDimensions.radiusL),
//         border: Border.all(
//           color: context.colorScheme.outlineVariant.withValues(alpha: 0.5),
//         ),
//       ),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 28,
//             backgroundImage:
//                 _currentBooking.customer?.avatar != null &&
//                     _currentBooking.customer!.avatar.isNotEmpty
//                 ? NetworkImage(_currentBooking.customer!.avatar)
//                 : null,
//             child: _currentBooking.customer?.avatar == null
//                 ? const Icon(Icons.person)
//                 : null,
//           ),
//           AppDimensions.gapM,
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   _currentBooking.customer?.fullName ?? 'Verified Client',
//                   style: context.textTheme.titleMedium?.copyWith(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   _currentBooking.customer?.phoneNumber ?? 'Phone Hidden',
//                   style: context.textTheme.bodyMedium?.copyWith(
//                     color: context.colorScheme.onSurfaceVariant,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Call & Chat Action Buttons (Ready to be wired up to url_launcher or ChatCubit)
//           IconButton.filledTonal(
//             onPressed: () {},
//             icon: const Icon(Icons.chat_bubble_outline_rounded),
//           ),
//           AppDimensions.gapS,
//           IconButton.filled(onPressed: () {}, icon: const Icon(Icons.phone)),
//         ],
//       ),
//     );
//   }

//   Widget _buildLogisticsSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Job Details',
//           style: context.textTheme.titleMedium?.copyWith(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         AppDimensions.gapS,
//         Container(
//           padding: const EdgeInsets.all(AppDimensions.paddingM),
//           decoration: BoxDecoration(
//             color: context.colorScheme.surface,
//             borderRadius: BorderRadius.circular(AppDimensions.radiusL),
//             border: Border.all(
//               color: context.colorScheme.outlineVariant.withValues(alpha: 0.5),
//             ),
//           ),
//           child: Column(
//             children: [
//               _buildDetailRow(
//                 Icons.build_circle_outlined,
//                 'Service',
//                 _currentBooking.requestedService,
//               ),
//               const Divider(height: 24),
//               _buildDetailRow(
//                 Icons.calendar_today_outlined,
//                 'Scheduled For',
//                 _currentBooking.scheduledAt,
//               ),
//               const Divider(height: 24),
//               _buildDetailRow(
//                 Icons.location_on_outlined,
//                 'Execution Address',
//                 _currentBooking.executionAddress,
//               ),
//               if (_currentBooking.specialInstructions != null) ...[
//                 const Divider(height: 24),
//                 _buildDetailRow(
//                   Icons.info_outline,
//                   'Instructions',
//                   _currentBooking.specialInstructions!,
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   // ====================================================================
//   // 🚀 OVERHAULED FINANCIALS UI (The Transparent Receipt)
//   // Explains EXACTLY why the final payout is lower than the customer's total.
//   // ====================================================================
//   Widget _buildFinancialsSection() {
//     final bool isCash = _currentBooking.paymentMethod?.toLowerCase() == 'cash';
//     final bool isCompleted = _currentBooking.status == BookingStatus.completed;

//     // 🎯 Determine text to show for the payment method block
//     final String paymentMethodDisplay =
//         _currentBooking.paymentMethod == null ||
//             _currentBooking.paymentMethod!.isEmpty
//         ? 'PENDING SELECTION'
//         : _currentBooking.paymentMethod!.toUpperCase();

//     // 💰 STEP 1: PARSE ALL INCOMING AMOUNTS ACCURATELY
//     // If backend doesn't supply subtotal explicitly, we recreate the math securely.
//     int parsedTotal = _parseAmount(_currentBooking.totalAmount);
//     int parsedPayout = _parseAmount(_currentBooking.payoutAmount?.toString());

//     // 🎯 NEW FLAG: Check if the job actually has a price yet!
//     // If totalAmount is 0, it means it's a new SOS or pending custom quote.
//     final bool isUnpriced = parsedTotal == 0;

//     // 💰 STEP 2: The Safety Fee (The platform's fixed markup charged to the customer)
//     int safetyFee = 2000;
//     try {
//       if ((_currentBooking as dynamic).rawSafetyFee != null &&
//           (_currentBooking as dynamic).rawSafetyFee > 0) {
//         safetyFee = (_currentBooking as dynamic).rawSafetyFee;
//       }
//     } catch (_) {}

//     // 💰 STEP 3: Base Service Price (What you actually typed into the popup)
//     // If customer total is 52,000, your base price was 50,000.
//     int baseServicePrice = parsedTotal > safetyFee
//         ? parsedTotal - safetyFee
//         : parsedTotal;
//     if (parsedTotal == 0 && parsedPayout > 0) {
//       baseServicePrice = parsedPayout; // Safety fallback
//     }

//     // 💰 STEP 4: Platform Commission (What the platform deducts from your 50,000)
//     int platformCommission = baseServicePrice > parsedPayout
//         ? baseServicePrice - parsedPayout
//         : 0;

//     // 🎯 We wrap ONLY the financials section in an InvoiceCubit builder.
//     // This allows the download button to show a spinner without rebuilding the whole page.
//     return BlocBuilder<InvoiceCubit, InvoiceState>(
//       builder: (context, invoiceState) {
//         final bool isDownloading = invoiceState is InvoiceDownloading;

//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Payment Breakdown',
//               style: context.textTheme.titleMedium?.copyWith(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             AppDimensions.gapS,
//             Container(
//               padding: const EdgeInsets.all(AppDimensions.paddingM),
//               decoration: BoxDecoration(
//                 color: context.colorScheme.surface,
//                 borderRadius: BorderRadius.circular(AppDimensions.radiusL),
//                 border: Border.all(
//                   color: context.colorScheme.outlineVariant.withValues(
//                     alpha: 0.5,
//                   ),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   // --- PAYMENT METHOD ROW ---
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text('Payment Method'),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 8,
//                           vertical: 4,
//                         ),
//                         decoration: BoxDecoration(
//                           color: isCash
//                               ? Colors.orange.withValues(alpha: 0.1)
//                               : (paymentMethodDisplay == 'PENDING SELECTION'
//                                     ? Colors.grey.withValues(alpha: 0.1)
//                                     : Colors.green.withValues(alpha: 0.1)),
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         child: Text(
//                           paymentMethodDisplay,
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: isCash
//                                 ? Colors.orange.shade800
//                                 : (paymentMethodDisplay == 'PENDING SELECTION'
//                                       ? Colors.grey.shade700
//                                       : Colors.green.shade700),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Divider(height: 24),

//                   // 🎯 DYNAMIC RECEIPT UI
//                   // If unpriced, show a clean pending message instead of 0s.
//                   if (isUnpriced) ...[
//                     _buildFinancialRow(
//                       'Total Charged to Customer',
//                       _currentBooking.isEmergency
//                           ? 'Calculated Post-Job'
//                           : 'Pending Estimate',
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.symmetric(
//                         vertical: AppDimensions.paddingM,
//                       ),
//                       child: Divider(height: 1),
//                     ),
//                     // --- FINAL PAYOUT ROW ---
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Your Final Payout',
//                           style: context.textTheme.titleMedium?.copyWith(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           'Pending',
//                           style: context.textTheme.titleLarge?.copyWith(
//                             fontWeight: FontWeight.bold,
//                             color: context.colorScheme.outline,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ]
//                   // 🎯 THE TRANSPARENT RECEIPT (Shows exactly how 52,000 becomes 42,500)
//                   else ...[
//                     _buildFinancialRow(
//                       'Your Service Price',
//                       baseServicePrice.toTzs(),
//                     ),
//                     AppDimensions.gapS,
//                     _buildFinancialRow(
//                       '+ Platform Safety Fee (Paid by Customer)',
//                       safetyFee.toTzs(),
//                     ),
//                     AppDimensions.gapS,
//                     _buildFinancialRow(
//                       'Total Charged to Customer',
//                       parsedTotal.toTzs(),
//                       isBold: true,
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.symmetric(vertical: 8.0),
//                       child: Divider(height: 1, color: Colors.transparent),
//                     ),

//                     // Only show platform commission if it's > 0
//                     if (platformCommission > 0) ...[
//                       _buildFinancialRow(
//                         '- Platform Commission',
//                         '- ${platformCommission.toTzs()}',
//                         isDeduction: true,
//                       ),
//                     ],

//                     const Padding(
//                       padding: EdgeInsets.symmetric(
//                         vertical: AppDimensions.paddingM,
//                       ),
//                       child: Divider(height: 1),
//                     ),

//                     // --- FINAL PAYOUT ROW ---
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Your Final Payout',
//                           style: context.textTheme.titleMedium?.copyWith(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           parsedPayout.toTzs(), // 🎯 Uses the formatter for beautiful display
//                           style: context.textTheme.titleLarge?.copyWith(
//                             fontWeight: FontWeight.bold,
//                             color: context.colorScheme.primary,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],

//                   // --- OFFICIAL RECEIPT DOWNLOADER ---
//                   // 🚨 Only appears if the job is completely finished AND Laravel generated an invoice URL
//                   if (isCompleted && _currentBooking.invoiceUrl != null) ...[
//                     const Divider(height: 24),
//                     SizedBox(
//                       width: double.infinity,
//                       child: OutlinedButton.icon(
//                         onPressed: isDownloading
//                             ? null
//                             : () {
//                                 // Trigger the Invoice Cubit Download Pipeline
//                                 context.read<InvoiceCubit>().downloadReceipt(
//                                   _currentBooking.invoiceUrl!,
//                                   _currentBooking.bookingReference,
//                                 );
//                               },
//                         icon: isDownloading
//                             ? const SizedBox(
//                                 width: 16,
//                                 height: 16,
//                                 child: CircularProgressIndicator(
//                                   strokeWidth: 2,
//                                 ),
//                               )
//                             : const Icon(Icons.download_rounded, size: 18),
//                         label: Text(
//                           isDownloading
//                               ? 'Downloading...'
//                               : 'Download Official Receipt',
//                         ),
//                         style: OutlinedButton.styleFrom(
//                           foregroundColor: context.colorScheme.primary,
//                           side: BorderSide(
//                             color: context.colorScheme.primary.withValues(
//                               alpha: 0.5,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   // 🛠 SMALL HELPER: Builds the individual rows for the receipt breakdown.
//   // If [isDeduction] is true, it renders the text in red to indicate a fee being subtracted.
//   Widget _buildFinancialRow(
//     String label,
//     String value, {
//     bool isDeduction = false,
//     bool isBold = false,
//   }) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: context.textTheme.bodyMedium?.copyWith(
//             color: isBold
//                 ? context.colorScheme.onSurface
//                 : context.colorScheme.onSurfaceVariant,
//             fontSize: isBold ? 14 : 13,
//             fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
//           ),
//         ),
//         Text(
//           value,
//           style: context.textTheme.bodyMedium?.copyWith(
//             fontWeight: isDeduction
//                 ? FontWeight.normal
//                 : (isBold ? FontWeight.bold : FontWeight.w600),
//             color: isDeduction ? context.colorScheme.error : null,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDetailRow(IconData icon, String label, String value) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Icon(icon, size: 20, color: context.colorScheme.outline),
//         AppDimensions.gapM,
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 style: context.textTheme.labelSmall?.copyWith(
//                   color: context.colorScheme.onSurfaceVariant,
//                 ),
//               ),
//               Text(value, style: context.textTheme.bodyMedium),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_filex/open_filex.dart'; // 🎯 REAL NATIVE FILE OPENER

// 🎯 CORE IMPORTS
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/global/presentation/widgets/sevika_button.dart';
import '../../../../core/extensions/currency_formatter_extensions.dart';

// 🎯 DOMAIN & CUBIT IMPORTS
import '../../../notification/presentation/cubits/notification/notifications_cubit.dart';
import '../../../notification/presentation/cubits/notification/notifications_state.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/entities/booking_status.dart';
import '../../domain/usecases/params/update_booking_status_params.dart';
import '../cubits/invoice/invoice_state.dart';
import '../cubits/manage_job/manage_job_cubit.dart';
import '../cubits/manage_job/manage_job_state.dart';
import '../cubits/invoice/invoice_cubit.dart';
import '../helpers/provider_booking_action_helper.dart';

class ProviderBookingDetailScreen extends StatefulWidget {
  final BookingEntity booking;

  const ProviderBookingDetailScreen({super.key, required this.booking});

  @override
  State<ProviderBookingDetailScreen> createState() =>
      _ProviderBookingDetailScreenState();
}

class _ProviderBookingDetailScreenState
    extends State<ProviderBookingDetailScreen> {
  late BookingEntity _currentBooking;
  String? _lastProcessedNotificationId;

  @override
  void initState() {
    super.initState();
    _currentBooking = widget.booking;
  }

  int _parseAmount(String? amountStr) {
    if (amountStr == null || amountStr.isEmpty) return 0;
    final cleanStr = amountStr.replaceAll(RegExp(r'[^0-9.]'), '');
    return (double.tryParse(cleanStr) ?? 0.0).round();
  }

  void _applyWebSocketPaymentSuccess() {
    setState(() {
      _currentBooking = _currentBooking.copyWith(
        status: BookingStatus.completed,
        isPaid: true,
        paymentStatus: 'completed',
      );
    });
  }

  // ====================================================================
  // ⚙️ THE STATE MACHINE LOGIC
  // ====================================================================
  Future<void> _handlePrimaryAction() async {
    final status = _currentBooking.status;
    final cubit = context.read<ManageJobCubit>();

    if (status == BookingStatus.pending) {
      cubit.updateJobStatus(
        UpdateBookingStatusParams(
          bookingReference: _currentBooking.bookingReference,
          status: 'accepted',
        ),
      );
    } else if (status == BookingStatus.accepted ||
        status == BookingStatus.confirmed) {
      cubit.updateJobStatus(
        UpdateBookingStatusParams(
          bookingReference: _currentBooking.bookingReference,
          status: 'en_route',
        ),
      );
    } else if (status == BookingStatus.enRoute) {
      final pin = await _showVerificationPinDialog();
      if (pin != null && pin.length >= 4) {
        cubit.updateJobStatus(
          UpdateBookingStatusParams(
            bookingReference: _currentBooking.bookingReference,
            status: 'in_progress',
            verificationCode: pin,
          ),
        );
      }
    } else if (status == BookingStatus.ongoing) {
      if (_currentBooking.isEmergency) {
        final String? finalPriceStr = await _showFinalPriceDialog();
        if (finalPriceStr != null && finalPriceStr.isNotEmpty) {
          cubit.updateJobStatus(
            UpdateBookingStatusParams(
              bookingReference: _currentBooking.bookingReference,
              status: 'completed',
              finalPrice: double.parse(finalPriceStr),
            ),
          );
        }
      } else {
        cubit.updateJobStatus(
          UpdateBookingStatusParams(
            bookingReference: _currentBooking.bookingReference,
            status: 'completed',
          ),
        );
      }
    } else if (status == BookingStatus.pendingPayment) {
      final String method = _currentBooking.paymentMethod?.toLowerCase() ?? '';

      // 🎯 STRICT CASH COLLECTION
      if (method == 'cash') {
        final int amountToCollect = _parseAmount(_currentBooking.totalAmount);
        final didCollect =
            await ProviderBookingActionHelper.confirmCashHandover(
              context,
              amountToCollect.toDouble(),
            );
        if (didCollect) {
          cubit.confirmCashCollection(_currentBooking.bookingReference);
        }
      }
    }
  }

  // ====================================================================
  // 💰 POST-JOB BILLING DIALOG
  // ====================================================================
  Future<String?> _showFinalPriceDialog() {
    final TextEditingController priceController = TextEditingController();
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('Submit Final Invoice'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'This is an Emergency SOS dispatch. Please enter the final total amount the customer needs to pay for your service today.',
            ),
            AppDimensions.gapM,
            TextField(
              controller: priceController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                hintText: 'e.g. 50000',
                prefixText: 'TSh ',
                filled: true,
                fillColor: context.colorScheme.surfaceContainerLowest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, null),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, priceController.text),
            child: const Text('Submit to Customer'),
          ),
        ],
      ),
    );
  }

  // ====================================================================
  // 🔐 VERIFICATION PIN DIALOG
  // ====================================================================
  Future<String?> _showVerificationPinDialog() {
    final TextEditingController pinController = TextEditingController();
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('Enter Security PIN'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Please ask the customer for their 4-digit verification PIN to officially start the stopwatch for this job.',
            ),
            AppDimensions.gapM,
            TextField(
              controller: pinController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 4,
              style: context.textTheme.headlineMedium?.copyWith(
                letterSpacing: 8.0,
                fontWeight: FontWeight.bold,
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                hintText: '----',
                filled: true,
                fillColor: context.colorScheme.surfaceContainerLowest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, null),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, pinController.text),
            child: const Text('Verify & Start'),
          ),
        ],
      ),
    );
  }

  // ====================================================================
  // 🎨 UI BUILDER & MULTI-BLOC CONSUMER
  // ====================================================================
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ManageJobCubit, ManageJobState>(
          listener: (context, state) {
            if (state is ManageJobFailure) {
              context.showSnackBar(
                state.error.message ?? 'Failed to update job status.',
                type: SnackBarType.error,
              );
            } else if (state is ManageJobSuccess) {
              context.showSnackBar(
                'Job status updated successfully!',
                type: SnackBarType.success,
              );
              setState(() {
                _currentBooking = state.booking;
              });
            }
            // 🚀 INDUSTRY STANDARD: Silent UI update when we fetch the true status!
            else if (state is ManageJobFetchSuccess) {
              setState(() {
                _currentBooking = state.booking;
              });

              // 🎯 ADDED: Visual feedback so the button doesn't feel "dead"
              if (_currentBooking.status == BookingStatus.pendingPayment) {
                final String method =
                    _currentBooking.paymentMethod?.toLowerCase() ?? '';

                if (method == 'cash') {
                  context.showSnackBar(
                    '💵 Customer selected Cash! You can now confirm receipt.',
                    type: SnackBarType.success,
                  );
                } else if (!_currentBooking.isPaid) {
                  context.showSnackBar(
                    'Still waiting for customer to process payment...',
                    type: SnackBarType.info,
                  );
                }
              } else if (_currentBooking.isPaid) {
                context.showSnackBar(
                  '💰 Digital payment successful!',
                  type: SnackBarType.success,
                );
              }
            }
          },
        ),
        BlocListener<InvoiceCubit, InvoiceState>(
          listener: (context, state) {
            if (state is InvoiceDownloadFailure) {
              context.showSnackBar(
                state.error.message ?? 'Failed to download receipt.',
                type: SnackBarType.error,
              );
            } else if (state is InvoiceDownloadSuccess) {
              context.showSnackBar(
                'Receipt downloaded successfully!',
                type: SnackBarType.success,
              );
              OpenFilex.open(state.filePath);
            }
          },
        ),

        // 🚀 LISTENER 3: INDUSTRY STANDARD STRICT EVENT ENFORCEMENT
        BlocListener<NotificationsCubit, NotificationsState>(
          listener: (context, state) {
            if (state is NotificationsLoadSuccess &&
                state.notifications.isNotEmpty) {
              final latest = state.notifications.first;

              if (_lastProcessedNotificationId == latest.id) return;
              _lastProcessedNotificationId = latest.id;

              if (latest.data.metadata.bookingReference ==
                  _currentBooking.bookingReference) {
                final String metaStatus =
                    latest.data.metadata.status?.toLowerCase() ?? '';
                final String eventContext =
                    latest.data.metadata.triggerContext?.toLowerCase() ?? '';

                if (metaStatus == 'completed' ||
                    eventContext == 'invoice_paid') {
                  _applyWebSocketPaymentSuccess();
                  context.showSnackBar(
                    '💰 Digital payment successful!',
                    type: SnackBarType.success,
                  );
                } else if (eventContext == 'cash_selected') {
                  setState(() {
                    _currentBooking = _currentBooking.copyWith(
                      paymentMethod: 'cash',
                      paymentStatus: 'pending',
                    );
                  });
                  context.showSnackBar(
                    '💵 Customer selected Cash! You can now confirm receipt.',
                    type: SnackBarType.success,
                  );
                }
              }
            }
          },
        ),
      ],
      child: BlocBuilder<ManageJobCubit, ManageJobState>(
        builder: (context, state) {
          final bool isLoading = state is ManageJobLoading;
          final bool isPastJob =
              _currentBooking.status == BookingStatus.completed ||
              _currentBooking.status == BookingStatus.cancelled;

          bool isWaitingForCustomerPayment = false;

          if (_currentBooking.status == BookingStatus.pendingPayment) {
            final String method =
                _currentBooking.paymentMethod?.toLowerCase() ?? '';
            if (method != 'cash') {
              isWaitingForCustomerPayment = true;
            }
          }

          return Scaffold(
            backgroundColor: context.colorScheme.surfaceContainerLowest,
            appBar: AppBar(
              title: Text('Job ${_currentBooking.bookingReference}'),
              centerTitle: true,
              backgroundColor: context.colorScheme.surfaceContainerLowest,
              elevation: 0,
            ),

            bottomNavigationBar: isPastJob
                ? null
                : Container(
                    padding: EdgeInsets.only(
                      left: AppDimensions.paddingM,
                      right: AppDimensions.paddingM,
                      top: AppDimensions.paddingM,
                      bottom:
                          MediaQuery.of(context).padding.bottom +
                          AppDimensions.paddingM,
                    ),
                    decoration: BoxDecoration(
                      color: context.colorScheme.surface,
                      boxShadow: [
                        BoxShadow(
                          color: context.colorScheme.shadow.withValues(
                            alpha: 0.05,
                          ),
                          offset: const Offset(0, -4),
                          blurRadius: 16,
                        ),
                      ],
                    ),
                    child: SafeArea(
                      child: SevikaButton(
                        text: isWaitingForCustomerPayment
                            ? 'Check Payment Status'
                            : ProviderBookingActionHelper.getPrimaryActionText(
                                _currentBooking,
                              ),
                        isLoading: isLoading,

                        onPressed:
                            (isLoading ||
                                _currentBooking.status ==
                                    BookingStatus.quoteProvided)
                            ? null
                            : () {
                                if (isWaitingForCustomerPayment) {
                                  // 🚀 100% CLEAN CUBIT API FETCH: No more missing provider errors!
                                  context
                                      .read<ManageJobCubit>()
                                      .fetchJobDetails(
                                        _currentBooking.bookingReference,
                                      );
                                } else {
                                  _handlePrimaryAction();
                                }
                              },
                      ),
                    ),
                  ),

            // 🎯 SAFEST REFRESH POSSIBLE: 100% relies on ManageJobCubit!
            body: RefreshIndicator(
              onRefresh: () async {
                await context.read<ManageJobCubit>().fetchJobDetails(
                  _currentBooking.bookingReference,
                );
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(AppDimensions.paddingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStatusBanner(),
                    AppDimensions.gapL,
                    _buildCustomerCard(),
                    AppDimensions.gapL,
                    _buildLogisticsSection(),
                    AppDimensions.gapL,
                    _buildFinancialsSection(),
                    AppDimensions.gapXXXL,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // --- SUB WIDGETS ---

  Widget _buildStatusBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(
          color: context.colorScheme.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Current Job Phase',
            style: context.textTheme.labelMedium?.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
          AppDimensions.gapXS,
          Text(
            _currentBooking.status.name.toUpperCase(),
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerCard() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        border: Border.all(
          color: context.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage:
                _currentBooking.customer?.avatar != null &&
                    _currentBooking.customer!.avatar.isNotEmpty
                ? NetworkImage(_currentBooking.customer!.avatar)
                : null,
            child: _currentBooking.customer?.avatar == null
                ? const Icon(Icons.person)
                : null,
          ),
          AppDimensions.gapM,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _currentBooking.customer?.fullName ?? 'Verified Client',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _currentBooking.customer?.phoneNumber ?? 'Phone Hidden',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          IconButton.filledTonal(
            onPressed: () {},
            icon: const Icon(Icons.chat_bubble_outline_rounded),
          ),
          AppDimensions.gapS,
          IconButton.filled(onPressed: () {}, icon: const Icon(Icons.phone)),
        ],
      ),
    );
  }

  Widget _buildLogisticsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Job Details',
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        AppDimensions.gapS,
        Container(
          padding: const EdgeInsets.all(AppDimensions.paddingM),
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(AppDimensions.radiusL),
            border: Border.all(
              color: context.colorScheme.outlineVariant.withValues(alpha: 0.5),
            ),
          ),
          child: Column(
            children: [
              _buildDetailRow(
                Icons.build_circle_outlined,
                'Service',
                _currentBooking.requestedService,
              ),
              const Divider(height: 24),
              _buildDetailRow(
                Icons.calendar_today_outlined,
                'Scheduled For',
                _currentBooking.scheduledAt,
              ),
              const Divider(height: 24),
              _buildDetailRow(
                Icons.location_on_outlined,
                'Execution Address',
                _currentBooking.executionAddress,
              ),
              if (_currentBooking.specialInstructions != null) ...[
                const Divider(height: 24),
                _buildDetailRow(
                  Icons.info_outline,
                  'Instructions',
                  _currentBooking.specialInstructions!,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFinancialsSection() {
    final bool isCash = _currentBooking.paymentMethod?.toLowerCase() == 'cash';
    final bool isCompleted = _currentBooking.status == BookingStatus.completed;

    final String paymentMethodDisplay =
        _currentBooking.paymentMethod == null ||
            _currentBooking.paymentMethod!.isEmpty
        ? 'PENDING SELECTION'
        : _currentBooking.paymentMethod!.toUpperCase();

    int parsedTotal = _parseAmount(_currentBooking.totalAmount);
    int parsedPayout = _parseAmount(_currentBooking.payoutAmount?.toString());
    final bool isUnpriced = parsedTotal == 0;

    int safetyFee = 2000;
    try {
      if ((_currentBooking as dynamic).rawSafetyFee != null &&
          (_currentBooking as dynamic).rawSafetyFee > 0) {
        safetyFee = (_currentBooking as dynamic).rawSafetyFee;
      }
    } catch (_) {}

    int baseServicePrice = parsedTotal > safetyFee
        ? parsedTotal - safetyFee
        : parsedTotal;
    if (parsedTotal == 0 && parsedPayout > 0) baseServicePrice = parsedPayout;

    int platformCommission = baseServicePrice > parsedPayout
        ? baseServicePrice - parsedPayout
        : 0;

    return BlocBuilder<InvoiceCubit, InvoiceState>(
      builder: (context, invoiceState) {
        final bool isDownloading = invoiceState is InvoiceDownloading;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Breakdown',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            AppDimensions.gapS,
            Container(
              padding: const EdgeInsets.all(AppDimensions.paddingM),
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                border: Border.all(
                  color: context.colorScheme.outlineVariant.withValues(
                    alpha: 0.5,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Payment Method'),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isCash
                              ? Colors.orange.withValues(alpha: 0.1)
                              : (paymentMethodDisplay == 'PENDING SELECTION'
                                    ? Colors.grey.withValues(alpha: 0.1)
                                    : Colors.green.withValues(alpha: 0.1)),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          paymentMethodDisplay,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isCash
                                ? Colors.orange.shade800
                                : (paymentMethodDisplay == 'PENDING SELECTION'
                                      ? Colors.grey.shade700
                                      : Colors.green.shade700),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),

                  if (isUnpriced) ...[
                    _buildFinancialRow(
                      'Total Charged to Customer',
                      _currentBooking.isEmergency
                          ? 'Calculated Post-Job'
                          : 'Pending Estimate',
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppDimensions.paddingM,
                      ),
                      child: Divider(height: 1),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Your Final Payout',
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Pending',
                          style: context.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    _buildFinancialRow(
                      'Your Service Price',
                      baseServicePrice.toTzs(),
                    ),
                    AppDimensions.gapS,
                    _buildFinancialRow(
                      '+ Platform Safety Fee (Paid by Customer)',
                      safetyFee.toTzs(),
                    ),
                    AppDimensions.gapS,
                    _buildFinancialRow(
                      'Total Charged to Customer',
                      parsedTotal.toTzs(),
                      isBold: true,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Divider(height: 1, color: Colors.transparent),
                    ),

                    if (platformCommission > 0) ...[
                      _buildFinancialRow(
                        '- Platform Commission (15%)',
                        '- ${platformCommission.toTzs()}',
                        isDeduction: true,
                      ),
                    ],

                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppDimensions.paddingM,
                      ),
                      child: Divider(height: 1),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Your Final Payout',
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          parsedPayout.toTzs(),
                          style: context.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],

                  if (isCompleted && _currentBooking.invoiceUrl != null) ...[
                    const Divider(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: isDownloading
                            ? null
                            : () =>
                                  context.read<InvoiceCubit>().downloadReceipt(
                                    _currentBooking.invoiceUrl!,
                                    _currentBooking.bookingReference,
                                  ),
                        icon: isDownloading
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.download_rounded, size: 18),
                        label: Text(
                          isDownloading
                              ? 'Downloading...'
                              : 'Download Official Receipt',
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: context.colorScheme.primary,
                          side: BorderSide(
                            color: context.colorScheme.primary.withValues(
                              alpha: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFinancialRow(
    String label,
    String value, {
    bool isDeduction = false,
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.textTheme.bodyMedium?.copyWith(
            color: isBold
                ? context.colorScheme.onSurface
                : context.colorScheme.onSurfaceVariant,
            fontSize: isBold ? 14 : 13,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: isDeduction
                ? FontWeight.normal
                : (isBold ? FontWeight.bold : FontWeight.w600),
            color: isDeduction ? context.colorScheme.error : null,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: context.colorScheme.outline),
        AppDimensions.gapM,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              Text(value, style: context.textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }
}
