import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_sw.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'arb/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('sw'),
    Locale('zh'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Sevika'**
  String get appName;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @wishList.
  ///
  /// In en, this message translates to:
  /// **'Wishlist'**
  String get wishList;

  /// A greeting message with the user's name
  ///
  /// In en, this message translates to:
  /// **'Welcome back, {name}!'**
  String greeting(String name);

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get message;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @dynamicTheme.
  ///
  /// In en, this message translates to:
  /// **'System Theme'**
  String get dynamicTheme;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUs;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search ...'**
  String get search;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @inputYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Input your password'**
  String get inputYourPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @inputName.
  ///
  /// In en, this message translates to:
  /// **'Input your name'**
  String get inputName;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @inputEmail.
  ///
  /// In en, this message translates to:
  /// **'Input your email'**
  String get inputEmail;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @inputPhone.
  ///
  /// In en, this message translates to:
  /// **'Input your phone'**
  String get inputPhone;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @inputAddress.
  ///
  /// In en, this message translates to:
  /// **'Input your address'**
  String get inputAddress;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @area.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get area;

  /// No description provided for @selectLocation.
  ///
  /// In en, this message translates to:
  /// **'Select Location'**
  String get selectLocation;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @review.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get review;

  /// No description provided for @write.
  ///
  /// In en, this message translates to:
  /// **'Write'**
  String get write;

  /// No description provided for @feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// No description provided for @tapRate.
  ///
  /// In en, this message translates to:
  /// **'Tap a star to rate'**
  String get tapRate;

  /// No description provided for @shopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get shopping;

  /// No description provided for @bookingFailMessage.
  ///
  /// In en, this message translates to:
  /// **'Booking request failed'**
  String get bookingFailMessage;

  /// No description provided for @latest.
  ///
  /// In en, this message translates to:
  /// **'Latest'**
  String get latest;

  /// No description provided for @featured.
  ///
  /// In en, this message translates to:
  /// **'Featured'**
  String get featured;

  /// No description provided for @discoverMore.
  ///
  /// In en, this message translates to:
  /// **'Discover More'**
  String get discoverMore;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get setting;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @loadingMore.
  ///
  /// In en, this message translates to:
  /// **'Loading more...'**
  String get loadingMore;

  /// No description provided for @noMoreData.
  ///
  /// In en, this message translates to:
  /// **'No more data'**
  String get noMoreData;

  /// No description provided for @searching.
  ///
  /// In en, this message translates to:
  /// **'Searching...'**
  String get searching;

  /// No description provided for @noResultsFound.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResultsFound;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @info.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get info;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @noConnection.
  ///
  /// In en, this message translates to:
  /// **'No connection'**
  String get noConnection;

  /// No description provided for @connected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get connected;

  /// No description provided for @disconnected.
  ///
  /// In en, this message translates to:
  /// **'Disconnected'**
  String get disconnected;

  /// No description provided for @listing.
  ///
  /// In en, this message translates to:
  /// **'Listing'**
  String get listing;

  /// No description provided for @addNewListing.
  ///
  /// In en, this message translates to:
  /// **'Add New Listing'**
  String get addNewListing;

  /// No description provided for @updateListing.
  ///
  /// In en, this message translates to:
  /// **'Update Listing'**
  String get updateListing;

  /// No description provided for @claimListing.
  ///
  /// In en, this message translates to:
  /// **'Claim Listing'**
  String get claimListing;

  /// No description provided for @claimManagement.
  ///
  /// In en, this message translates to:
  /// **'Claim Management'**
  String get claimManagement;

  /// No description provided for @claimSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Claim Submitted Successfully'**
  String get claimSuccessTitle;

  /// No description provided for @claimSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Your claim has been submitted. It will appear once approved by an admin.'**
  String get claimSuccessMessage;

  /// No description provided for @claimList.
  ///
  /// In en, this message translates to:
  /// **'Claim List'**
  String get claimList;

  /// No description provided for @claimDetail.
  ///
  /// In en, this message translates to:
  /// **'Claim Details'**
  String get claimDetail;

  /// No description provided for @claimRequestMsg.
  ///
  /// In en, this message translates to:
  /// **'Your claim request is being processed. Please wait for admin approval.'**
  String get claimRequestMsg;

  /// No description provided for @bookings.
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get bookings;

  /// No description provided for @myBooking.
  ///
  /// In en, this message translates to:
  /// **'My Bookings'**
  String get myBooking;

  /// No description provided for @requestBooking.
  ///
  /// In en, this message translates to:
  /// **'Request Booking'**
  String get requestBooking;

  /// No description provided for @bookingManagement.
  ///
  /// In en, this message translates to:
  /// **'Booking Management'**
  String get bookingManagement;

  /// No description provided for @bookingStyle.
  ///
  /// In en, this message translates to:
  /// **'Booking Style'**
  String get bookingStyle;

  /// No description provided for @bookingDetail.
  ///
  /// In en, this message translates to:
  /// **'Booking Details'**
  String get bookingDetail;

  /// No description provided for @bookingId.
  ///
  /// In en, this message translates to:
  /// **'Booking ID'**
  String get bookingId;

  /// No description provided for @bookingPrice.
  ///
  /// In en, this message translates to:
  /// **'Booking Price'**
  String get bookingPrice;

  /// No description provided for @totalPrice.
  ///
  /// In en, this message translates to:
  /// **'Total Price'**
  String get totalPrice;

  /// No description provided for @bookNow.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get bookNow;

  /// No description provided for @bookingSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking Successful'**
  String get bookingSuccessTitle;

  /// No description provided for @bookingSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Your booking request has been submitted successfully.'**
  String get bookingSuccessMessage;

  /// No description provided for @openTime.
  ///
  /// In en, this message translates to:
  /// **'Opening Hours'**
  String get openTime;

  /// No description provided for @startHour.
  ///
  /// In en, this message translates to:
  /// **'Start Hour'**
  String get startHour;

  /// No description provided for @endHour.
  ///
  /// In en, this message translates to:
  /// **'End Hour'**
  String get endHour;

  /// No description provided for @startTime.
  ///
  /// In en, this message translates to:
  /// **'Start Time'**
  String get startTime;

  /// No description provided for @endTime.
  ///
  /// In en, this message translates to:
  /// **'End Time'**
  String get endTime;

  /// No description provided for @priceMin.
  ///
  /// In en, this message translates to:
  /// **'Minimum Price'**
  String get priceMin;

  /// No description provided for @priceMax.
  ///
  /// In en, this message translates to:
  /// **'Maximum Price'**
  String get priceMax;

  /// No description provided for @priceRange.
  ///
  /// In en, this message translates to:
  /// **'Price Range'**
  String get priceRange;

  /// No description provided for @avgPrice.
  ///
  /// In en, this message translates to:
  /// **'Average Price'**
  String get avgPrice;

  /// No description provided for @hourly.
  ///
  /// In en, this message translates to:
  /// **'Hourly'**
  String get hourly;

  /// No description provided for @daily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get daily;

  /// No description provided for @slot.
  ///
  /// In en, this message translates to:
  /// **'Time Slot'**
  String get slot;

  /// No description provided for @facilities.
  ///
  /// In en, this message translates to:
  /// **'Facilities & Services'**
  String get facilities;

  /// No description provided for @chooseFacilities.
  ///
  /// In en, this message translates to:
  /// **'Select Facilities'**
  String get chooseFacilities;

  /// No description provided for @facilitiesRequire.
  ///
  /// In en, this message translates to:
  /// **'Facilities selection is required'**
  String get facilitiesRequire;

  /// No description provided for @featureImageRequire.
  ///
  /// In en, this message translates to:
  /// **'Featured image is required'**
  String get featureImageRequire;

  /// No description provided for @galleryImageRequire.
  ///
  /// In en, this message translates to:
  /// **'Gallery image is required'**
  String get galleryImageRequire;

  /// No description provided for @uploadFeatureImage.
  ///
  /// In en, this message translates to:
  /// **'Upload Featured Image'**
  String get uploadFeatureImage;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @galleriesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No gallery images uploaded'**
  String get galleriesEmpty;

  /// No description provided for @chooseCategory.
  ///
  /// In en, this message translates to:
  /// **'Select Category'**
  String get chooseCategory;

  /// No description provided for @categoryRequire.
  ///
  /// In en, this message translates to:
  /// **'Category selection is required'**
  String get categoryRequire;

  /// No description provided for @popularCategories.
  ///
  /// In en, this message translates to:
  /// **'Popular Categories'**
  String get popularCategories;

  /// No description provided for @popularLocation.
  ///
  /// In en, this message translates to:
  /// **'Popular Locations'**
  String get popularLocation;

  /// No description provided for @recentLocation.
  ///
  /// In en, this message translates to:
  /// **'Recent Locations'**
  String get recentLocation;

  /// No description provided for @searchLocation.
  ///
  /// In en, this message translates to:
  /// **'Search Location'**
  String get searchLocation;

  /// No description provided for @distance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get distance;

  /// No description provided for @chooseGpsLocation.
  ///
  /// In en, this message translates to:
  /// **'Select GPS Location'**
  String get chooseGpsLocation;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @paymentNotCompleted.
  ///
  /// In en, this message translates to:
  /// **'Payment Not Completed'**
  String get paymentNotCompleted;

  /// No description provided for @paymentTotal.
  ///
  /// In en, this message translates to:
  /// **'Payment Total'**
  String get paymentTotal;

  /// No description provided for @paymentInformation.
  ///
  /// In en, this message translates to:
  /// **'Payment Information'**
  String get paymentInformation;

  /// No description provided for @paymentIntro.
  ///
  /// In en, this message translates to:
  /// **'Your strategic online business partner.'**
  String get paymentIntro;

  /// No description provided for @billing.
  ///
  /// In en, this message translates to:
  /// **'Billing'**
  String get billing;

  /// No description provided for @accountName.
  ///
  /// In en, this message translates to:
  /// **'Account Name'**
  String get accountName;

  /// No description provided for @accountNumber.
  ///
  /// In en, this message translates to:
  /// **'Account Number'**
  String get accountNumber;

  /// No description provided for @iban.
  ///
  /// In en, this message translates to:
  /// **'IBAN'**
  String get iban;

  /// No description provided for @swiftCode.
  ///
  /// In en, this message translates to:
  /// **'SWIFT Code'**
  String get swiftCode;

  /// No description provided for @transactionId.
  ///
  /// In en, this message translates to:
  /// **'Transaction ID'**
  String get transactionId;

  /// No description provided for @createdOn.
  ///
  /// In en, this message translates to:
  /// **'Created On'**
  String get createdOn;

  /// No description provided for @paidOn.
  ///
  /// In en, this message translates to:
  /// **'Paid On'**
  String get paidOn;

  /// No description provided for @createdVia.
  ///
  /// In en, this message translates to:
  /// **'Created Via'**
  String get createdVia;

  /// No description provided for @postStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get postStatusCompleted;

  /// No description provided for @postStatusProcessing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get postStatusProcessing;

  /// No description provided for @postStatusCanceled.
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get postStatusCanceled;

  /// No description provided for @postStatusFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get postStatusFailed;

  /// No description provided for @postStatusRefunded.
  ///
  /// In en, this message translates to:
  /// **'Refunded'**
  String get postStatusRefunded;

  /// No description provided for @postStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get postStatusPending;

  /// No description provided for @postStatusApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get postStatusApproved;

  /// No description provided for @postStatusDecline.
  ///
  /// In en, this message translates to:
  /// **'Declined'**
  String get postStatusDecline;

  /// No description provided for @postStatusPublish.
  ///
  /// In en, this message translates to:
  /// **'Published'**
  String get postStatusPublish;

  /// No description provided for @otp.
  ///
  /// In en, this message translates to:
  /// **'OTP'**
  String get otp;

  /// No description provided for @otpVerification.
  ///
  /// In en, this message translates to:
  /// **'OTP Verification'**
  String get otpVerification;

  /// No description provided for @otpSent.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code we have sent to'**
  String get otpSent;

  /// No description provided for @beforeOtpSent.
  ///
  /// In en, this message translates to:
  /// **'6-digit code will be sent to'**
  String get beforeOtpSent;

  /// No description provided for @otpResend.
  ///
  /// In en, this message translates to:
  /// **'Resend code in '**
  String get otpResend;

  /// No description provided for @otpGet.
  ///
  /// In en, this message translates to:
  /// **'Get OTP'**
  String get otpGet;

  /// No description provided for @otpVerify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get otpVerify;

  /// No description provided for @otpInvalid.
  ///
  /// In en, this message translates to:
  /// **'OTP code is invalid, please try again.'**
  String get otpInvalid;

  /// No description provided for @authOtpRequire.
  ///
  /// In en, this message translates to:
  /// **'OTP code is required'**
  String get authOtpRequire;

  /// No description provided for @otpMessage.
  ///
  /// In en, this message translates to:
  /// **'OTP for password reset will be sent to your email at '**
  String get otpMessage;

  /// No description provided for @tokenIssueMessage.
  ///
  /// In en, this message translates to:
  /// **'Session expired. Do you want to log in again?'**
  String get tokenIssueMessage;

  /// No description provided for @deactivate.
  ///
  /// In en, this message translates to:
  /// **'Deactivate Account'**
  String get deactivate;

  /// No description provided for @wouldYouLikeDeactivate.
  ///
  /// In en, this message translates to:
  /// **'Would you like to deactivate your account? All your data will be lost.'**
  String get wouldYouLikeDeactivate;

  /// No description provided for @notice.
  ///
  /// In en, this message translates to:
  /// **'Notice'**
  String get notice;

  /// No description provided for @authResetPassword.
  ///
  /// In en, this message translates to:
  /// **'User not found. Please check your email and try again.'**
  String get authResetPassword;

  /// No description provided for @incorrectPassword.
  ///
  /// In en, this message translates to:
  /// **'The username or password is incorrect.'**
  String get incorrectPassword;

  /// No description provided for @authRegisterError.
  ///
  /// In en, this message translates to:
  /// **'Email already exists. Please use another email address.'**
  String get authRegisterError;

  /// No description provided for @registerSuccess.
  ///
  /// In en, this message translates to:
  /// **'Registered successfully.'**
  String get registerSuccess;

  /// No description provided for @saveDataSuccess.
  ///
  /// In en, this message translates to:
  /// **'Data saved successfully.'**
  String get saveDataSuccess;

  /// No description provided for @cannotMakeAction.
  ///
  /// In en, this message translates to:
  /// **'Unable to perform action on data.'**
  String get cannotMakeAction;

  /// No description provided for @userParseDataFail.
  ///
  /// In en, this message translates to:
  /// **'Failed to parse user data.'**
  String get userParseDataFail;

  /// No description provided for @valueNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Confirmation values do not match.'**
  String get valueNotMatch;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please check your network connection.'**
  String get somethingWentWrong;

  /// No description provided for @cannotConnectServer.
  ///
  /// In en, this message translates to:
  /// **'Unable to connect to the server.'**
  String get cannotConnectServer;

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'You are currently offline.'**
  String get noInternetConnection;

  /// No description provided for @internetConnected.
  ///
  /// In en, this message translates to:
  /// **'Your network connection is restored.'**
  String get internetConnected;

  /// No description provided for @outOf.
  ///
  /// In en, this message translates to:
  /// **'Out of'**
  String get outOf;

  /// No description provided for @reviewRating.
  ///
  /// In en, this message translates to:
  /// **'Review Rating'**
  String get reviewRating;

  /// No description provided for @reviewNotFound.
  ///
  /// In en, this message translates to:
  /// **'Review not found'**
  String get reviewNotFound;

  /// No description provided for @rateForUs.
  ///
  /// In en, this message translates to:
  /// **'Rate Us'**
  String get rateForUs;

  /// No description provided for @helpFeedback.
  ///
  /// In en, this message translates to:
  /// **'Help & Feedback'**
  String get helpFeedback;

  /// No description provided for @inputFacebook.
  ///
  /// In en, this message translates to:
  /// **'Facebook Link'**
  String get inputFacebook;

  /// No description provided for @inputTwitter.
  ///
  /// In en, this message translates to:
  /// **'Twitter Link'**
  String get inputTwitter;

  /// No description provided for @inputInstagram.
  ///
  /// In en, this message translates to:
  /// **'Instagram Link'**
  String get inputInstagram;

  /// No description provided for @inputLinkedin.
  ///
  /// In en, this message translates to:
  /// **'LinkedIn Link'**
  String get inputLinkedin;

  /// No description provided for @inputYoutube.
  ///
  /// In en, this message translates to:
  /// **'YouTube Link'**
  String get inputYoutube;

  /// No description provided for @inputWebsite.
  ///
  /// In en, this message translates to:
  /// **'Website URL'**
  String get inputWebsite;

  /// No description provided for @inputFax.
  ///
  /// In en, this message translates to:
  /// **'Fax Number'**
  String get inputFax;

  /// No description provided for @valueNotEmpty.
  ///
  /// In en, this message translates to:
  /// **'This field cannot be empty'**
  String get valueNotEmpty;

  /// No description provided for @valueNotValidRange.
  ///
  /// In en, this message translates to:
  /// **'Input is out of valid range'**
  String get valueNotValidRange;

  /// No description provided for @valueNotValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address'**
  String get valueNotValidEmail;

  /// No description provided for @valueNotValidPhone.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get valueNotValidPhone;

  /// No description provided for @valueNotValidPassword.
  ///
  /// In en, this message translates to:
  /// **'Invalid password format'**
  String get valueNotValidPassword;

  /// No description provided for @valueNotValidId.
  ///
  /// In en, this message translates to:
  /// **'Invalid ID format'**
  String get valueNotValidId;

  /// No description provided for @valueNotNumber.
  ///
  /// In en, this message translates to:
  /// **'Value must be a number'**
  String get valueNotNumber;

  /// No description provided for @valueNotIsTag.
  ///
  /// In en, this message translates to:
  /// **'Incorrect tag format'**
  String get valueNotIsTag;

  /// No description provided for @minValueNotValid.
  ///
  /// In en, this message translates to:
  /// **'Minimum value is not valid'**
  String get minValueNotValid;

  /// No description provided for @phoneRequire.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get phoneRequire;

  /// No description provided for @locationRequire.
  ///
  /// In en, this message translates to:
  /// **'Location is required'**
  String get locationRequire;

  /// No description provided for @countryRequire.
  ///
  /// In en, this message translates to:
  /// **'Country is required'**
  String get countryRequire;

  /// No description provided for @cityRequire.
  ///
  /// In en, this message translates to:
  /// **'City is required'**
  String get cityRequire;

  /// No description provided for @gpsRequire.
  ///
  /// In en, this message translates to:
  /// **'GPS coordinates are required'**
  String get gpsRequire;

  /// No description provided for @priceRequire.
  ///
  /// In en, this message translates to:
  /// **'Price is required'**
  String get priceRequire;

  /// No description provided for @tagsRequire.
  ///
  /// In en, this message translates to:
  /// **'Tags are required'**
  String get tagsRequire;

  /// No description provided for @iconRequire.
  ///
  /// In en, this message translates to:
  /// **'Icon is required'**
  String get iconRequire;

  /// No description provided for @domainNotCorrect.
  ///
  /// In en, this message translates to:
  /// **'Domain is incorrect'**
  String get domainNotCorrect;

  /// No description provided for @shareQrProfile.
  ///
  /// In en, this message translates to:
  /// **'Share Profile QR Code'**
  String get shareQrProfile;

  /// No description provided for @shareQrListing.
  ///
  /// In en, this message translates to:
  /// **'Share Listing QR Code'**
  String get shareQrListing;

  /// No description provided for @userLinkCopied.
  ///
  /// In en, this message translates to:
  /// **'User link copied to clipboard'**
  String get userLinkCopied;

  /// No description provided for @listingLinkCopied.
  ///
  /// In en, this message translates to:
  /// **'Listing link copied to clipboard'**
  String get listingLinkCopied;

  /// No description provided for @onboardBaseTitle.
  ///
  /// In en, this message translates to:
  /// **'Basic Listing'**
  String get onboardBaseTitle;

  /// No description provided for @onboardProfessionalTitle1.
  ///
  /// In en, this message translates to:
  /// **'Layout 1'**
  String get onboardProfessionalTitle1;

  /// No description provided for @onboardProfessionalTitle2.
  ///
  /// In en, this message translates to:
  /// **'Layout 2'**
  String get onboardProfessionalTitle2;

  /// No description provided for @onboardProfessionalTitle3.
  ///
  /// In en, this message translates to:
  /// **'Layout 3'**
  String get onboardProfessionalTitle3;

  /// No description provided for @onboardFoodTitle.
  ///
  /// In en, this message translates to:
  /// **'Food Listing'**
  String get onboardFoodTitle;

  /// No description provided for @onboardRealEstateTitle.
  ///
  /// In en, this message translates to:
  /// **'Real Estate Listing'**
  String get onboardRealEstateTitle;

  /// No description provided for @onboardEventTitle.
  ///
  /// In en, this message translates to:
  /// **'Event Listing'**
  String get onboardEventTitle;

  /// No description provided for @customColor.
  ///
  /// In en, this message translates to:
  /// **'Custom Colors'**
  String get customColor;

  /// No description provided for @primaryColor.
  ///
  /// In en, this message translates to:
  /// **'Primary Color'**
  String get primaryColor;

  /// No description provided for @secondaryColor.
  ///
  /// In en, this message translates to:
  /// **'Secondary Color'**
  String get secondaryColor;

  /// No description provided for @pullDownRefresh.
  ///
  /// In en, this message translates to:
  /// **'Pull down to refresh'**
  String get pullDownRefresh;

  /// No description provided for @releaseToRefresh.
  ///
  /// In en, this message translates to:
  /// **'Release to refresh'**
  String get releaseToRefresh;

  /// No description provided for @pullToLoadMore.
  ///
  /// In en, this message translates to:
  /// **'Pull up to load more'**
  String get pullToLoadMore;

  /// No description provided for @appNotFound.
  ///
  /// In en, this message translates to:
  /// **'Application not found'**
  String get appNotFound;

  /// No description provided for @install.
  ///
  /// In en, this message translates to:
  /// **'Install'**
  String get install;

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @appPreferences.
  ///
  /// In en, this message translates to:
  /// **'App Preferences'**
  String get appPreferences;

  /// No description provided for @pushNotificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Instant alerts on dispatch, arrivals, and deals'**
  String get pushNotificationsSubtitle;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @systemDefault.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get systemDefault;

  /// No description provided for @securityPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Security & Privacy'**
  String get securityPrivacy;

  /// No description provided for @changePasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage access keys update configuration parameters'**
  String get changePasswordSubtitle;

  /// No description provided for @biometricSecurityLock.
  ///
  /// In en, this message translates to:
  /// **'Biometric Security lock'**
  String get biometricSecurityLock;

  /// No description provided for @biometricSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock with quick biometric fingerprint access authentication'**
  String get biometricSubtitle;

  /// No description provided for @systemDataPermissions.
  ///
  /// In en, this message translates to:
  /// **'System Data Permissions'**
  String get systemDataPermissions;

  /// No description provided for @systemDataSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Control background location tracking or camera access properties'**
  String get systemDataSubtitle;

  /// No description provided for @accountActions.
  ///
  /// In en, this message translates to:
  /// **'Account Actions'**
  String get accountActions;

  /// No description provided for @signOutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Securely close active customer login context session tokens'**
  String get signOutSubtitle;

  /// No description provided for @deleteCustomerProfile.
  ///
  /// In en, this message translates to:
  /// **'Delete Customer Profile permanently'**
  String get deleteCustomerProfile;

  /// No description provided for @deleteProfileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Wipe user record tables, active ledger tokens, and data fields'**
  String get deleteProfileSubtitle;

  /// No description provided for @deleteAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Account?'**
  String get deleteAccountTitle;

  /// No description provided for @deleteAccountContent.
  ///
  /// In en, this message translates to:
  /// **'This action is irreversible. All your booking history, saved addresses, and profile data will be permanently wiped.\n\nAre you sure you want to proceed?'**
  String get deleteAccountContent;

  /// No description provided for @yesDelete.
  ///
  /// In en, this message translates to:
  /// **'Yes, Delete'**
  String get yesDelete;

  /// No description provided for @signOutContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to securely close your active profile session?'**
  String get signOutContent;

  /// No description provided for @languageChangedMsg.
  ///
  /// In en, this message translates to:
  /// **'Language updated to English'**
  String get languageChangedMsg;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'App Theme'**
  String get theme;

  /// No description provided for @appAppearance.
  ///
  /// In en, this message translates to:
  /// **'App Appearance'**
  String get appAppearance;

  /// No description provided for @themePreferences.
  ///
  /// In en, this message translates to:
  /// **'Theme Preferences'**
  String get themePreferences;

  /// No description provided for @systemDefaultSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Matches your device settings'**
  String get systemDefaultSubtitle;

  /// No description provided for @lightModeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Clean and bright'**
  String get lightModeSubtitle;

  /// No description provided for @darkModeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Easy on the eyes'**
  String get darkModeSubtitle;

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred.'**
  String get unexpectedError;

  /// No description provided for @failedToRestoreSession.
  ///
  /// In en, this message translates to:
  /// **'Failed to restore account sync context.'**
  String get failedToRestoreSession;

  /// No description provided for @retrySyncProfile.
  ///
  /// In en, this message translates to:
  /// **'Retry Synchronizing Profile'**
  String get retrySyncProfile;

  /// No description provided for @goldMember.
  ///
  /// In en, this message translates to:
  /// **'Gold Member'**
  String get goldMember;

  /// No description provided for @myActivity.
  ///
  /// In en, this message translates to:
  /// **'My Activity'**
  String get myActivity;

  /// No description provided for @allBookingHistory.
  ///
  /// In en, this message translates to:
  /// **'All Booking History'**
  String get allBookingHistory;

  /// No description provided for @serviceWaitlists.
  ///
  /// In en, this message translates to:
  /// **'Service Waitlists'**
  String get serviceWaitlists;

  /// No description provided for @bookmarkedServices.
  ///
  /// In en, this message translates to:
  /// **'Bookmarked Services'**
  String get bookmarkedServices;

  /// No description provided for @favoriteProviders.
  ///
  /// In en, this message translates to:
  /// **'Favorite Providers'**
  String get favoriteProviders;

  /// No description provided for @feedbackHistory.
  ///
  /// In en, this message translates to:
  /// **'Feedback History & Reviews'**
  String get feedbackHistory;

  /// No description provided for @billingHistory.
  ///
  /// In en, this message translates to:
  /// **'Billing History'**
  String get billingHistory;

  /// No description provided for @logisticsDetails.
  ///
  /// In en, this message translates to:
  /// **'Logistics Details'**
  String get logisticsDetails;

  /// No description provided for @manageSavedAddresses.
  ///
  /// In en, this message translates to:
  /// **'Manage Saved Addresses'**
  String get manageSavedAddresses;

  /// No description provided for @savedCardsPayments.
  ///
  /// In en, this message translates to:
  /// **'Saved Cards & Payment Methods'**
  String get savedCardsPayments;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @helpCenterChat.
  ///
  /// In en, this message translates to:
  /// **'Help Center & Chat Support'**
  String get helpCenterChat;

  /// No description provided for @safetyInsurance.
  ///
  /// In en, this message translates to:
  /// **'Ecosystem Safety & Insurance Assurance'**
  String get safetyInsurance;

  /// No description provided for @legalTerms.
  ///
  /// In en, this message translates to:
  /// **'Legal & Terms of Service'**
  String get legalTerms;

  /// No description provided for @editProfileSettings.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile Settings'**
  String get editProfileSettings;

  /// No description provided for @errorChoosingImage.
  ///
  /// In en, this message translates to:
  /// **'Error choosing image asset.'**
  String get errorChoosingImage;

  /// No description provided for @failedToUpdateProfile.
  ///
  /// In en, this message translates to:
  /// **'Failed to update profile.'**
  String get failedToUpdateProfile;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @defaultAddress.
  ///
  /// In en, this message translates to:
  /// **'Default Address'**
  String get defaultAddress;

  /// No description provided for @enterStreetAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter street address'**
  String get enterStreetAddress;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @cityHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Dar es Salaam'**
  String get cityHint;

  /// No description provided for @alternativePhone.
  ///
  /// In en, this message translates to:
  /// **'Alternative Phone'**
  String get alternativePhone;

  /// No description provided for @secondaryContactNumber.
  ///
  /// In en, this message translates to:
  /// **'Secondary contact number'**
  String get secondaryContactNumber;

  /// No description provided for @primaryPhoneLocked.
  ///
  /// In en, this message translates to:
  /// **'Primary Phone (Locked)'**
  String get primaryPhoneLocked;

  /// No description provided for @emailAddressLocked.
  ///
  /// In en, this message translates to:
  /// **'Email Address (Locked)'**
  String get emailAddressLocked;

  /// No description provided for @saveProfileChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Profile Changes'**
  String get saveProfileChanges;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get requiredField;

  /// No description provided for @addressRequired.
  ///
  /// In en, this message translates to:
  /// **'Address is required'**
  String get addressRequired;

  /// No description provided for @cityRequired.
  ///
  /// In en, this message translates to:
  /// **'City parameter required'**
  String get cityRequired;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @rewards.
  ///
  /// In en, this message translates to:
  /// **'Rewards'**
  String get rewards;

  /// No description provided for @activeStatus.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get activeStatus;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @points.
  ///
  /// In en, this message translates to:
  /// **'pts'**
  String get points;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'VIEW'**
  String get view;

  /// No description provided for @serviceCategories.
  ///
  /// In en, this message translates to:
  /// **'Service Categories'**
  String get serviceCategories;

  /// No description provided for @featuredProfessionals.
  ///
  /// In en, this message translates to:
  /// **'Featured Professionals'**
  String get featuredProfessionals;

  /// No description provided for @recommendedForYou.
  ///
  /// In en, this message translates to:
  /// **'Recommended for You'**
  String get recommendedForYou;

  /// No description provided for @popularServices.
  ///
  /// In en, this message translates to:
  /// **'Popular Services'**
  String get popularServices;

  /// No description provided for @bannersUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Banners Unavailable'**
  String get bannersUnavailable;

  /// No description provided for @checkConnectionOffers.
  ///
  /// In en, this message translates to:
  /// **'Check your connection to view latest offers.'**
  String get checkConnectionOffers;

  /// No description provided for @tanzania.
  ///
  /// In en, this message translates to:
  /// **'Tanzania'**
  String get tanzania;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @sortMostPopular.
  ///
  /// In en, this message translates to:
  /// **'Most Popular'**
  String get sortMostPopular;

  /// No description provided for @sortPriceLowHigh.
  ///
  /// In en, this message translates to:
  /// **'Price: Low to High'**
  String get sortPriceLowHigh;

  /// No description provided for @sortPriceHighLow.
  ///
  /// In en, this message translates to:
  /// **'Price: High to Low'**
  String get sortPriceHighLow;

  /// No description provided for @sortAlphabetical.
  ///
  /// In en, this message translates to:
  /// **'Alphabetical (A-Z)'**
  String get sortAlphabetical;

  /// No description provided for @searchForServices.
  ///
  /// In en, this message translates to:
  /// **'Search for services...'**
  String get searchForServices;

  /// No description provided for @categoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get categoryLabel;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @sortLabel.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sortLabel;

  /// No description provided for @typeQueryToSearch.
  ///
  /// In en, this message translates to:
  /// **'Type a query above to start searching.'**
  String get typeQueryToSearch;

  /// No description provided for @recentSearches.
  ///
  /// In en, this message translates to:
  /// **'Recent Searches'**
  String get recentSearches;

  /// No description provided for @errorLoadingItems.
  ///
  /// In en, this message translates to:
  /// **'An error occurred loading items.'**
  String get errorLoadingItems;

  /// No description provided for @noActiveServicesFound.
  ///
  /// In en, this message translates to:
  /// **'No active matching services discovered in the catalog.'**
  String get noActiveServicesFound;

  /// No description provided for @filterOptions.
  ///
  /// In en, this message translates to:
  /// **'Filter Options'**
  String get filterOptions;

  /// No description provided for @serviceCategory.
  ///
  /// In en, this message translates to:
  /// **'Service Category'**
  String get serviceCategory;

  /// No description provided for @sortResultsBy.
  ///
  /// In en, this message translates to:
  /// **'Sort Results By'**
  String get sortResultsBy;

  /// No description provided for @applyParameters.
  ///
  /// In en, this message translates to:
  /// **'Apply Parameters'**
  String get applyParameters;

  /// No description provided for @yourLocation.
  ///
  /// In en, this message translates to:
  /// **'Your Location'**
  String get yourLocation;

  /// No description provided for @searchHintPlumbers.
  ///
  /// In en, this message translates to:
  /// **'Search for cleaners, plumbers, handymen...'**
  String get searchHintPlumbers;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'sw', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'sw':
      return AppLocalizationsSw();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
