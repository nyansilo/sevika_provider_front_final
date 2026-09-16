class ProviderStatusState {
  final bool isLoading;
  final bool isOnline;
  final String? error;

  ProviderStatusState({
    this.isLoading = false,
    this.isOnline = false,
    this.error,
  });
}
