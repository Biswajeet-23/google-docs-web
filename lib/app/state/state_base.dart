import 'package:equatable/equatable.dart';
import 'package:google_docs_web/models/models.dart';

class StateBase extends Equatable {
  final AppError? error;

  const StateBase({this.error});

  @override
  List<Object?> get props => [error];
}