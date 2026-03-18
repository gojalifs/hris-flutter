import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/date_formatter.dart';
import '../bloc/leave_bloc.dart';
import '../bloc/leave_event.dart';
import '../bloc/leave_state.dart';

class LeavePage extends StatefulWidget {
  final String employeeId;

  const LeavePage({super.key, required this.employeeId});

  @override
  State<LeavePage> createState() => _LeavePageState();
}

class _LeavePageState extends State<LeavePage> {
  @override
  void initState() {
    super.initState();
    context.read<LeaveBloc>().add(
          GetLeavesEvent(employeeId: widget.employeeId),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Leaves')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showApplyLeaveBottomSheet(context),
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<LeaveBloc, LeaveState>(
        listener: (context, state) {
          if (state is LeaveApplied) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Leave applied successfully')),
            );
            context
                .read<LeaveBloc>()
                .add(GetLeavesEvent(employeeId: widget.employeeId));
          }
          if (state is LeaveError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is LeaveLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is LeavesLoaded) {
            if (state.leaves.isEmpty) {
              return const Center(child: Text('No leave requests'));
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.leaves.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final leave = state.leaves[index];
                return Card(
                  child: ListTile(
                    title: Text(leave.leaveType),
                    subtitle: Text(
                      '${DateFormatter.toDisplay(leave.startDate)} – ${DateFormatter.toDisplay(leave.endDate)}'
                      '\n${leave.durationDays} day(s)',
                    ),
                    trailing: _LeaveStatusChip(status: leave.status),
                    isThreeLine: true,
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _showApplyLeaveBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: context.read<LeaveBloc>(),
        child: _ApplyLeaveForm(employeeId: widget.employeeId),
      ),
    );
  }
}

class _ApplyLeaveForm extends StatefulWidget {
  final String employeeId;

  const _ApplyLeaveForm({required this.employeeId});

  @override
  State<_ApplyLeaveForm> createState() => _ApplyLeaveFormState();
}

class _ApplyLeaveFormState extends State<_ApplyLeaveForm> {
  final _formKey = GlobalKey<FormState>();
  final _reasonController = TextEditingController();
  String _leaveType = 'Annual Leave';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 1));

  static const _leaveTypes = [
    'Annual Leave',
    'Sick Leave',
    'Emergency Leave',
    'Unpaid Leave',
  ];

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Apply Leave',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _leaveType,
              items: _leaveTypes
                  .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                  .toList(),
              onChanged: (v) => setState(() => _leaveType = v ?? _leaveType),
              decoration: const InputDecoration(labelText: 'Leave Type'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _startDate,
                        firstDate: DateTime.now(),
                        lastDate:
                            DateTime.now().add(const Duration(days: 365)),
                      );
                      if (picked != null) {
                        setState(() => _startDate = picked);
                      }
                    },
                    icon: const Icon(Icons.calendar_today),
                    label: Text(DateFormatter.toDisplay(_startDate)),
                  ),
                ),
                const Text('–'),
                Expanded(
                  child: TextButton.icon(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _endDate,
                        firstDate: _startDate,
                        lastDate:
                            DateTime.now().add(const Duration(days: 365)),
                      );
                      if (picked != null) {
                        setState(() => _endDate = picked);
                      }
                    },
                    icon: const Icon(Icons.calendar_today),
                    label: Text(DateFormatter.toDisplay(_endDate)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _reasonController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Reason'),
              validator: (v) =>
                  v == null || v.isEmpty ? 'Please enter a reason' : null,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  context.read<LeaveBloc>().add(
                        ApplyLeaveEvent(
                          employeeId: widget.employeeId,
                          leaveType: _leaveType,
                          startDate: _startDate,
                          endDate: _endDate,
                          reason: _reasonController.text,
                        ),
                      );
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class _LeaveStatusChip extends StatelessWidget {
  final String status;

  const _LeaveStatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status.toLowerCase()) {
      case 'approved':
        color = Colors.green;
        break;
      case 'rejected':
        color = Colors.red;
        break;
      case 'pending':
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
