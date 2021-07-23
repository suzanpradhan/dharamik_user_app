
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:webapp/models/membership_model.dart';
import 'package:webapp/models/user_model.dart';

class RazorPayRepository{

  static String apiKey = 'XVOvs0ih6r7REdzbCoGM7gTJ';
  static Razorpay _razorpay = Razorpay();

  static setCallbacks(_handlePaymentSuccess,_handlePaymentError, _handleExternalWallet){
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }


  static makePayment(int amount,MembershipModel membershipModel,UserModel user){
    var options = {
      'key': apiKey,
      'amount': 100*amount,
      'name': '${membershipModel.membershipName}',
      'description': 'Duration : ${membershipModel.duration} months',
      'prefill': {
        'contact': '${user.userPhoneNumber}',
        'email': '${user.userEmail}'
      }
    };
    _razorpay.open(options);
  }


}