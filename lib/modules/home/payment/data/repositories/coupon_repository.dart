import 'package:abudiyab/core/helpers/SharedPreference/pereferences.dart';
import 'package:abudiyab/modules/home/payment/data/datasources/remote/coupon_remote_datasource.dart';
import 'package:abudiyab/modules/home/payment/data/models/coupon_model.dart';

class CouponRepository {
  final CouponRemoteDatasource couponRemoteDatasource;
  final SharedPreferencesHelper preferencesHelper;

  CouponRepository(this.preferencesHelper, this.couponRemoteDatasource);

  Future<CouponModel> checkCoupon({
    required String code,
    required String orderID,
  }) async {
    final userToken = await preferencesHelper.getToken();
    final coupon = await couponRemoteDatasource.checkCoupon(
      token: userToken.toString(),
      code: code,
      orderID: orderID,
    );
    return coupon;
  }
}
