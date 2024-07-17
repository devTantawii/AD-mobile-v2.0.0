import 'package:abudiyab/modules/home/booking_from_cars/datasources/booking_cars_remote_datasource.dart';
import 'package:abudiyab/modules/home/booking_from_cars/model/branch_from_cars_model.dart';
import 'package:abudiyab/modules/home/booking_from_cars/presentaion/bloc/booking_cars_state.dart';
import 'package:bloc/bloc.dart';

class BookingFromCarsCubit extends Cubit<BookingFromCarsState> {
  BookingFromCarsCubit(this.bookingFromCarsRemoteDataSource)
      : super(BookingFromCarsInitial());
  BookingFromCarsRemoteDataSource bookingFromCarsRemoteDataSource;
  late BranchFromCarModel branchesModel;

  Future<void> getBranchesWithCar({required int carId}) async {
    emit(BookingFromCarsLoading());
    try {
      final data = await bookingFromCarsRemoteDataSource.getBranches(carId: carId);
      branchesModel = data;
      emit(BookingFromCarsLoaded(branchModel: data));
    } catch (e) {
      emit(BookingFromCarsError(error: e.toString()),);
    }
  }
}
