enum NotificationType {
  booking,
  payment,
  chat,
  wallet,
  job,
  auth,
  emergency, // 🚨 ADDED
  waitlist, // 📈 RESTORED FOR PROVIDER DEMAND ALERTS
  system;

  static NotificationType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'booking':
      case 'order':
      case 'bookingconfirmed':
      case 'bookingcancelled':
      case 'reviewreminder':
        return NotificationType.booking;
      case 'payment':
      case 'transaction':
      case 'paymentsuccessful':
        return NotificationType.payment;
      case 'chat':
      case 'message':
      case 'newmessage':
      case 'chatmessagenotification':
        return NotificationType.chat;
      case 'wallet':
      case 'walletstatus':
      case 'refund':
      case 'escrow_release':
      case 'withdrawal_update':
        return NotificationType.wallet;
      case 'job':
      case 'bid':
        return NotificationType.job;
      case 'waitlist': // 📈 RESTORED
      case 'demand':
        return NotificationType.waitlist;
      case 'auth':
      case 'security':
        return NotificationType.auth;
      // 🚨 ADDED NEW EMERGENCY ROUTING
      case 'emergency':
      case 'emergency_broadcast':
      case 'emergency_cancelled':
        return NotificationType.emergency;
      case 'system':
      case 'alert':
      default:
        return NotificationType.system;
    }
  }
}
