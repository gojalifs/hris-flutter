import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/date_formatter.dart';
import '../bloc/attendance_bloc.dart';
import '../bloc/attendance_event.dart';
import '../bloc/attendance_state.dart';

class AttendancePage extends StatelessWidget {
  final String employeeId;

  const AttendancePage({super.key, required this.employeeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance')),
      body: BlocConsumer<AttendanceBloc, AttendanceState>(
        listener: (context, state) {
          if (state is AttendanceActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context.read<AttendanceBloc>().add(
                  GetAttendancesEvent(employeeId: employeeId),
                );
          }
          if (state is AttendanceError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AttendanceLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is AttendancesLoaded) {
            return Column(
              children: [
                _CheckInOutCard(employeeId: employeeId),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.attendances.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final att = state.attendances[index];
                      return Card(
                        child: ListTile(
                          title: Text(DateFormatter.toDisplay(att.date)),
                          subtitle: Text(
                            'In: ${att.checkIn != null ? DateFormatter.toTime(att.checkIn!) : '-'}'
                            '  |  Out: ${att.checkOut != null ? DateFormatter.toTime(att.checkOut!) : '-'}',
                          ),
                          trailing: _StatusChip(status: att.status),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const Center(child: Text('No attendance data'));
        },
      ),
    );
  }
}

class _CheckInOutCard extends StatelessWidget {
  final String employeeId;

  const _CheckInOutCard({required this.employeeId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        // Find the attendance record where the employee is currently checked in
        final activeAttendance = state is AttendancesLoaded
            ? state.attendances
                .where((a) => a.isCheckedIn)
                .firstOrNull
            : null;

        return Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: activeAttendance != null
                      ? null
                      : () {
                          context.read<AttendanceBloc>().add(
                                CheckInEvent(
                                  employeeId: employeeId,
                                  time: DateTime.now(),
                                ),
                              );
                        },
                  icon: const Icon(Icons.login),
                  label: const Text('Check In'),
                ),
                ElevatedButton.icon(
                  onPressed: activeAttendance == null
                      ? null
                      : () {
                          context.read<AttendanceBloc>().add(
                                CheckOutEvent(
                                  attendanceId: activeAttendance.id,
                                  time: DateTime.now(),
                                ),
                              );
                        },
                  icon: const Icon(Icons.logout),
                  label: const Text('Check Out'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status.toLowerCase()) {
      case 'present':
        color = Colors.green;
        break;
      case 'absent':
        color = Colors.red;
        break;
      case 'late':
        color = Colors.orange;
        break;
      default:
        color = Colors.grey;
    }
    return Chip(
      label: Text(
        status,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
      backgroundColor: color,
      padding: EdgeInsets.zero,
    );
  }
}
