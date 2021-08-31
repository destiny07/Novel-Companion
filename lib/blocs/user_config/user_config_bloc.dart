import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_lyca/models/models.dart';

part 'user_config_event.dart';
part 'user_config_state.dart';

class UserConfigBloc extends Bloc<UserConfigEvent, UserConfigState> {

  UserConfigBloc() : super(const UserConfigState.initial());

  @override
  Stream<UserConfigState> mapEventToState(UserConfigEvent event) {
    throw UnimplementedError();
  }
  
}