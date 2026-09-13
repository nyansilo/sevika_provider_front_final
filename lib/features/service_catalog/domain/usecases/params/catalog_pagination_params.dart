class CatalogPaginationParams {
  final int page;
  final int perPage;

  CatalogPaginationParams({this.page = 1, this.perPage = 15});

  Map<String, dynamic> toQueryParameters() => {
    "page": page,
    "perPage": perPage,
  };
}
