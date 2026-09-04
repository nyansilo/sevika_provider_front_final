enum BookingStatus {
  pending, // New incoming lead
  accepted, // Provider accepted (Instant)
  confirmed, // Provider claimed (Emergency)
  enRoute, // Provider traveling to location
  ongoing, // Provider working (in_progress)
  completed, // Job done
  cancelled, // Job cancelled
  awaitingEstimate, // Waiting for provider bid
  quoteProvided, // Provider bid submitted
  pendingPayment; // Post-job billing for cash collection

  static BookingStatus fromString(String value) {
    switch (value.toLowerCase().replaceAll(' ', '')) {
      case 'pending':
        return BookingStatus.pending;
      case 'accepted':
        return BookingStatus.accepted;
      case 'en_route':
      case 'enroute':
        return BookingStatus.enRoute;
      case 'in_progress':
      case 'ongoing':
      case 'processing':
        return BookingStatus.ongoing;
      case 'pending_payment':
        return BookingStatus.pendingPayment;
      case 'confirmed':
        return BookingStatus.confirmed;
      case 'completed':
        return BookingStatus.completed;
      case 'cancelled':
      case 'failed':
        return BookingStatus.cancelled;
      case 'awaiting_estimate':
        return BookingStatus.awaitingEstimate;
      case 'quote_provided':
        return BookingStatus.quoteProvided;
      default:
        return BookingStatus.pending;
    }
  }
}
