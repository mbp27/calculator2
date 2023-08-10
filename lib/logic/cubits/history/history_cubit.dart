import 'package:calculator2/data/models/calculation.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<List<Calculation>> with HydratedMixin {
  HistoryCubit() : super([]) {
    hydrate();
  }

  void onAdd(Calculation calculation) {
    final list = state.toList();
    list.add(calculation);
    emit(list);
  }

  void onClear() => emit([]);

  @override
  List<Calculation>? fromJson(Map<String, dynamic> json) {
    return (json['value'] as List<String>)
        .map((e) => Calculation.fromJson(e))
        .toList();
  }

  @override
  Map<String, dynamic>? toJson(List<Calculation> state) {
    return {'value': state.map((e) => e.toJson()).toList()};
  }
}
