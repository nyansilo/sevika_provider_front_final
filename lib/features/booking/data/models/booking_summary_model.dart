// import '../../domain/entities/booking_summary_entity.dart';

// class BookingSummaryModel extends BookingSummaryEntity {
//   const BookingSummaryModel({
//     required super.totalCount,
//     required super.activeCount,
//     required super.completedCount,
//   });

//   BookingSummaryEntity toEntity() => this;

//   factory BookingSummaryModel.fromJson(Map<String, dynamic> json) {
//     return BookingSummaryModel(
//       // 🎯 Maps 'totalJobsAllocated' from provider JSON (or falls back to totalCount)
//       totalCount: json['totalJobsAllocated'] != null
//           ? (num.tryParse(json['totalJobsAllocated'].toString())?.toInt() ?? 0)
//           : (num.tryParse(json['totalCount']?.toString() ?? '0')?.toInt() ?? 0),

//       // 🎯 Maps 'activeSchedules' from provider JSON
//       activeCount: json['activeSchedules'] != null
//           ? (num.tryParse(json['activeSchedules'].toString())?.toInt() ?? 0)
//           : (num.tryParse(json['activeCount']?.toString() ?? '0')?.toInt() ??
//                 0),

//       completedCount: json['completedCount'] != null
//           ? (num.tryParse(json['completedCount'].toString())?.toInt() ?? 0)
//           : 0,
//     );
//   }
// }

import '../../domain/entities/booking_summary_entity.dart';

class BookingSummaryModel extends BookingSummaryEntity {
  const BookingSummaryModel({
    required super.totalCount,
    required super.activeCount,
    required super.completedCount,
  });

  BookingSummaryEntity toEntity() => this;

  factory BookingSummaryModel.fromJson(Map<String, dynamic> json) {
    return BookingSummaryModel(
      // 🎯 Maps 'totalJobsAllocated' from provider JSON (or falls back to totalCount)
      totalCount: json['totalJobsAllocated'] != null
          ? (num.tryParse(json['totalJobsAllocated'].toString())?.toInt() ?? 0)
          : (num.tryParse(json['totalCount']?.toString() ?? '0')?.toInt() ?? 0),

      // 🎯 Maps 'activeSchedules' from provider JSON
      activeCount: json['activeSchedules'] != null
          ? (num.tryParse(json['activeSchedules'].toString())?.toInt() ?? 0)
          : (num.tryParse(json['activeCount']?.toString() ?? '0')?.toInt() ??
                0),

      // 🎯 Safely maps completedCount directly from the analytics block!
      completedCount: json['completedCount'] != null
          ? (num.tryParse(json['completedCount'].toString())?.toInt() ?? 0)
          : 0,
    );
  }
}
