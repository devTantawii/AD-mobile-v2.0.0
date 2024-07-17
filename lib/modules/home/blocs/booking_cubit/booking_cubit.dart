import 'package:abudiyab/modules/home/payment/data/models/coupon_model.dart';
import 'package:abudiyab/modules/home/payment/data/repositories/coupon_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final CouponRepository couponRepository;

  BookingCubit(this.couponRepository) : super(BookingInitial());

  String? selectedPaymentMethods;
  // orderId that sent to api request
  // this save order id in classic rent and contract id in automation rent
  int? orderID;
  List<int>? additions;
  int? days = 0;
  String couponCode = "";
  String? receiveLocationId;

  void setPaymentMethods(String? method) {
    selectedPaymentMethods = method;
    emit(PaymentMethodChanged(selectedPaymentMethods));
  }

  Future checkCouponCode() async {
    emit(CouponLoading());
    try {
      final coupon = await couponRepository.checkCoupon(
          code: couponCode, orderID: orderID.toString());
      if (coupon.message == null) {
        emit(CouponValid(coupon));
      } else {
        emit(CouponInvalid("Coupon Not Valid"));
      }
    } catch (e) {
      emit(CouponInvalid(e.toString()));
    }
  }

  reset() {
    selectedPaymentMethods = null;
    orderID = 0;
    additions = [];
    days = 0;
    couponCode = "";
  }
}
