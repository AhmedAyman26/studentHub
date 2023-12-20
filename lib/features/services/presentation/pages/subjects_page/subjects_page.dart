import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/app_injector.dart';
import 'package:graduation/features/services/presentation/pages/add_service_page/add_service.dart';
import 'package:graduation/features/services/presentation/pages/subjects_page/subjects_cubit.dart';
import 'package:graduation/features/services/presentation/pages/subjects_page/subjects_state.dart';
import 'package:graduation/features/services/presentation/pages/subjects_page/widgets/subject_card_widget.dart';
import 'package:graduation/shared/constants.dart';
import 'package:graduation/shared/cubits/user_cubit/user_cubit.dart';

class SubjectsPage extends StatelessWidget {
  const SubjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubjectsCubit(injector()),
      child: const SubjectPageBody(),
    );
  }
}

class SubjectPageBody extends StatefulWidget {
  const SubjectPageBody({super.key});

  @override
  State<SubjectPageBody> createState() => _SubjectPageBodyState();
}

class _SubjectPageBodyState extends State<SubjectPageBody> {
  @override
  void initState() {
    print("%%%%${UserCubit.get(context).state.userData}");
    final facultyId = UserCubit.get(context).state.userData?.facultyId;
    SubjectsCubit.get(context).getSubjects(facultyId ?? 0);
    super.initState();
  }

  Color green = const Color.fromRGBO(70, 121, 112, 1.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SubjectsCubit, SubjectsState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.subjects?.length ?? 0,
                  itemBuilder: (context, index) {
                    return SubjectCardWidget(
                        subjectName: state.subjects?[index].subjectName ?? '');
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          heroTag: 'btn',
          child: const Icon(Icons.add),
          onPressed: () {
            navigateTo(context, const AddServicePage());
          }),
    );
  }
}
