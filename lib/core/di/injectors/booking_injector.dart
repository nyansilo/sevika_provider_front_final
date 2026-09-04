import 'package:get_it/get_it.dart';

// ===========================================================================
// 📦 DATA SOURCES & REPOSITORIES
// ===========================================================================
import '../../../features/booking/data/datasources/booking_remote_data_source.dart';
import '../../../features/booking/data/repositories/booking_repository_impl.dart';
import '../../../features/booking/domain/repositories/bookings_repository.dart';

// ===========================================================================
// 🛠️ USE CASES (Provider Perspective)
// ===========================================================================
import '../../../features/booking/domain/usecases/get_booking_details_usecase.dart';
import '../../../features/booking/domain/usecases/get_provider_bookings_usecase.dart';
import '../../../features/booking/domain/usecases/update_booking_status_usecase.dart';
import '../../../features/booking/domain/usecases/confirm_cash_receipt_usecase.dart';
import '../../../features/booking/domain/usecases/accept_emergency_usecase.dart';
import '../../../features/booking/domain/usecases/cancel_booking_usecase.dart';
import '../../../features/booking/domain/usecases/download_invoice_usecase.dart';

// ===========================================================================
// 📱 PRESENTATION CUBITS
// ===========================================================================
import '../../../features/booking/presentation/cubits/booking_history/booking_history_cubit.dart';
import '../../../features/booking/presentation/cubits/manage_job/manage_job_cubit.dart';
import '../../../features/booking/presentation/cubits/invoice/invoice_cubit.dart'; // 🎯 ADDED: For PDF Downloads

/// 🎯 BOOKING DOMAIN INJECTOR
/// Initializes all dependencies required for the Provider's Job Board,
/// Lead Management, and Active Job Tracking.
void initBooking(GetIt sl) {
  // ---------------------------------------------------------------------------
  // 1. DATA SOURCES
  // ---------------------------------------------------------------------------
  // Registers the remote data source that communicates directly with the Laravel API.
  sl.registerLazySingleton<BookingRemoteDataSource>(
    () => BookingRemoteDataSourceImpl(sl()),
  );

  // ---------------------------------------------------------------------------
  // 2. REPOSITORIES
  // ---------------------------------------------------------------------------
  // Registers the Repository Implementation, bridging the Domain and Data layers.
  sl.registerLazySingleton<BookingRepository>(
    () => BookingRepositoryImpl(remoteDataSource: sl()),
  );

  // ---------------------------------------------------------------------------
  // 3. USE CASES (Business Logic)
  // ---------------------------------------------------------------------------
  // 👨‍🔧 Provider-Specific Pipeline Fetcher
  sl.registerLazySingleton(() => GetProviderBookingsUseCase(sl()));

  // 👨‍🔧 Status Mutator (En Route -> In Progress -> Completed)
  sl.registerLazySingleton(() => UpdateBookingStatusUseCase(sl()));

  // 👨‍🔧 Cash Escrow Confirmation
  sl.registerLazySingleton(() => ConfirmCashReceiptUseCase(sl()));

  // 👨‍🔧 Emergency Dispatch Acceptance
  sl.registerLazySingleton(() => AcceptEmergencyUseCase(sl()));

  // Standard Utilities
  sl.registerLazySingleton(() => CancelBookingUseCase(sl()));
  sl.registerLazySingleton(() => DownloadInvoiceUseCase(sl()));

  sl.registerLazySingleton(() => GetBookingDetailsUseCase(sl()));
  // ---------------------------------------------------------------------------
  // 4. CUBITS (State Management)
  // ---------------------------------------------------------------------------
  // 🚨 Note: Cubits are registered as Factories!
  // This ensures that every time you open a screen, it gets a fresh state memory slot,
  // preventing data from bleeding between different screens.

  // 👨‍🔧 Powers the Job Board (Pending, Active, Completed tabs)
  sl.registerFactory<BookingHistoryCubit>(
    () => BookingHistoryCubit(getProviderBookingsUseCase: sl()),
  );

  // 👨‍🔧 Powers the actionable buttons (Accept, Start Job, Confirm Cash) inside Job Details
  sl.registerFactory<ManageJobCubit>(
    () => ManageJobCubit(
      updateStatusUseCase: sl(),
      confirmCashUseCase: sl(),
      acceptEmergencyUseCase: sl(),
      getBookingDetailsUseCase: sl(),
    ),
  );

  // 🎯 ADDED: Powers the isolated receipt downloading state.
  // We separate this from ManageJobCubit so the entire page doesn't show a loading
  // spinner just because a file is downloading in the background.
  sl.registerFactory<InvoiceCubit>(
    () => InvoiceCubit(downloadInvoiceUseCase: sl()),
  );
}
