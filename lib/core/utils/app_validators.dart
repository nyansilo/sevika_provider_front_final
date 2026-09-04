// // lib/core/utils/app_validators.dart
// import 'package:flutter/material.dart';
// import '../constants/ui_strings.dart';
// import '../constants/app_dimensions.dart';

// /// Centralized Form Validation Engine.
// class AppValidators {
//   const AppValidators._();

//   /// ==========================================
//   /// 1. AUTHENTICATION & IDENTITY VALIDATORS
//   /// ==========================================

//   static String? validateFullName(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return UiStrings.hintFullName;
//     }
//     final nameParts = value.trim().split(RegExp(r'\s+'));
//     if (nameParts.length < 2) {
//       return 'Please enter both your first and last name.';
//     }
//     return null;
//   }

//   static String? validateTanzanianPhone(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Phone number is required';
//     }

//     // Strip spaces, plus signs, and hyphens
//     final cleanValue = value.replaceAll(RegExp(r'\s+|\+|-'), '');

//     // FIXED REGEX: Made the (0 or 255) optional using '?' so raw '7...' or '6...' numbers pass!
//     final phoneRegex = RegExp(r'^(0|255)?[67]\d{8}$');

//     if (!phoneRegex.hasMatch(cleanValue)) {
//       return 'Enter a valid Tanzanian phone number (e.g., 0712345678 or 712345678).';
//     }
//     return null;
//   }

//   // ─── ADDED: CENTRALIZED PASSWORD ARCHITECTURE VALIDATOR ───
//   /// Enforces explicit rule profiles on incoming user authentication keys.
//   static String? validatePassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Password cannot be empty.';
//     }
//     if (value.length < 6) {
//       return 'Password must contain at least 6 characters.';
//     }
//     return null;
//   }

//   // ─── ADDED: PASSWORD CROSS-CHECK CONFIRMATION VALIDATOR ───
//   /// Verifies absolute equivalence between two target string input inputs.
//   static String? validateConfirmPassword(
//     String? value,
//     String originalPassword,
//   ) {
//     if (value == null || value.isEmpty) {
//       return 'Please retype your password to confirm.';
//     }
//     if (value != originalPassword) {
//       return 'Passwords do not match. Please verify parameters.';
//     }
//     return null;
//   }

//   static String? validateNida(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return UiStrings.hintNidaNumber;
//     }
//     final cleanValue = value.trim();
//     final nidaRegex = RegExp(r'^\d{20}$');
//     if (!nidaRegex.hasMatch(cleanValue)) {
//       return 'NIDA number must contain exactly 20 digits.';
//     }
//     return null;
//   }

//   static String? validateOtp(String? value, {int requiredLength = 6}) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Please enter the verification code.';
//     }
//     final cleanValue = value.trim();
//     if (cleanValue.length != requiredLength ||
//         int.tryParse(cleanValue) == null) {
//       return 'Verification code must be a $requiredLength-digit number.';
//     }
//     return null;
//   }

//   static String? validateEmail(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Email address cannot be empty.';
//     }
//     final emailRegex = RegExp(
//       r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
//     );
//     if (!emailRegex.hasMatch(value.trim())) {
//       return 'Please enter a valid email address.';
//     }
//     return null;
//   }

//   /// ==========================================
//   /// 2. DIGITAL WALLET & TRANSACTION VALIDATORS
//   /// ==========================================
//   static String? validateAmount(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Please specify an amount.';
//     }
//     final sanitized = value.replaceAll(',', '').trim();
//     final numAmount = num.tryParse(sanitized);

//     if (numAmount == null) {
//       return 'Please enter a valid numeric value.';
//     }
//     if (numAmount < AppDimensions.categoryGridItemHeight * 9.0909) {
//       return UiStrings.paymentMinLimitWarning;
//     }
//     return null;
//   }

//   static String? validateMaxWalletAction(String? value, double maxLimit) {
//     final basicCheck = validateAmount(value);
//     if (basicCheck != null) return basicCheck;

//     final sanitized = value!.replaceAll(',', '').trim();
//     final numAmount = double.parse(sanitized);

//     if (numAmount > maxLimit) {
//       return 'Amount exceeds your single transaction threshold limits.';
//     }
//     return null;
//   }

