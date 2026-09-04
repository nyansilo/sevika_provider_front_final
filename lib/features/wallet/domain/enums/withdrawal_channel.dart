/// 🏦 WITHDRAWAL CHANNELS
enum WithdrawalChannel {
  mPesa('m_pesa', 'M-Pesa'),
  tigoPesa('tigo_pesa', 'Tigo Pesa'),
  airtelMoney('airtel_money', 'Airtel Money'),
  haloPesa('halo_pesa', 'Halo Pesa'),
  crdb('crdb', 'CRDB Bank'),
  nmb('nmb', 'NMB Bank');

  final String code;
  final String displayName;

  const WithdrawalChannel(this.code, this.displayName);

  static WithdrawalChannel fromCode(String code) {
    return WithdrawalChannel.values.firstWhere(
      (e) => e.code == code,
      orElse: () => WithdrawalChannel.mPesa,
    );
  }
}
