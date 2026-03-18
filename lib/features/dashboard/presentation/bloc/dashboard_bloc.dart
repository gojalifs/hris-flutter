import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_dashboard_summary_usecase.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetDashboardSummaryUseCase getDashboardSummaryUseCase;

  DashboardBloc({required this.getDashboardSummaryUseCase})
      : super(const DashboardInitial()) {
    on<LoadDashboardEvent>(_onLoad);
  }

  Future<void> _onLoad(
    LoadDashboardEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(const DashboardLoading());
    final result = await getDashboardSummaryUseCase();
    result.fold(
      (failure) => emit(DashboardError(failure.message)),
      (summary) => emit(DashboardLoaded(summary)),
    );
  }
}
