import 'travel.dart';

class Ticket {
  final Travel travel;
  final int ticketPrice;
  final String selectedSeatNumber; // "01" "02" "03" ... "44"
  String mode; // bought / reserved
  int paidPrice;// مبلغ پرداختی
  int passengerDeptPrice = 0;// مبلغ بدهکاری مسافر
  int passengerOwedPrice = 0;//مبلغ طلبکاری مسافر


  Ticket.reserve( {required this.travel, required this.ticketPrice, required this.selectedSeatNumber}):mode="reserved",paidPrice = (ticketPrice*.3).toInt(){
    passengerDeptPrice = ticketPrice - paidPrice;
  }

  Ticket.buy( {required this.travel, required this.ticketPrice,required this.selectedSeatNumber}):mode="bought",paidPrice = ticketPrice, passengerDeptPrice = 0;

  @override
  String toString() {
    return "Ticket ($mode) => $travel, SeatNumber=$selectedSeatNumber";
  }
}
