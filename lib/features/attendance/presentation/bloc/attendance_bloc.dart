import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/check_in_usecase.dart';
import '../../domain/usecases/check_out_usecase.dart';
import '../../domain/usecases/get_attendances_usecase.dart';
import 'attendance_event.dart';
import 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final GetAttendancesUseCase getAttendancesUseCase;
  final CheckInUseCase checkInUseCase;
  final CheckOutUseCase checkOutUseCase;

  AttendanceBloc({
    required this.getAttendancesUseCase,
    required this.checkInUseCase,
    required this.checkOutUseCase,
  }) : super(const AttendanceInitial()) {
    on<GetAttendancesEvent>(_onGetAttendances);
    on<CheckInEvent>(_onCheckIn);
    on<CheckOutEvent>(_onCheckOut);
  }

  Future<void> _onGetAttendances(
    GetAttendancesEvent event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(const AttendanceLoading());
    final result = await getAttendancesUseCase(
      GetAttendancesParams(
        employeeId: event.employeeId,
        startDate: event.startDate,
        endDate: event.endDate,
      ),
    );
    result.fold(
      (failure) => emit(AttendanceError(failure.message)),
      (attendances) => emit(AttendancesLoaded(attendances)),
    );
  }

  Future<void> _onCheckIn(
    CheckInEvent event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(const AttendanceLoading());
    final result = await checkInUseCase(
      CheckInParams(
        employeeId: event.employeeId,
        time: event.time,
        notes: event.notes,
      ),
    );
    result.fold(
      (failure) => emit(AttendanceError(failure.message)),
      (attendance) => emit(
        AttendanceActionSuccess(
          attendance: attendance,
          message: 'Check-in successful',
        ),
      ),
    );
  }

  Future<void> _onCheckOut(
    CheckOutEvent event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(const AttendanceLoading());
    final result = await checkOutUseCase(
      CheckOutParams(
        attendanceId: event.attendanceId,
        time: event.time,
        notes: event.notes,
      ),
    );
    result.fold(
      (failure) => emit(AttendanceError(failure.message)),
      (attendance) => emit(
        AttendanceActionSuccess(
          attendance: attendance,
          message: 'Check-out successful',
        ),
      ),
    );
  }
}
