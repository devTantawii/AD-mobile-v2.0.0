import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import 'languages/arabic.dart';
import 'languages/english.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  bool isDirectionRTL(BuildContext context) {
    return intl.Bidi.isRtlLanguage(
        Localizations.localeOf(context).languageCode);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': english(),
    'ar': arabic(),
  };

  String get loading => _localizedValues[locale.languageCode]!['loading']!;

  String get selectLocation =>
      _localizedValues[locale.languageCode]!['selectLocation']!;

  String get remove => _localizedValues[locale.languageCode]!['remove']!;
  String get dataUser => _localizedValues[locale.languageCode]!['dataUser']!;
  //String get oldCustomers => _localizedValues[locale.languageCode]!['uploadIdAndNum']!;

  // String? get oldCustomers {
  //   return _localizedValues[locale.languageCode]!['uploadIdAndNum'];
  // }

  String get writeSignature =>
      _localizedValues[locale.languageCode]!['writeSignature']!;

  String get pleaseWriteYourSignature =>
      _localizedValues[locale.languageCode]!['pleaseWriteYourSignature']!;

  String get putKeysBack =>
      _localizedValues[locale.languageCode]!['putKeysBack']!;

  String get closeAllDoors =>
      _localizedValues[locale.languageCode]!['closeAllDoors']!;
  String get checkOut =>
      _localizedValues[locale.languageCode]!['checkOut']!;

  String get acknowledgePuttingKeyBack =>
      _localizedValues[locale.languageCode]!['acknowledgePuttingKeyBack']!;

  String get uploadAllImages =>
      _localizedValues[locale.languageCode]!['uploadAllImages']!;

  String get pleaseUploadCarsSection =>
      _localizedValues[locale.languageCode]!['pleaseUploadCarsSection']!;
       String get tackPhoto =>
      _localizedValues[locale.languageCode]!['tackPhoto']!;
       String get gallery =>
      _localizedValues[locale.languageCode]!['gallery']!;

  String get confirmDropOffArea =>
      _localizedValues[locale.languageCode]!['confirmDropOffArea']!;

  String get pleaseConfirmDropOffArea =>
      _localizedValues[locale.languageCode]!['pleaseConfirmDropOffArea']!;

  String get pickUpCar => _localizedValues[locale.languageCode]!['pickUpCar']!;

  String get dropOffCar =>
      _localizedValues[locale.languageCode]!['dropOffCar']!;

  String get smsMessageCode =>
      _localizedValues[locale.languageCode]!['smsMessageCode']!;

  String get signTerms => _localizedValues[locale.languageCode]!['signTerms']!;

  String get agreeTerms =>
      _localizedValues[locale.languageCode]!['agreeTerms']!;

  String get pressEachSection =>
      _localizedValues[locale.languageCode]!['pressEachSection']!;

  String get confirm => _localizedValues[locale.languageCode]!['confirm']!;

  String get classicBookings =>
      _localizedValues[locale.languageCode]!['classicBookings']!;

  String get automatedBookings =>
      _localizedValues[locale.languageCode]!['automatedBookings']!;

  String get someDataNotComplete =>
      _localizedValues[locale.languageCode]!['someDataNotComplete']!;

  String get automatedRent =>
      _localizedValues[locale.languageCode]!['automatedRent']!;

  String get classicRent =>
      _localizedValues[locale.languageCode]!['classicRent']!;

  String get abudiyabWelcome =>
      _localizedValues[locale.languageCode]!['abudiyabWelcome']!;

  String get abudiyab => _localizedValues[locale.languageCode]!['abudiyab']!;

  String get total2 => _localizedValues[locale.languageCode]!['total2']!;
  String get total3 => _localizedValues[locale.languageCode]!['total3']!;

  String get pleaseEnterPhoneNumber =>
      _localizedValues[locale.languageCode]!['pleaseEnterPhoneNumber']!;

  String get pleaseEnterNumberMinimum =>
      _localizedValues[locale.languageCode]!['pleaseEnterNumberMinimum']!;

  String get passwordNotMatching =>
      _localizedValues[locale.languageCode]!['passwordNotMatching']!;

  String get pleaseEnterPassword =>
      _localizedValues[locale.languageCode]!['pleaseEnterPassword']!;

  String get pleaseEnterValidCredit =>
      _localizedValues[locale.languageCode]!['pleaseEnterValidCredit']!;

  String get enterValidCVV =>
      _localizedValues[locale.languageCode]!['enterValidCVV']!;

  String get pleaseEnterEmail =>
      _localizedValues[locale.languageCode]!['pleaseEnterEmail']!;

  String get pleaseEnterName =>
      _localizedValues[locale.languageCode]!['pleaseEnterName']!;

  String get enterNameMiniChars =>
      _localizedValues[locale.languageCode]!['enterNameMiniChars']!;

  String get enterValidEmail =>
      _localizedValues[locale.languageCode]!['enterValidEmail']!;

  String get doneEditProfile =>
      _localizedValues[locale.languageCode]!['doneEditProfile']!;

  String get more => _localizedValues[locale.languageCode]!['more']!;

  String get continuePaymentProcess =>
      _localizedValues[locale.languageCode]!['continuePaymentProcess']!;

  String get selectPrice =>
      _localizedValues[locale.languageCode]!['selectPrice']!;

  String get selectModel =>
      _localizedValues[locale.languageCode]!['selectModel']!;

  String get moreMembershipDetails =>
      _localizedValues[locale.languageCode]!['moreMembershipDetails']!;

  String get clickHere => _localizedValues[locale.languageCode]!['clickHere']!;

  String get rentalDiscount =>
      _localizedValues[locale.languageCode]!['rentalDiscount']!;

  String get allowedKilos =>
      _localizedValues[locale.languageCode]!['allowedKilos']!;

  String get extraHours =>
      _localizedValues[locale.languageCode]!['extraHours']!;

  String get hour => _localizedValues[locale.languageCode]!['hour']!;

  String get regionsDiscount =>
      _localizedValues[locale.languageCode]!['regionsDiscount']!;

  String get ratioPoints =>
      _localizedValues[locale.languageCode]!['ratioPoints']!;

  String? get selectRegion =>
      _localizedValues[locale.languageCode]!['selectRegion'];

  String get dateInvalid =>
      _localizedValues[locale.languageCode]!['dateInvalid']!;

  String get selectRegionAndBranch =>
      _localizedValues[locale.languageCode]!['selectRegionAndBranch']!;

  String get pleaseWaitWhileLoading =>
      _localizedValues[locale.languageCode]!['pleaseWaitWhileLoading']!;

  String? get continueAsGuest =>
      _localizedValues[locale.languageCode]!['continueAsGuest'];

  String? get reciveDate =>
      _localizedValues[locale.languageCode]!['reciveDate'];

  String? get deliveryDate =>
      _localizedValues[locale.languageCode]!['deliveryDate'];

  String? get carNotAvailable =>
      _localizedValues[locale.languageCode]!['carNotAvailable'];

  String? get checkUsernameAndPassword =>
      _localizedValues[locale.languageCode]!['checkUsernameAndPassword'];

  String? get allDays => _localizedValues[locale.languageCode]!['allDays'];

  String? get next => _localizedValues[locale.languageCode]!['next'];

  String? get back => _localizedValues[locale.languageCode]!['back'];

  String? get goToBookings =>
      _localizedValues[locale.languageCode]!['goToBookings'];
  String? get goToHome => _localizedValues[locale.languageCode]!['goToHome'];
  String? get goHome => _localizedValues[locale.languageCode]!['goHome'];
  String? get minutes => _localizedValues[locale.languageCode]!['minutes'];
  String? get seconds => _localizedValues[locale.languageCode]!['seconds'];

  String? get enterYouPhoneNumberResetIt =>
      _localizedValues[locale.languageCode]!['EnterYouPhoneNumberResetIt'];

  String? get reset => _localizedValues[locale.languageCode]!['reset'];

  String? get oldCustomer =>
      _localizedValues[locale.languageCode]!['oldCustomer'];

  String? get enterIdAndNumber =>
      _localizedValues[locale.languageCode]!['enterIdAndNumber'];

  String? get send => _localizedValues[locale.languageCode]!['send'];

  String? get agreeTermsAndConditions =>
      _localizedValues[locale.languageCode]!['agreeTermsAndConditions'];

  String? get enterCodeSent =>
      _localizedValues[locale.languageCode]!['enterCodeSent'];

  String? get createEmailAndPassword =>
      _localizedValues[locale.languageCode]!['createEmailAndPassword'];

  String? get skip => _localizedValues[locale.languageCode]!['skip'];

  String? get pickUpBranch =>
      _localizedValues[locale.languageCode]!['pickUpBranch'];

  String? get pickUpArea =>
      _localizedValues[locale.languageCode]!['pickUpArea'];

  String? get dropOffBranch =>
      _localizedValues[locale.languageCode]!['dropOffBranch'];

  String? get dropOffArea =>
      _localizedValues[locale.languageCode]!['dropOffArea'];

  String? get deliverAnotherBranch =>
      _localizedValues[locale.languageCode]!['deliverAnotherBranch'];

  String? get fromTime => _localizedValues[locale.languageCode]!['fromTime'];

  String? get toTime => _localizedValues[locale.languageCode]!['toTime'];

  String? get search => _localizedValues[locale.languageCode]!['search'];

  String? get sar => _localizedValues[locale.languageCode]!['sar'];

  String? get day => _localizedValues[locale.languageCode]!['day'];

  String? get carName => _localizedValues[locale.languageCode]!['carName'];

  String? get type => _localizedValues[locale.languageCode]!['type'];

  String? get reservation =>
      _localizedValues[locale.languageCode]!['reservation'];

  String? get delivery => _localizedValues[locale.languageCode]!['delivery'];

  String? get region => _localizedValues[locale.languageCode]!['region'];

  String? get workTime => _localizedValues[locale.languageCode]!['workTime'];

  String? get morning => _localizedValues[locale.languageCode]!['morning'];

  String? get afternoon => _localizedValues[locale.languageCode]!['afternoon'];

  String? get branches => _localizedValues[locale.languageCode]!['branches'];

  String? get mapView => _localizedValues[locale.languageCode]!['mapView'];

  String? get listView => _localizedValues[locale.languageCode]!['listView'];

  String? get visa => _localizedValues[locale.languageCode]!['visa'];

  String? get cash => _localizedValues[locale.languageCode]!['cash'];

  String? get points => _localizedValues[locale.languageCode]!['points'];

  String? get invoice => _localizedValues[locale.languageCode]!['invoice'];

  String? get connectWithUs =>
      _localizedValues[locale.languageCode]!['connectWithUs'];

  String? get choseBranch =>
      _localizedValues[locale.languageCode]!['choseBranch'];

  String? get total => _localizedValues[locale.languageCode]!['total'];


  String? get allCar => _localizedValues[locale.languageCode]!['allCar'];

  String? get filterCars =>
      _localizedValues[locale.languageCode]!['filterCars'];

  String? get priceAndModel =>
      _localizedValues[locale.languageCode]!['priceAndModel'];

  String? get grandTotal =>
      _localizedValues[locale.languageCode]!['grandTotal'];

  String? get additions => _localizedValues[locale.languageCode]!['additions'];

  String? get rent => _localizedValues[locale.languageCode]!['rent'];

  String? get tam => _localizedValues[locale.languageCode]!['tam'];

  String? get transfer => _localizedValues[locale.languageCode]!['transfer'];

  String? get memberDiscount =>
      _localizedValues[locale.languageCode]!['memberDiscount'];

  String? get promotionalDiscount =>
      _localizedValues[locale.languageCode]!['promotionalDiscount'];
  String? get carDiscount =>
      _localizedValues[locale.languageCode]!['carDiscount'];
  String? get carSelected2 =>
      _localizedValues[locale.languageCode]!['carSelected2'];

  String? get visaDiscount =>
      _localizedValues[locale.languageCode]!['visaDiscount']; 

  String? get taxValue => _localizedValues[locale.languageCode]!['taxValue'];

  String? get addCoupon => _localizedValues[locale.languageCode]!['addCoupon'];

  String? get addVoucher =>
      _localizedValues[locale.languageCode]!['addVoucher'];

  String? get totalAfterDiscount =>
      _localizedValues[locale.languageCode]!['totalAfterDiscount'];
  String? get goToPayment =>
      _localizedValues[locale.languageCode]!['goToPayment'];

  String? get brand => _localizedValues[locale.languageCode]!['brand'];

  String? get category => _localizedValues[locale.languageCode]!['category'];

  String? get selectMethodDescription =>
      _localizedValues[locale.languageCode]!['selectMethodDescription'];

  String? get noMethodSelected =>
      _localizedValues[locale.languageCode]!['noMethodSelected'];

  String? get choosePaymentMethod =>
      _localizedValues[locale.languageCode]!['ChoosePaymentMethod'];

  String? get paymentMethod =>
      _localizedValues[locale.languageCode]!['paymentMethod'];

  String? get feedback => _localizedValues[locale.languageCode]!['feedback'];

  String? get editOrder => _localizedValues[locale.languageCode]!['editOrder'];

  String? get attention => _localizedValues[locale.languageCode]!['attention'];



  String? get wantToCancel =>
      _localizedValues[locale.languageCode]!['wantToCancel'];
  String? get wantToDelete =>
      _localizedValues[locale.languageCode]!['wantToCancel'];

  String? get ok => _localizedValues[locale.languageCode]!['ok'];

  String? get termsConditions =>
      _localizedValues[locale.languageCode]!['termsConditions'];

  String? get privacyPolicy =>
      _localizedValues[locale.languageCode]!['privacyPolicy'];

  String? get alreadyHaveAccount =>
      _localizedValues[locale.languageCode]!['alreadyHaveAccount'];

  String? get uploadedSuccessfully =>
      _localizedValues[locale.languageCode]!['uploadedSuccessfully'];

  String? get uploadLicense =>
      _localizedValues[locale.languageCode]!['uploadLicense'];

  String? get dontHaveAccount =>
      _localizedValues[locale.languageCode]!['dontHaveAccount'];
  String? get deliverAndReceiveData =>
      _localizedValues[locale.languageCode]!['deliverAndReceiveData'];
  String? get from =>
      _localizedValues[locale.languageCode]!['from'];
  String? get to =>
      _localizedValues[locale.languageCode]!['to'];

  String? get forgetPassword =>
      _localizedValues[locale.languageCode]!['forgetPassword'];

  String? get changePassword =>
      _localizedValues[locale.languageCode]!['changePassword'];

  String? get oldPassword =>
      _localizedValues[locale.languageCode]!['oldPassword'];

  String? get newPassword =>
      _localizedValues[locale.languageCode]!['newPassword'];

  String? get passwordChanged =>
      _localizedValues[locale.languageCode]!['passwordChanged'];

  String? get resetPassword =>
      _localizedValues[locale.languageCode]!['resetPassword'];

  String? get done => _localizedValues[locale.languageCode]!['done'];

  String? get editProfile =>
      _localizedValues[locale.languageCode]!['editProfile'];

  String? get error => _localizedValues[locale.languageCode]!['error'];

  String? get memberShip =>
      _localizedValues[locale.languageCode]!['memberShip'];

  String? get favorite => _localizedValues[locale.languageCode]!['favorite'];

  String? get fleet => _localizedValues[locale.languageCode]!['fleet'];

  String? get signIn => _localizedValues[locale.languageCode]!['signIn'];

  String? get selectBranch {
    return _localizedValues[locale.languageCode]!['selectBranch'];
  }
  String? get viewLicense {
    return _localizedValues[locale.languageCode]!['viewLicense'];
  }
  String? get editLicense {
    return _localizedValues[locale.languageCode]!['editLicense'];
  }
