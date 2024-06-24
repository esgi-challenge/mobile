import 'package:mobile/core/models/information.dart';

enum InformationStatus { initial, loading, success, error }

class InformationState {
  final InformationStatus status;
  final List<Information>? informations;

  InformationState(
      {this.status = InformationStatus.loading, this.informations});
}
