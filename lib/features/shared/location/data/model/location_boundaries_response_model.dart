import 'region_model.dart';
import 'district_model.dart';

class LocationBoundariesResponseModel {
  final List<RegionModel> regions;
  final List<DistrictModel> districts;
  final bool success;

  LocationBoundariesResponseModel({
    required this.regions,
    required this.districts,
    required this.success,
  });

  factory LocationBoundariesResponseModel.fromJson(Map<String, dynamic> json) {
    final bool isSuccess = json['success'] as bool? ?? true;
    final Map<String, dynamic> targetJson =
        (json['data'] is Map<String, dynamic>)
        ? json['data'] as Map<String, dynamic>
        : json;

    final List<RegionModel> regionsList = [];
    final List<DistrictModel> districtsList = [];

    final dynamic rawRegions = targetJson['regions'] ?? json['regions'];
    if (rawRegions is List) {
      for (final item in rawRegions) {
        if (item is Map<String, dynamic>) {
          regionsList.add(RegionModel.fromJson(item));
        }
      }
    }

    final dynamic rawDistricts = targetJson['districts'] ?? json['districts'];
    if (rawDistricts is List) {
      for (final item in rawDistricts) {
        if (item is Map<String, dynamic>) {
          districtsList.add(DistrictModel.fromJson(item));
        }
      }
    }

    return LocationBoundariesResponseModel(
      success: isSuccess,
      regions: regionsList,
      districts: districtsList,
    );
  }
}
