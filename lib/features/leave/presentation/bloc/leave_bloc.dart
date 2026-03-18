import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/apply_leave_usecase.dart';
import '../../domain/usecases/get_leaves_usecase.dart';
import 'leave_event.dart';
import 'leave_state.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  final GetLeavesUseCase getLeavesUseCase;
  final ApplyLeaveUseCase applyLeaveUseCase;

  LeaveBloc({
    required this.getLeavesUseCase,
    required this.applyLeaveUseCase,
  }) : super(const LeaveInitial()) {
    on<GetLeavesEvent>(_onGetLeaves);
    on<ApplyLeaveEvent>(_onApplyLeave);
  }

  Future<void> _onGetLeaves(
    GetLeavesEvent event,
    Emitter<LeaveState> emit,
  ) async {
    emit(const LeaveLoading());
    final result = await getLeavesUseCase(
      GetLeavesParams(employeeId: event.employeeId, status: event.status),
    );
    result.fold(
      (failure) => emit(LeaveError(failure.message)),
      (leaves) => emit(LeavesLoaded(leaves)),
    );
  }

  Future<void> _onApplyLeave(
    ApplyLeaveEvent event,
    Emitter<LeaveState> emit,
  ) async {
    emit(const LeaveLoading());
    final result = await applyLeaveUseCase(
      ApplyLeaveParams(
        employeeId: event.employeeId,
        leaveType: event.leaveType,
        startDate: event.startDate,
        endDate: event.endDate,
        reason: event.reason,
      ),
    );
    result.fold(
      (failure) => emit(LeaveError(failure.message)),
      (leave) => emit(LeaveApplied(leave)),
    );
  }
}
