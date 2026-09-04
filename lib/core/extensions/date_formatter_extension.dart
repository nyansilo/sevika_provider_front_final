import 'package:intl/intl.dart';

extension SevikaDateFormatter on DateTime {
  /// 💬 Converts DateTime into a smart dynamic review format ("Now" or "May 28, 2026")
  String toReviewFormat() {
    final DateTime now = DateTime.now();
    final Duration difference = now.difference(this);

    // Math.abs handles slight backend/frontend system time-sync offsets safely (-5s to 60s)
    if (difference.inSeconds.abs() < 60) {
      return 'Just now';
    }

    // Displays clear localized layout styles
    return DateFormat('MMM dd, yyyy').format(this);
  }

  /// 📅 Converts DateTime to a standard flat dashboard representation: "20 Jun 2026"
  String toStandardDate() {
    return DateFormat('dd MMM yyyy').format(this);
  }

  /// ⏰ Converts DateTime to an explicit timestamp layout: "20 Jun 2026, 02:26 PM"
  String toDateTimeString() {
    return DateFormat('dd MMM yyyy, hh:mm a').format(this);
  }

  /// 💳 Converts DateTime to a granular digital transaction log readout: "02:26:36 PM"
  String toTimeOnly() {
    return DateFormat('hh:mm:ss a').format(this);
  }
}

extension SevikaStringDateFormatter on String {
  /// 🚀 Safely parses incoming backend ISO strings directly into your custom dynamic review layout
  String toReviewFormatString() {
    try {
      return DateTime.parse(this).toLocal().toReviewFormat();
    } catch (_) {
      return this; // Fallback gracefully to original text string block if parsing crashes
    }
  }

  /// 🗃️ Safely parses backend ISO strings directly into explicit text timestamp logs
  String toDateTimeStringFromIso() {
    try {
      return DateTime.parse(this).toLocal().toDateTimeString();
    } catch (_) {
      return this;
    }
  }

  /// ⏰ Safely parses backend ISO strings into a simple 12-hour time format (e.g., "2:30 PM")
  String toSimpleTime() {
    if (isEmpty) return '';
    try {
      final date = DateTime.parse(this).toLocal();

      // 💡 Note: You could also use DateFormat('h:mm a').format(date) here,
      // but we preserved your exact custom math logic for specific precision!
      final hour = date.hour > 12
          ? date.hour - 12
          : (date.hour == 0 ? 12 : date.hour);
      final minute = date.minute.toString().padLeft(2, '0');
      final period = date.hour >= 12 ? 'PM' : 'AM';

      return '$hour:$minute $period';
    } catch (_) {
      return '';
    }
  }
}
