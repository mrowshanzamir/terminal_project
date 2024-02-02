import 'bus.dart';

class Travel {
  String start;
  String destination;
  Bus busTravel;
  late String travelType;
  int price;
  int travelIncome = 0;


  Travel({
    required this.start,
    required this.destination,
    required this.busTravel,
    required this.price,
  }) {
    this.travelType = busTravel.busType;
  }

  @override
  String toString() {
    return "start:$start, destination:$destination, bus:$busTravel, price:$price";
  }
}
