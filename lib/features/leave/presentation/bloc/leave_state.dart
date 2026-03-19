import 'package:equatable/equatable.dart';
import '../../domain/entities/leave_entity.dart';

abstract class LeaveState extends Equatable {
  const LeaveState();

  @override
  List<Object?> get props => [];
}

class LeaveInitial extends LeaveState {
  const LeaveInitial();
}

class LeaveLoading extends LeaveState {
  const LeaveLoading();
}

class LeavesLoaded extends LeaveState {
  final List<LeaveEntity> leaves;

  const LeavesLoaded(this.leaves);

  @override
  List<Object> get props => [leaves];
}

class LeaveApplied extends LeaveState {
  final LeaveEntity leave;

  const LeaveApplied(this.leave);

  @override
  List<Object> get props => [leave];
}

class LeaveError extends LeaveState {
  final String message;

  const LeaveError(this.message);

  @override
  List<Object> get props => [message];
}
