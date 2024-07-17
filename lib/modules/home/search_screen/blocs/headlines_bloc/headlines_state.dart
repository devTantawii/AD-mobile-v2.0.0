import 'package:abudiyab/modules/home/search_screen/data/models/slider_model.dart';
import 'package:equatable/equatable.dart';

abstract class HeadlinesState extends Equatable {
  HeadlinesState();
  @override
  List<Object> get props => [];
}

class HeadlinesInitial extends HeadlinesState {}

class HeadlinesLoading extends HeadlinesState {}

class HeadlinesLoaded extends HeadlinesState {
  final SliderModel sliderModel;
  HeadlinesLoaded({required this.sliderModel});
  @override
  List<Object> get props => [sliderModel];
}

class HeadLinesError extends HeadlinesState {
  final String error;
  HeadLinesError({required this.error});

  @override
  List<Object> get props => [error];
}
