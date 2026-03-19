import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dashboard_summary_entity.dart';
import '../repositories/dashboard_repository.dart';

class GetDashboardSummaryUseCase
    extends UseCaseNoParams<DashboardSummaryEntity> {
  final DashboardRepository repository;

  GetDashboardSummaryUseCase(this.repository);

  @override
  Future<Either<Failure, DashboardSummaryEntity>> call() {
    return repository.getDashboardSummary();
  }
}
