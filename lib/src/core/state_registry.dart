import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routinechecker/src/presentation/providers/routine_state.dart';

final routineProvider = ChangeNotifierProvider((ref) => RoutineState());
