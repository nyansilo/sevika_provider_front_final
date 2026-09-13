// import 'package:equatable/equatable.dart';

// class GetServiceCategoriesParams extends Equatable {
//   final bool? onlyActive;

//   const GetServiceCategoriesParams({this.onlyActive = true});

//   Map<String, dynamic> toQueryParameters() {
//     return {if (onlyActive != null) 'onlyActive': onlyActive.toString()};
//   }

//   @override
//   List<Object?> get props => [onlyActive];
// }

import 'package:equatable/equatable.dart';

class GetServiceCategoriesParams extends Equatable {
  final bool? onlyActive;
  final bool? isEmergencyOnly; // 🎯 Added optional parameter

  const GetServiceCategoriesParams({
    this.onlyActive = true,
    this.isEmergencyOnly,
  });

  Map<String, dynamic> toQueryParameters() {
    final queryParams = <String, dynamic>{};

    if (onlyActive != null) {
      queryParams['onlyActive'] = onlyActive.toString();
    }

    // 🎯 Pass this to Laravel as an integer string (1 or 0)
    if (isEmergencyOnly != null) {
      queryParams['is_emergency'] = isEmergencyOnly! ? '1' : '0';
    }

    return queryParams;
  }

  @override
  List<Object?> get props => [onlyActive, isEmergencyOnly];
}
