import 'package:flutter/material.dart';

class SelfServiceModel {
  final String? firstName;
  final String? lastName;

  const SelfServiceModel({
    this.firstName,
    this.lastName,
  });

  SelfServiceModel copyWith({
    ValueGetter<String?>? firstName,
    ValueGetter<String?>? lastName,
  }) {
    return SelfServiceModel(
      firstName: firstName != null ? firstName() : this.firstName,
      lastName: lastName != null ? lastName() : this.lastName,
    );
  }

  SelfServiceModel clear() {
    return copyWith(firstName: () => null, lastName: () => null);
  }

  @override
  String toString() {
    return 'SelfServiceModel{firstName: $firstName, lastName: $lastName}';
  }
}