//   static String? validateSecureTransactionPin(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Wallet transaction PIN is required.';
//     }
//     final cleanValue = value.trim();
//     if (cleanValue.length != AppDimensions.radiusXS.toInt() ||
//         int.tryParse(cleanValue) == null) {
//       return 'PIN must be exactly 4 digits.';
//     }
//     final sequentialRegex = RegExp(r'^(0123|1234|2345|3456|4567|5678|6789)$');
//     final identicalRegex = RegExp(r'^(\d)\1{3}$');
//     if (sequentialRegex.hasMatch(cleanValue) ||
//         identicalRegex.hasMatch(cleanValue)) {
//       return 'For security, avoid sequential or identical digits.';
//     }
//     return null;
//   }

//   /// ==========================================
//   /// 3. BOOKING CATALOG & SCHEDULING VALIDATORS
//   /// ==========================================
//   static String? validateBookingInstructions(
//     String? value, {
//     int maxChars = 250,
//   }) {
//     if (value == null || value.trim().isEmpty) return null;
//     if (value.trim().length > maxChars) {
//       return 'Instructions cannot exceed $maxChars characters.';
//     }
//     return null;
//   }

//   static String? validateBookingDate(DateTime? selectedDate) {
//     if (selectedDate == null) return 'Please choose a preferred service date.';
//     final systemToday = DateTime.now();
//     final structuralToday = DateTime(
//       systemToday.year,
//       systemToday.month,
//       systemToday.day,
//     );
//     if (selectedDate.isBefore(structuralToday)) {
//       return 'Booking dates cannot point to a past date.';
//     }
//     return null;
//   }

//   static String? validateBookingTime(
//     TimeOfDay? selectedTime,
//     DateTime? selectedDate,
//   ) {
//     if (selectedTime == null) {
//       return 'Please choose a preferred service arrival time.';
//     }
//     if (selectedDate == null) return null;

//     final currentMoment = DateTime.now();
//     final targetedMoment = DateTime(
//       selectedDate.year,
//       selectedDate.month,
//       selectedDate.day,
//       selectedTime.hour,
//       selectedTime.minute,
//     );

//     if (targetedMoment.isBefore(
//       currentMoment.add(const Duration(minutes: 30)),
//     )) {
//       return 'Arrival slots must be scheduled at least 30 minutes in advance.';
//     }
//     return null;
//   }

//   /// ==========================================
//   /// 4. GENERAL PURPOSE SYSTEM UTILITY FIELDS
//   /// ==========================================
//   static String? validateRequiredField(
//     String? value,
//     String customErrorMessage,
//   ) {
//     if (value == null || value.trim().isEmpty) return customErrorMessage;
//     return null;
//   }

//   static String? validateReviewComment(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Please write a brief comment regarding your experience.';
//     }
//     if (value.trim().length < AppDimensions.badgeDotSize.toInt()) {
//       return 'Your feedback must contain at least 10 characters.';
//     }
//     return null;
//   }
// }

// lib/core/utils/app_validators.dart
import 'package:flutter/material.dart';
import '../constants/ui_strings.dart';

/// Centralized Form Validation Engine.
class AppValidators {
  const AppValidators._();

