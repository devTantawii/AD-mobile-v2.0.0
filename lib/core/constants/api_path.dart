// this is our main endpoints
// we don't uses it by it's own instead use it with other requests
const String productionApi = "https://abudiyab-soft.com/api";
const String testApi = "https://automation.terasoftsolutions.com/api";
const String mainApi = productionApi;
////////////////// AUTH
// Endpoint for login request
// with adding to queryParameters/Headers that {"Accept": "application/json"}
const String loginApi = '/login';
const String register = "/register";
////////////////////////////////////////////////////////////////////////////
const String category = "/categories";
const String offers = "/check_for_offers";
const String allCars = "/cars/filter";
const String allCarsOffers = "/filters";
const String memberShipCars = "/cars_membership/filter";
const String carsByBranch = allCars + "?branch_id=";
const String getAllBranch = mainApi + "?branches";
const String carsByPages = allCars + "?page=";
const String carsByPages2 = allCars + "&page=";
const String custClass =  "&cust_class=";
// Endpoint for manufactories request
// const String manufactories = mainApi + "/manufactories";
const String newManufactories = mainApi + "/web/manufactories";
const String changePasswordPath = mainApi + "/profile";
const String DeleteProfile = mainApi + "/deleteAccount";
const String passwordForget = mainApi + "/password/forget";
const String codeForget = mainApi + "/password/code";
const String resetPasswordPath = mainApi + "/password/reset";
////////////////// ORDER ENDPOINTS



const String getOrders = mainApi + "/orders/get-orders";
const String orderStepOnePath = mainApi + "/orders/step1";
const String invoicePath = mainApi + "/orders/step2";
const String paymentPath = mainApi + "/orders/step3";
const String checkSteps = mainApi + "/orders/check";
///////////////////////////////////////////////////////////

const String dateCheckPoint = mainApi + "/available/time";
const String favourite = mainApi + "/favorite/";
const String regions = mainApi + "/regions";
const String areas = mainApi + "/areas";
const String sliderData = mainApi + "/sliders";
const String checkOrderPath = mainApi + '/orders/check';
const String couponPath = mainApi + '/order/coupon';
const String cancelOrder = mainApi + '/order/cancel';
const String deleteOrder = mainApi + '/orders/delete-order';
const String editOrder = mainApi + '/orders/';
const String allMemberShip = mainApi + "/memberships";

////////////////// OLD CUSTOMER ///////////////////
const String enterInfoOldCustomer = mainApi + "/old/user/forget";
const String enterCodeOldCustomer = mainApi + "/old/user/code";
const String enterEmailAndPassOldCustomer = mainApi + "/old/user/reset";
////////////////// AUTOMATION//////////////
const String carAutomatedPath = mainApi + "/automated_cars?area_id=";
const String step1Automation = mainApi + "/contracts/step1";
 const String invoiceAutomationPath = mainApi + "/contracts/step2";
const String paymentAutomationPath = mainApi + "/contracts/step3";
const String bookingAutomationPath = mainApi + "/contracts";
const String uploadImageAutomationPath = mainApi + "/uploadImage";
const String checkQrAutomationPath = mainApi + "/qr/check";
const String sendCodeAutomationPath = mainApi + "/sendcode/";
const String verifyCodeAutomationPath = mainApi + "/verificationCode";
const String cancelBookingAutomationPath = mainApi + "/cancel/contracts";
const String areaLocationsPath = mainApi + "/locationArea?contract_id=";
