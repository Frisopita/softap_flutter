
import 'package:test_softap/softap_screen/softap_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_softap/softap_screen/softap_event.dart';


class SoftApBloc extends Bloc<SoftApEvent,SoftApState> {
  SoftApBloc() : super(SoftApStateLoaded());

  
  Stream<SoftApState> mapEventToState(event) async* {
    if (event is SoftApEventStart){
        yield* _mapStartToState();
      }
    }
    Stream<SoftApState> _mapStartToState() async* {

    }
}

