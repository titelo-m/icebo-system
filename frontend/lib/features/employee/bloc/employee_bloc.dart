import 'package:flutter_bloc/flutter_bloc.dart';
import 'employee_event.dart';
import 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(EmployeeInitial()) {
    on<LoadJobs>((event, emit) async {
      emit(EmployeeLoading());
      await Future.delayed(const Duration(seconds: 1));

      final jobs = [
        {
          'id': 'JOB-001',
          'service': 'Laundry - Wash, Dry & Fold',
          'customer': 'Titelo Mokoena',
          'date': '24 Oct 2026',
          'time': '09:00 AM',
          'address': '42 Langa Crescent, Emalahleni',
          'status': 'Scheduled',
          'notes': 'Please use the back gate.',
        },
        {
          'id': 'JOB-002',
          'service': 'Couch Deep Clean',
          'customer': 'Sipho Dlamini',
          'date': '25 Oct 2026',
          'time': '11:00 AM',
          'address': '12 Main Street, Witbank',
          'status': 'In Progress',
          'notes': '3-seater couch in the lounge.',
        },
        {
          'id': 'JOB-003',
          'service': 'Mattress Deep Cleaning',
          'customer': 'Nomsa Nkosi',
          'date': '26 Oct 2026',
          'time': '02:00 PM',
          'address': '8 Church Street, Emalahleni',
          'status': 'Completed',
          'notes': 'Queen bed. Customer is at home.',
        },
      ];

      emit(EmployeeJobsLoaded(jobs: jobs));
    });

    on<UpdateJobStatus>((event, emit) async {
      if (state is EmployeeJobsLoaded) {
        final currentState = state as EmployeeJobsLoaded;
        final updatedJobs = currentState.jobs.map((job) {
          if (job['id'] == event.jobId) {
            return {...job, 'status': event.newStatus};
          }
          return job;
        }).toList();

        emit(EmployeeJobsLoaded(jobs: updatedJobs));
      }
    });
  }
}