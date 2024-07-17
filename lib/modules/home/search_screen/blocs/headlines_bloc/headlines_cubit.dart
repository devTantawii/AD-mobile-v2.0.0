import 'package:abudiyab/modules/home/search_screen/blocs/headlines_bloc/headlines_state.dart';
import 'package:abudiyab/modules/home/search_screen/data/datasources/remote/headlines_remote_datasource.dart';
import 'package:abudiyab/modules/home/search_screen/data/models/slider_model.dart';
import 'package:bloc/bloc.dart';

class HeadlinesCubit extends Cubit<HeadlinesState> {
  HeadlinesCubit( this.headlinesRemoteDataSource)
      : super(HeadlinesInitial());
  HeadlinesRemoteDataSource headlinesRemoteDataSource;
  SliderModel ? sliderModel;
  Future<void> getDataSlider() async {
    emit(HeadlinesLoading());
    try {
      sliderModel = await headlinesRemoteDataSource.getSlider();
      emit(HeadlinesLoaded(sliderModel: sliderModel!));
      print(sliderModel!.data.toString()+"fff");
    } catch (e) {
      emit(HeadLinesError(error: e.toString()));
    }
  }
}