///******************************************
  String? get titleOnboarding1 {
    return _localizedValues[locale.languageCode]!['titleOnboarding1'];
  }
  String? get applePayTotal {
    return _localizedValues[locale.languageCode]!['applePayTotal'];
  }
  String? get reserveYourCarNow {
    return _localizedValues[locale.languageCode]!['reserveYourCarNow'];
  }
  String? get openLocation {
    return _localizedValues[locale.languageCode]!['openLocation'];
  }

  String? get chooseCar {
    return _localizedValues[locale.languageCode]!['chooseCar'];
  }
  String? get avilable {
    return _localizedValues[locale.languageCode]!['avilable'];
  }
  String? get car {
    return _localizedValues[locale.languageCode]!['car'];
  }
  String? get searchCar {
    return _localizedValues[locale.languageCode]!['searchCar'];
  } String? get delete {
    return _localizedValues[locale.languageCode]!['delete'];
  }
  String? get pleaseCreateNewAccount {
    return _localizedValues[locale.languageCode]!['pleaseCreateNewAccount'];
  }
  String? get bodyOnboarding1 {
    return _localizedValues[locale.languageCode]!['bodyOnboarding1'];
  }
  String? get titleOnboarding2 {
    return _localizedValues[locale.languageCode]!['titleOnboarding2'];
  }
  String? get bodyOnboarding2 {
    return _localizedValues[locale.languageCode]!['bodyOnboarding2'];
  }
  String? get titleOnboarding3 {
    return _localizedValues[locale.languageCode]!['titleOnboarding3'];
  }
  String? get bodyOnboarding3 {
    return _localizedValues[locale.languageCode]!['bodyOnboarding3'];
  }
  String? get seeDetails {
    return _localizedValues[locale.languageCode]!['More Details'];
  }
  String? get follow {
    return _localizedValues[locale.languageCode]!['follow'];
  }
  String? get finish {
    return _localizedValues[locale.languageCode]!['finish'];
  }
  String? get lessDetails {
    return _localizedValues[locale.languageCode]!['less Details'];
  }
  String? get loginToContinue {
    return _localizedValues[locale.languageCode]!['LoginToContinue'];
  }
  String? get netAmount {
    return _localizedValues[locale.languageCode]!['netAmount'];
  }
  String? get uploadLicencePlease {
    return _localizedValues[locale.languageCode]!['uploadLicensePlease'];
  }
  String? get oldCustomers {
    return _localizedValues[locale.languageCode]!['uploadIdAndNum'];
  }
  String? get offersDialogBox {
    return _localizedValues[locale.languageCode]!['offersDialogBox'];
  }
  String? get offersDisc {
    return _localizedValues[locale.languageCode]!['offersDisc'];
  }
  String? get offersNow {
    return _localizedValues[locale.languageCode]!['offersNow'];
  }
  String? get oldCustCode {
    return _localizedValues[locale.languageCode]!['oldCustCode'];
  }
  String? get DeleteAccount {
    return _localizedValues[locale.languageCode]!['DeleteAccount'];
  }
  String? get lookLike {
    return _localizedValues[locale.languageCode]!['lookLike'];
  }
  String? get lookLike1 {
    return _localizedValues[locale.languageCode]!['lookLike1'];
  }
  String? get lookLike2 {
    return _localizedValues[locale.languageCode]!['lookLike2'];
  }
  String? get errorData {
    return _localizedValues[locale.languageCode]!['errorData'];
  }
  String? get areYouSureDelete {
    return _localizedValues[locale.languageCode]!['areYouSureDelete'];
  }
  String? get noCarsInBranch {
    return _localizedValues[locale.languageCode]!['noCarsInBranch'];
  }

  String? get noCarsBooking1 {
    return _localizedValues[locale.languageCode]!['noCarsBooking1'];
  }

  String? get noCarsBookings => _localizedValues[locale.languageCode]!['noCarsBookings'];
  String? get welcomeAgain {
    return _localizedValues[locale.languageCode]!['welcomeAgain'];
  }
  String? get welcomeAgainSubtitel{
    return _localizedValues[locale.languageCode]!['welcomeAgainSubtitel'];
  }
  String? get applePay{
    return _localizedValues[locale.languageCode]!['applePay'];
  }
  String? get welcomeAtAbudiyab{
    return _localizedValues[locale.languageCode]!['welcomeAtAbudiyab'];
  }
  String? get welcomeAtAbudiyabsubTitle{
    return _localizedValues[locale.languageCode]!['welcomeAtAbudiyabsubTitle'];
  }
  String? get bookYourCarFast{
    return _localizedValues[locale.languageCode]!['bookYourCarFast'];
  }
  String? get slogan{
    return _localizedValues[locale.languageCode]!['slogan'];
  }
  String? get knowAboutFleet{
    return _localizedValues[locale.languageCode]!['knowAboutFleet'];
  }
  ///**************************************
  String? get agree =>
      _localizedValues[locale.languageCode]!['agree'];
  String? get confirmPassword {
    return _localizedValues[locale.languageCode]!['confirmPassword'];
  }

  String? get uploadLicenseFace {
    return _localizedValues[locale.languageCode]!['uploadLicenseFace'];
  }
  String? get uploadLicenseBack {
    return _localizedValues[locale.languageCode]!['uploadLicenseBack'];
  }

  String? get addLicenses {
    return _localizedValues[locale.languageCode]!['addLicense'];
  }

  String? get selectCountry {
    return _localizedValues[locale.languageCode]!['selectCountry'];
  }

  String? get orContinueWith {
    return _localizedValues[locale.languageCode]!['orContinueWith'];
  }

  String? get enterMobileNumber {
    return _localizedValues[locale.languageCode]!['enterMobileNumber'];
  }

  String? get facebook {
    return _localizedValues[locale.languageCode]!['facebook'];
  }

  String? get google {
    return _localizedValues[locale.languageCode]!['google'];
  }

  String? get phoneNumber {
    return _localizedValues[locale.languageCode]!['phoneNumber'];
  }

  String? get fullName {
    return _localizedValues[locale.languageCode]!['fullName'];
  }

  String? get password {
    return _localizedValues[locale.languageCode]!['password'];
  }

  String? get emailAddress {
    return _localizedValues[locale.languageCode]!['emailAddress'];
  }

  String? get continuee {
    return _localizedValues[locale.languageCode]!['continuee'];
  }

  String? get enterVerificationCodeWeveSent {
    return _localizedValues[locale.languageCode]![
        'enterVerificationCodeWeveSent'];
  }

  String? get enterVerificationCode {
    return _localizedValues[locale.languageCode]!['enterVerificationCode'];
  }

  String? get myBookings {
    return _localizedValues[locale.languageCode]!['myBookings'];
  }

  String? get myCars {
    return _localizedValues[locale.languageCode]!['myCars'];
  }

  String? get favourites {
    return _localizedValues[locale.languageCode]!['favourites'];
  }

  String? get selectCar {
    return _localizedValues[locale.languageCode]!['selectCar'];
  }

  String? get services {
    return _localizedValues[locale.languageCode]!['services'];
  }

  String? get when {
    return _localizedValues[locale.languageCode]!['when'];
  }

  String? get serviceLocation {
    return _localizedValues[locale.languageCode]!['serviceLocation'];
  }

  String? get home {
    return _localizedValues[locale.languageCode]!['home'];
  }

  String? get office {
    return _localizedValues[locale.languageCode]!['office'];
  }



  String? get other {
    return _localizedValues[locale.languageCode]!['other'];
  }
  String? get or {
    return _localizedValues[locale.languageCode]!['or'];
  }
  String? get logout {
    return _localizedValues[locale.languageCode]!['logout'];
  }

  String? get submit {
    return _localizedValues[locale.languageCode]!['submit'];
  }

  String? get resend {
    return _localizedValues[locale.languageCode]!['resend'];
  }

  String? get distance {
    return _localizedValues[locale.languageCode]!['distance'];
  }

  String? get cost {
    return _localizedValues[locale.languageCode]!['cost'];
  }

  String? get bookNow {
    return _localizedValues[locale.languageCode]!['bookNow'];
  }

  String? get proceedToPay {
    return _localizedValues[locale.languageCode]!['proceedToPay'];
  }

  String? get hello {
    return _localizedValues[locale.languageCode]!['hello'];
  }

  String? get viewAll {
    return _localizedValues[locale.languageCode]!['viewAll'];
  }

  String? get selectProvider {
    return _localizedValues[locale.languageCode]!['selectProvider'];
  }

  String? get carSelected {
    return _localizedValues[locale.languageCode]!['carSelected'];
  }

  String? get arrangePickupAndDrop {
    return _localizedValues[locale.languageCode]!['arrangePickupAndDrop'];
  }

  String? get serviceProviderWillpickup {
    return _localizedValues[locale.languageCode]!['serviceProviderWillpickup'];
  }

  String? get selectPickupAddress {
    return _localizedValues[locale.languageCode]!['selectPickupAddress'];
  }

  String? get datetime {
    return _localizedValues[locale.languageCode]!['datetime'];
  }

  String? get servicesSelected {
    return _localizedValues[locale.languageCode]!['servicesSelected'];
  }

  String? get processToPayment {
    return _localizedValues[locale.languageCode]!['processToPayment'];
  }

  String? get registerNow {
    return _localizedValues[locale.languageCode]!['registerNow'];
  }

  String? get setLocation {
    return _localizedValues[locale.languageCode]!['setLocation'];
  }

  String? get reviews {
    return _localizedValues[locale.languageCode]!['reviews'];
  }

  String? get comfirmBooking {
    return _localizedValues[locale.languageCode]!['comfirmBooking'];
  }

  String? get amountPayable {
    return _localizedValues[locale.languageCode]!['amountPayable'];
  }

  String? get payment {
    return _localizedValues[locale.languageCode]!['payment'];
  }

  String? get selectPaymentMethods {
    return _localizedValues[locale.languageCode]!['selectPaymentMethods'];
  }

  String? get payNow {
    return _localizedValues[locale.languageCode]!['payNow'];
  }

  String? get bookingConfirmed {
    return _localizedValues[locale.languageCode]!['bookingConfirmed'];
  }

  String? get sitBackAndRelax {
    return _localizedValues[locale.languageCode]!['sitBackAndRelax'];
  }

  String? get haveAGreatDay {
    return _localizedValues[locale.languageCode]!['haveAGreatDay'];
  }

  String? get viewMore {
    return _localizedValues[locale.languageCode]!['viewMore'];
  }

  String? get rateNow {
    return _localizedValues[locale.languageCode]!['rateNow'];
  }

  String? get bookingFor {
    return _localizedValues[locale.languageCode]!['bookingFor'];
  }

  String? get continueToPay {
    return _localizedValues[locale.languageCode]!['continueToPay'];
  }

  String? get readAll {
    return _localizedValues[locale.languageCode]!['readAll'];
  }

  String? get viewProfile {
    return _localizedValues[locale.languageCode]!['viewProfile'];
  }

  String? get cancel {
    return _localizedValues[locale.languageCode]!['cancel'];
  }

  String? get letUsKnowUrFeedbacks {
    return _localizedValues[locale.languageCode]!['letUsKnowUrFeedbacks'];
  }

  String? get submitReview {
    return _localizedValues[locale.languageCode]!['submitReview'];
  }

  String? get openingHours {
    return _localizedValues[locale.languageCode]!['openingHours'];
  }

  String? get openNow {
    return _localizedValues[locale.languageCode]!['openNow'];
  }

  String? get getDirection {
    return _localizedValues[locale.languageCode]!['getDirection'];
  }

  String? get peopleRated {
    return _localizedValues[locale.languageCode]!['peopleRated'];
  }

  String? get orderPlaced {
    return _localizedValues[locale.languageCode]!['orderPlaced'];
  }
  String? get orderDetails {
    return _localizedValues[locale.languageCode]!['orderDetails'];
  }
  String? get orderStatus {
    return _localizedValues[locale.languageCode]!['orderStatus'];
  }

  String? get savedAddresses {
    return _localizedValues[locale.languageCode]!['savedAddresses'];
  }

  String? get addNewLocation {
    return _localizedValues[locale.languageCode]!['addNewLocation'];
  }

  String? get selectAddressType {
    return _localizedValues[locale.languageCode]!['selectAddressType'];
  }

  String? get enterAddressDetails {
    return _localizedValues[locale.languageCode]!['enterAddressDetails'];
  }

  String? get myOrders {
    return _localizedValues[locale.languageCode]!['myOrders'];
  }String? get ordersNow {
    return _localizedValues[locale.languageCode]!['ordersNow'];
  }

  String? get cashOnDelivery {
    return _localizedValues[locale.languageCode]!['cashOnDelivery'];
  }

  String? get payPal {
    return _localizedValues[locale.languageCode]!['payPal'];
  }

  String? get selectPaymentMethod {
    return _localizedValues[locale.languageCode]!['selectPaymentMethod'];
  }

  String? get rating {
    return _localizedValues[locale.languageCode]!['rating'];
  }

  String? get applyNow {
    return _localizedValues[locale.languageCode]!['applyNow'];
  }

  String? get selectDateAndTime {
    return _localizedValues[locale.languageCode]!['selectDateAndTime'];
  }

  String? get selectDate {
    return _localizedValues[locale.languageCode]!['selectDate'];
  }

  String? get selectTime {
    return _localizedValues[locale.languageCode]!['Select time'];
  }

  String? get selectCarBrand {
    return _localizedValues[locale.languageCode]!['selectCarBrand'];
  }

  String? get selectCarModel {
    return _localizedValues[locale.languageCode]!['selectCarModel'];
  }

  String? get selectCarType {
    return _localizedValues[locale.languageCode]!['selectCarType'];
  }

  String? get addCarNumber {
    return _localizedValues[locale.languageCode]!['addCarNumber'];
  }

  String? get saveCarInfo {
    return _localizedValues[locale.languageCode]!['saveCarInfo'];
  }

  String? get wereHappyToHear {
    return _localizedValues[locale.languageCode]!['wereHappyToHear'];
  }

  String? get letUsKnowQueriesAndFeedbacks {
    return _localizedValues[locale.languageCode]![
        'letUsKnowQueriesAndFeedbacks'];
  }

  String? get sendYourMessage {
    return _localizedValues[locale.languageCode]!['sendYourMessage'];
  }

  String? get callUs {
    return _localizedValues[locale.languageCode]!['callUs'];
  }

  String? get mailUs {
    return _localizedValues[locale.languageCode]!['mailUs'];
  }

  String? get yourMessage {
    return _localizedValues[locale.languageCode]!['yourMessage'];
  }

  String? get about {
    return _localizedValues[locale.languageCode]!['about'];
  }

  String? get address {
    return _localizedValues[locale.languageCode]!['address'];
  }

  String? get location {
    return _localizedValues[locale.languageCode]!['location'];
  }

  String? get days {
    return _localizedValues[locale.languageCode]!['days'];
  }

  String? get addNewAddress {
    return _localizedValues[locale.languageCode]!['addNewAddress'];
  }

  String? get saved {
    return _localizedValues[locale.languageCode]!['saved'];
  }

  String? get termsAndCond {
    return _localizedValues[locale.languageCode]!['termsAndCond'];
  }

  String? get saveAddress {
    return _localizedValues[locale.languageCode]!['saveAddress'];
  }

  String? get contactUs {
    return _localizedValues[locale.languageCode]!['contactUs'];
  }

  String? get myAddresses {
    return _localizedValues[locale.languageCode]!['myAddresses'];
  }

  String? get changeLanguage {
    return _localizedValues[locale.languageCode]!['changeLanguage'];
  }

  String? get selectLanguage {
    return _localizedValues[locale.languageCode]!['selectLanguage'];
  }

  String? get register {
    return _localizedValues[locale.languageCode]!['register'];
  }

  String? get enterName {
    return _localizedValues[locale.languageCode]!['enterName'];
  }


  String? get verification {
    return _localizedValues[locale.languageCode]!['verification'];
  }

  String? get enterCode {
    return _localizedValues[locale.languageCode]!['enterCode'];
  }

  String? get dummyAddress1 {
    return _localizedValues[locale.languageCode]!['dummyAddress1'];
  }

  String? get dummyStore1 {
    return _localizedValues[locale.languageCode]!['dummyStore1'];
  }

  String? get dummyStore2 {
    return _localizedValues[locale.languageCode]!['dummyStore2'];
  }

  String? get save {
    return _localizedValues[locale.languageCode]!['save'];
  }

  String? get carPolish {
    return _localizedValues[locale.languageCode]!['carPolish'];
  }

  String? get dummyTime {
    return _localizedValues[locale.languageCode]!['dummyTime'];
  }

  String? get car1 {
    return _localizedValues[locale.languageCode]!['car1'];
  }

  String? get dummyName1 {
    return _localizedValues[locale.languageCode]!['dummyName1'];
  }

  String? get dummyNumber {
    return _localizedValues[locale.languageCode]!['dummyNumber'];
  }

  String? get contactNumber {
    return _localizedValues[locale.languageCode]!['contactNumber'];
  }

  String? get writeYourNumber {
    return _localizedValues[locale.languageCode]!['writeYourNumber'];
  }

  String? get dummyRating {
    return _localizedValues[locale.languageCode]!['dummyRating'];
  }

  String? get dummyAddress2 {
    return _localizedValues[locale.languageCode]!['dummyAddress2'];
  }

  String? get car2 {
    return _localizedValues[locale.languageCode]!['car2'];
  }

  String? get car1Model {
    return _localizedValues[locale.languageCode]!['car1Model'];
  }

  String? get car2Model {
    return _localizedValues[locale.languageCode]!['car2Model'];
  }

  String? get car1Number {
    return _localizedValues[locale.languageCode]!['car1Number'];
  }

  String? get car2Number {
    return _localizedValues[locale.languageCode]!['car2Number'];
  }

  String? get profile {
    return _localizedValues[locale.languageCode]!['profile'];
  }

  String? get eng {
    return _localizedValues[locale.languageCode]!['english'];
  }

  String? get arab {
    return _localizedValues[locale.languageCode]!['arabic'];
  }

  String? get frnch {
    return _localizedValues[locale.languageCode]!['french'];
  }

  String? get prtguese {
    return _localizedValues[locale.languageCode]!['portuguese'];
  }

  String? get addCar {
    return _localizedValues[locale.languageCode]!['addCar'];
  }

  String? get convertible {
    return _localizedValues[locale.languageCode]!['convertible'];
  }

  String? get addReview {
    return _localizedValues[locale.languageCode]!['addReview'];
  }

  String? get serviceProvider {
    return _localizedValues[locale.languageCode]!['serviceProvider'];
  }

  String? get homeb {
    return _localizedValues[locale.languageCode]!['homeb'];
  }

  String? get dummyDate1 {
    return _localizedValues[locale.languageCode]!['dummyDate1'];
  }

  String? get dummyTime1 {
    return _localizedValues[locale.languageCode]!['dummyTime1'];
  }

  String? get bodywash {
    return _localizedValues[locale.languageCode]!['bodywash'];
  }

  String? get interiorCleaning {
    return _localizedValues[locale.languageCode]!['interiorCleaning'];
  }

  String? get engineDetailing {
    return _localizedValues[locale.languageCode]!['engineDetailing'];
  }

  String? get pickUpAndDropCharges {
    return _localizedValues[locale.languageCode]!['pickUpAndDropCharges'];
  }

  String? get amountPaid {
    return _localizedValues[locale.languageCode]!['amountPaid'];
  }

  String? get dummyOpeningTime {
    return _localizedValues[locale.languageCode]!['dummyOpeningTime'];
  }

  String? get lorem {
    return _localizedValues[locale.languageCode]!['lorem'];
  }

  String? get creditCard {
    return _localizedValues[locale.languageCode]!['creditCard'];
  }

  String? get addNewCar {
    return _localizedValues[locale.languageCode]!['addNewCar'];
  }

  String? get tapToAdd {
    return _localizedValues[locale.languageCode]!['tapToAdd'];
  }

  String? get sun {
    return _localizedValues[locale.languageCode]!['sun'];
  }

  String? get mon {
    return _localizedValues[locale.languageCode]!['mon'];
  }

  String? get tue {
    return _localizedValues[locale.languageCode]!['tue'];
  }

  String? get wed {
    return _localizedValues[locale.languageCode]!['wed'];
  }

  String? get thr {
    return _localizedValues[locale.languageCode]!['thr'];
  }

  String? get fri {
    return _localizedValues[locale.languageCode]!['fri'];
  }

  String? get sat {
    return _localizedValues[locale.languageCode]!['sat'];
  }

  String? get june {
    return _localizedValues[locale.languageCode]!['june'];
  }

  String? get am {
    return _localizedValues[locale.languageCode]!['am'];
  }

  String? get pm {
    return _localizedValues[locale.languageCode]!['pm'];
  }

  String? get searchLocation {
    return _localizedValues[locale.languageCode]!['searchLocation'];
  }

  String? get approx {
    return _localizedValues[locale.languageCode]!['approx'];
  }

  String? get dummyDistance {
    return _localizedValues[locale.languageCode]!['dummyDistance'];
  }

  String? get indonesia {
    return _localizedValues[locale.languageCode]!['indonesian'];
  }

  String? get italy {
    return _localizedValues[locale.languageCode]!['italian'];
  }

  String? get spansh {
    return _localizedValues[locale.languageCode]!['spanish'];
  }

  String? get swahilii {
    return _localizedValues[locale.languageCode]!['swahili'];
  }

  String? get turk {
    return _localizedValues[locale.languageCode]!['turkish'];
  }

  String? get bookingDetails {
    return _localizedValues[locale.languageCode]!['bookingDetails'];
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => [
        'en',
        'ar',
      ].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of AppLocalizations.
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
