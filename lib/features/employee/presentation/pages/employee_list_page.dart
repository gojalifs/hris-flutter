import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/employee_bloc.dart';
import '../bloc/employee_event.dart';
import '../bloc/employee_state.dart';
import '../../domain/entities/employee_entity.dart';

class EmployeeListPage extends StatefulWidget {
  const EmployeeListPage({super.key});

  @override
  State<EmployeeListPage> createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<EmployeeBloc>().add(const GetEmployeesEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Employees')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search employees...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                          context
                              .read<EmployeeBloc>()
                              .add(const GetEmployeesEvent());
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() {});
                context
                    .read<EmployeeBloc>()
                    .add(GetEmployeesEvent(search: value));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<EmployeeBloc, EmployeeState>(
              builder: (context, state) {
                if (state is EmployeeLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is EmployeeError) {
                  return Center(child: Text(state.message));
                }
                if (state is EmployeesLoaded) {
                  if (state.employees.isEmpty) {
                    return const Center(child: Text('No employees found'));
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: state.employees.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final employee = state.employees[index];
                      return _EmployeeCard(employee: employee);
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _EmployeeCard extends StatelessWidget {
  final EmployeeEntity employee;

  const _EmployeeCard({required this.employee});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage:
              employee.avatar != null ? NetworkImage(employee.avatar!) : null,
          child: employee.avatar == null
              ? Text(employee.name[0].toUpperCase())
              : null,
        ),
        title: Text(employee.name),
        subtitle: Text('${employee.department} · ${employee.position}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          context
              .read<EmployeeBloc>()
              .add(GetEmployeeEvent(id: employee.id));
        },
      ),
    );
  }
}
