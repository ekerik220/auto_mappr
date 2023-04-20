import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezed_example.freezed.dart';
part 'freezed_example.g.dart';

@freezed
class UserInfoUnion with _$UserInfoUnion {
  factory UserInfoUnion({
    required String email,
    required String loginIdentifier,
    required DateTime updatedAt,
    @Default(0) int primarySectionId,
    int? id,
  }) = UserInfo;
}

class UserInfoCompanion {
  final String email;
  final String loginIdentifier;
  final DateTime updatedAt;

  UserInfoCompanion({
    required this.email,
    required this.loginIdentifier,
    required this.updatedAt,
  });
}

@AutoMappr([
  MapType<UserInfo, UserInfoCompanion>(),
])
class Mappr extends $Mappr {}