  /// ==========================================
  /// 1. AUTHENTICATION & IDENTITY VALIDATORS
  /// ==========================================

  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return UiStrings.hintFullName;
    }
    final nameParts = value.trim().split(RegExp(r'\s+'));
    if (nameParts.length < 2) {
      return 'Please enter both your first and last name.';
    }
    return null;
  }

  static String? validateTanzanianPhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }

    final cleanValue = value.replaceAll(RegExp(r'\s+|\+|-'), '');
    final phoneRegex = RegExp(r'^(0|255)?[67]\d{8}$');

    if (!phoneRegex.hasMatch(cleanValue)) {
      return 'Enter a valid Tanzanian phone number (e.g., 0712345678 or 712345678).';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty.';
    }
    if (value.length < 6) {
      return 'Password must contain at least 6 characters.';
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? value,
    String originalPassword,
  ) {
    if (value == null || value.isEmpty) {
      return 'Please retype your password to confirm.';
    }
    if (value != originalPassword) {
      return 'Passwords do not match. Please verify parameters.';
    }
    return null;
  }

  static String? validateNida(String? value) {
    if (value == null || value.trim().isEmpty) {
      return UiStrings.hintNidaNumber;
    }
    final cleanValue = value.trim();
    final nidaRegex = RegExp(r'^\d{20}$');
    if (!nidaRegex.hasMatch(cleanValue)) {
      return 'NIDA number must contain exactly 20 digits.';
    }
    return null;
  }

  static String? validateOtp(String? value, {int requiredLength = 6}) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter the verification code.';
    }
    final cleanValue = value.trim();
    if (cleanValue.length != requiredLength ||
        int.tryParse(cleanValue) == null) {
      return 'Verification code must be a $requiredLength-digit number.';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email address cannot be empty.';
    }
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  /// ==========================================
  /// 2. DIGITAL WALLET & TRANSACTION VALIDATORS
  /// ==========================================

  // 🎯 REFACTORED: Cleaned up the minimum amount validation logic
  static String? validateAmount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please specify an amount.';
    }

    final sanitized = value.replaceAll(',', '').trim();
    final numAmount = double.tryParse(sanitized);

    if (numAmount == null) {
      return 'Please enter a valid numeric value.';
    }

    // Set a logical minimum limit for top-ups (e.g. 1000 TSh) to prevent micro-transaction spam
    if (numAmount < 1000) {
      return 'The minimum transaction amount is 1,000 TSh.';
    }

    return null;
  }

  static String? validateMaxWalletAction(String? value, double maxLimit) {
    final basicCheck = validateAmount(value);
    if (basicCheck != null) return basicCheck;

    final sanitized = value!.replaceAll(',', '').trim();
    final numAmount = double.parse(sanitized);

    if (numAmount > maxLimit) {
      return 'Amount exceeds your single transaction threshold limits.';
    }
    return null;
  }

  static String? validateSecureTransactionPin(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Wallet transaction PIN is required.';
    }
    final cleanValue = value.trim();
    if (cleanValue.length != 4 || int.tryParse(cleanValue) == null) {
      return 'PIN must be exactly 4 digits.';
    }
    final sequentialRegex = RegExp(r'^(0123|1234|2345|3456|4567|5678|6789)$');
    final identicalRegex = RegExp(r'^(\d)\1{3}$');
    if (sequentialRegex.hasMatch(cleanValue) ||
        identicalRegex.hasMatch(cleanValue)) {
      return 'For security, avoid sequential or identical digits.';
    }
    return null;
  }

  /// ==========================================
  /// 3. BOOKING CATALOG & SCHEDULING VALIDATORS
  /// ==========================================
  static String? validateBookingInstructions(
    String? value, {
    int maxChars = 250,
  }) {
    if (value == null || value.trim().isEmpty) return null;
    if (value.trim().length > maxChars) {
      return 'Instructions cannot exceed $maxChars characters.';
    }
    return null;
  }

  static String? validateBookingDate(DateTime? selectedDate) {
    if (selectedDate == null) return 'Please choose a preferred service date.';
    final systemToday = DateTime.now();
    final structuralToday = DateTime(
      systemToday.year,
      systemToday.month,
      systemToday.day,
    );
    if (selectedDate.isBefore(structuralToday)) {
      return 'Booking dates cannot point to a past date.';
    }
    return null;
  }

  static String? validateBookingTime(
    TimeOfDay? selectedTime,
    DateTime? selectedDate,
  ) {
    if (selectedTime == null) {
      return 'Please choose a preferred service arrival time.';
    }
    if (selectedDate == null) return null;

    final currentMoment = DateTime.now();
    final targetedMoment = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    if (targetedMoment.isBefore(
      currentMoment.add(const Duration(minutes: 30)),
    )) {
      return 'Arrival slots must be scheduled at least 30 minutes in advance.';
    }
    return null;
  }

  /// ==========================================
  /// 4. GENERAL PURPOSE SYSTEM UTILITY FIELDS
  /// ==========================================
  static String? validateRequiredField(
    String? value,
    String customErrorMessage,
  ) {
    if (value == null || value.trim().isEmpty) return customErrorMessage;
    return null;
  }

  static String? validateReviewComment(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please write a brief comment regarding your experience.';
    }
    if (value.trim().length < 10) {
      return 'Your feedback must contain at least 10 characters.';
    }
    return null;
  }
}
