import 'package:bloc/bloc.dart';
import 'package:graduation/features/services/presentation/pages/add_service_page/pages/add_service_state.dart';

class AddServiceCubit extends Cubit<AddServiceState>
{
  AddServiceCubit():super(AddServiceState());
}