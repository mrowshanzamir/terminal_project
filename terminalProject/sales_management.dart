import 'dart:io';
import 'bus.dart';
import 'ticket.dart';
import 'travel.dart';

class SalesManager {

  List<Bus> busesList = [];
  List<Bus> economyBusesList = [];
  List<Bus> vipBusesList = [];
  List<Travel> travelsList = [];
  static List<Ticket> ticketsList = [];

  //////////////////////////////////////////////////////////////////////////////

  void defineNewBus() {
    String name;
    int busType;

    while (true) {
      print("Enter the bus name (0 to cancel)");
      name = stdin.readLineSync() ?? '';
      if (name == '0') return;
      if (name.trim().isEmpty) {
        print("Invalid input! Please enter a non-empty string for the name.");
        continue;
      }
      break;
    }

    busType = getBusType();
    if(busType == 0) return;

    if (busType == 1) {
      Bus bus = Bus.economy(busName: name);
      economyBusesList.add(bus);
      busesList.add(bus);
    } else if (busType == 2) {
      Bus bus = Bus.vip(busName: name);
      vipBusesList.add(bus);
      busesList.add(bus);
    }
    print(
        "the new bus \'$name(${busType == 1 ? 'economy' : 'vip'})\', Successfully added");
  }

  //////////////////////////////////////////////////////////////////////////////

  void defineNewTravel() {
    ////////////check is there any buses to select?!
    if (busesList.isEmpty) {
      print(
          "No bus is defined or available! First go and define a new bus and then try again ...");
      return;
    }

    int busType;
    while (true) {

      busType = getBusType();
      if(busType == 0) return;
      ////////////////////////

      ///////////////check is there any buses of this busType to select?!
      if (busType == 1 && economyBusesList.isEmpty) {
        print(
            "No economy bus is available!!! Choose a vip bus or first define an economy bus and then try again ...");
      } else if (busType == 2 && vipBusesList.isEmpty) {
        print(
            "No vip bus is available!!! Choose an economy bus or first define an vip bus and then try again ...");
      } else {
        break;
      }
    }
    ///////////////select bus
    Bus selectedBus;
    while (true) {
      if (busType == 1) {
        //print economy buses
        for (int i = 0; i < economyBusesList.length; i++) {
          print("${i + 1}- ${economyBusesList[i]}");
        }
      } else if (busType == 2) {
        //print vip buses
        for (int i = 0; i < vipBusesList.length; i++) {
          print("${i + 1}- ${vipBusesList[i]}");
        }
      }

      int selectedBusIndex;
      print("Enter the bus number:");
      int busNumber = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
      if (busNumber <= 0 ||
          (busType == 1 && busNumber > economyBusesList.length) ||
          (busType == 2 && busNumber > vipBusesList.length)) {
        print("Invalid input! try again...");
        continue;
      }
      selectedBusIndex = busNumber - 1;
      selectedBus = busType == 1
          ? economyBusesList[selectedBusIndex]
          : vipBusesList[selectedBusIndex];
      break;
    }
    ///////////////travel starting point
    String stringPoint = getTravelStartingOrDestinationPoint(whichPoint: "starting point");
    ///////////////travel destination point
    String destinationPoint = getTravelStartingOrDestinationPoint(whichPoint: "destination point");
    ///////////////travel price
    int price;
    while (true) {
      print("Determine the price of the ticket of this travel: ");
      price = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
      if (price == -1) {
        print("Invalid input! try again ...");
      } else if (price == 0) {
        print("the price can not be free or zero! try again ...");
      }
      else if(price<0){
        print("Price can not be negative! Try again ...");
      }
      else {
        break;
      }
    }

    Travel newTravel = Travel(
      start: stringPoint,
      destination: destinationPoint,
      busTravel: selectedBus,
      price: price,
    );
    travelsList.add(newTravel);
  }

  //////////////////////////////////////////////////////////////////////////////

  int displayAvailableTravels() {
    if (travelsList.isEmpty) {
      print("No travel is defined!");
      return 0;
    } else {
      print("Available travels: ");
      for (int i = 0; i < travelsList.length; i++) {
        print("${i + 1}- ${travelsList[i]}");
      }
      return 1;
    }
  }

  //////////////////////////////////////////////////////////////////////////////
  // String? mainSelectedSeatNumber;
  // int debtPrice = 0;
  // int travelPrice = 0;

  void ticketReservation() {
    while (true) {
      int check = displayAvailableTravels();
      int selectedTravel;

      if (check == 0) {
        return;
      } else {
        print("choose a travel to reserve(0 to cancel): ");
        selectedTravel = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
        if (selectedTravel == 0) {
          return;
        } else if (selectedTravel < 0 || selectedTravel > travelsList.length) {
          print("Invalid input! Try again ...");
          continue;
        } else {
          Ticket newTicket;
          int travelPrice = travelsList[selectedTravel - 1].price;

          while (true) {
            print("Bus seats: ");
            travelsList[selectedTravel - 1].busTravel.showSeats();
            print("Select a seat(by written format- 0 or 00 to cancel): ");
            int selectedSeat = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
            if (selectedSeat == 0)
              return;
            else if (selectedSeat < 0 ||
                selectedSeat >
                    travelsList[selectedTravel - 1]
                        .busTravel
                        .numberOfBusSeats) {
              print("Invalid seat number! Try again ...");
              continue;
            } else {
              String mainSelectedSeatNumber = travelsList[selectedTravel - 1]
                  .busTravel
                  .busSeats[selectedSeat - 1];
              if (mainSelectedSeatNumber == 'rr') {
                print(
                    "Sorry, This seat has already been reserved! choose another one please.");
                continue;
              }
              if (mainSelectedSeatNumber == 'bb') {
                print(
                    "Sorry, This seat has already been sold! choose another one please.");
                continue;
              }

              travelsList[selectedTravel - 1]
                  .busTravel
                  .busSeats[selectedSeat - 1] = "rr";

              newTicket = Ticket.reserve(
                travel: travelsList[selectedTravel - 1],
                ticketPrice: travelPrice,
                selectedSeatNumber: mainSelectedSeatNumber,
              );
              ticketsList.add(newTicket);
              // debtPrice = travelPrice - (travelPrice * .3).toInt();
              // print("***you should pay 30% of the whole travel price($travelPrice) for reservation***,\n"
              //     "* whole travel price: $travelPrice\$ - * Now you should pay ${(travelPrice*.3).toInt()}\$ - "
              //     "* debt price = $debtPrice\$");
              print(
                  "------------------------------------------------------------------------------------------------------------------------------");
              print(
                  "***you should pay 30% of the whole travel price($travelPrice\$) for this reservation***");
              print("***Ticket successfully reserved: ");
              // print(
              //     "Seat number ${newTicket.selectedSeatNumber} reserved:) (payed: ${newTicket.payedPrice}\$ - dept: ${newTicket.deptPrice}\$ )");
              travelsList[selectedTravel-1].travelIncome += newTicket.paidPrice;
              print(
                  "$newTicket, **payed: ${newTicket.paidPrice}\$ - **dept: ${newTicket.passengerDeptPrice}\$");
              print("${newTicket.paidPrice}\$ added to travel income. <Total travel income until now: ${travelsList[selectedTravel-1].travelIncome}\$>");
              print(
                  "------------------------------------------------------------------------------------------------------------------------------");
              return;
            }
          }
        }
      }
    }
  }

  //////////////////////////////////////////////////////////////////////////////

  void buyTicket() {
    while (true) {
      int check = displayAvailableTravels();
      int selectedTravel;

      if (check == 0) {
        return;
      } else {
        print("choose a travel to buy ticket (0 to cancel): ");
        selectedTravel = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
        if (selectedTravel == 0) {
          return;
        } else if (selectedTravel < 0 || selectedTravel > travelsList.length) {
          print("Invalid input! Try again ...");
          continue;
        } else {
          Ticket newTicket;
          int travelPrice = travelsList[selectedTravel - 1].price;

          while (true) {
            print("Bus seats: ");
            travelsList[selectedTravel - 1].busTravel.showSeats();
            print("Select a seat(by written format- 0 or 00 to cancel): ");
            int selectedSeat = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
            if (selectedSeat == 0)
              return;
            else if (selectedSeat < 0 ||
                selectedSeat >
                    travelsList[selectedTravel - 1]
                        .busTravel
                        .numberOfBusSeats) {
              print("Invalid seat number! Try again ...");
              continue;
            } else {
              String mainSelectedSeatNumber = travelsList[selectedTravel - 1]
                  .busTravel
                  .busSeats[selectedSeat - 1];
              if (mainSelectedSeatNumber == 'rr') {
                print(
                    "Sorry, This seat has already been reserved! choose another one please.");
                continue;
              }
              if (mainSelectedSeatNumber == 'bb') {
                print(
                    "Sorry, This seat has already been sold! choose another one please.");
                continue;
              }

              travelsList[selectedTravel - 1]
                  .busTravel
                  .busSeats[selectedSeat - 1] = "bb";


              newTicket = Ticket.buy(
                travel: travelsList[selectedTravel - 1],
                ticketPrice: travelPrice,
                selectedSeatNumber: mainSelectedSeatNumber,
              );
              ticketsList.add(newTicket);


              print(
                  "------------------------------------------------------------------------------------------------------------------------------");
              print(
                  "***passenger should pay the whole travel price($travelPrice\$) to buy a ticket***");
              travelsList[selectedTravel-1].travelIncome += travelPrice;
              print("***Ticket successfully bought: ");
              print(
                  "$newTicket, **payed: ${newTicket.paidPrice}\$ - **dept: ${newTicket.passengerDeptPrice}\$");
              print("${newTicket.paidPrice}\$ added to travel income. <Total travel income until now: ${travelsList[selectedTravel-1].travelIncome}\$>");
              print(
                  "------------------------------------------------------------------------------------------------------------------------------");
              return;
            }
          }
        }
      }
    }
  }

  //////////////////////////////////////////////////////////////////////////////

  void cancelTicket() {
    while (true) {
      int check = displayAvailableTravels();
      int selectedTravel;

      if (check == 0) {
        return;
      } else {
        print("choose a travel to cancel a ticket (0 to cancel): ");
        selectedTravel = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
        if (selectedTravel == 0) {
          return;
        } else if (selectedTravel < 0 || selectedTravel > travelsList.length) {
          print("Invalid input! Try again ...");
          continue;
        } else {

          while (true) {
            print("Bus seats: ");
            travelsList[selectedTravel - 1].busTravel.showSeats();
            print("Select a seat to free its ticket (by written format- 0 or 00 to cancel): ");
            int selectedSeat = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
            if (selectedSeat == 0)
              return;
            else if (selectedSeat < 0 ||
                selectedSeat >
                    travelsList[selectedTravel - 1]
                        .busTravel
                        .numberOfBusSeats) {
              print("Invalid seat number! Try again ...");
              continue;
            } else {
              String mainSelectedSeatNumber = travelsList[selectedTravel - 1]
                  .busTravel
                  .busSeats[selectedSeat - 1];
              if (mainSelectedSeatNumber != 'rr' && mainSelectedSeatNumber != 'bb') {
                print(
                    "Seat number $mainSelectedSeatNumber is already empty and no ticket has been issued for it :)");
                return;
              }
              else{
                ticketsList.forEach((ticket) {
                  if(ticket.travel == travelsList[selectedTravel - 1] && int.parse(ticket.selectedSeatNumber) == selectedSeat){
                    int tempCanceledFee;
                    if(travelsList[selectedTravel - 1].busTravel.busSeats[selectedSeat-1] == 'bb'){
                      tempCanceledFee = 10;
                      ticket.passengerOwedPrice = ((ticket.paidPrice)*.9).toInt();
                      travelsList[selectedTravel-1].travelIncome -= ticket.passengerOwedPrice;
                    }
                    else{
                      tempCanceledFee = 20;
                      ticket.passengerOwedPrice = ((ticket.paidPrice)*.8).toInt();
                      ticket.passengerDeptPrice = 0;
                      travelsList[selectedTravel-1].travelIncome -= ticket.passengerOwedPrice;

                    }
                    travelsList[selectedTravel - 1].busTravel.busSeats[selectedSeat-1]=ticket.selectedSeatNumber;

                    print(
                        "------------------------------------------------------------------------------------------------------------------------------");
                    print(
                        "<Selected ticket canceled successfully. Now the seat number $selectedSeat is available to buy or reservation");
                    print("$ticket");
                    print("The cancellation fee of the reserved ticket is $tempCanceledFee% of the paid amount, equivalent to ${((ticket.paidPrice)*tempCanceledFee*.01).toInt()}\$");
                    print("${ticket.passengerOwedPrice}\$ returned to passenger");
                    print("Travel income of this ticket changed to ${((ticket.paidPrice)*tempCanceledFee*.01).toInt()}\$. <Total travel income until now: ${travelsList[selectedTravel-1].travelIncome}\$>");
                    print(
                        "------------------------------------------------------------------------------------------------------------------------------");
                    ticket.mode = "cancelled!";
                    return;
                  }
                });

              }
              return;
            }
          }
        }
      }
    }

  }

  //////////////////////////////////////////////////////////////////////////////

  void reportTravel() {
    if (travelsList.isEmpty) {
      print("No travel is defined!");
      return;
    }

    print("Available Travels:");
    for (int i = 0; i < travelsList.length; i++) {
      print("${i + 1}- ${travelsList[i]}");
    }

    print("Choose a travel to generate a report (0 to cancel): ");
    int selectedTravelIndex = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

    if (selectedTravelIndex <= 0 ||
        selectedTravelIndex > travelsList.length) {
      print("Invalid input! Report generation canceled.");
      return;
    }

    Travel selectedTravel = travelsList[selectedTravelIndex - 1];
    print("///////////////////////////////////////////////////////////////////");
    print("\n*** Travel Report for ${selectedTravel}:");

    print("Start: ${selectedTravel.start}");
    print("Destination: ${selectedTravel.destination}");
    print("Bus: ${selectedTravel.busTravel}");
    print("Price per Ticket: ${selectedTravel.price}\$");
    print("Number of Seats: ${selectedTravel.busTravel.numberOfBusSeats}");
    print("Available Seats: ${selectedTravel.busTravel.availableSeats()}");
    print("Total Income from this Travel: ${selectedTravel.travelIncome}\$");
    print("///////////////////////////////////////////////////////////////////");

    print("*** Tickets: ");
    ticketsList.forEach((element) {
      print("$element, Paid_Price=${element.paidPrice}\$, Dept:${element.passengerDeptPrice}\$, Owed:${element.passengerOwedPrice}\$");
    });
    print("///////////////////////////////////////////////////////////////////");
  }

  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  int getBusType(){
    int busType;
    while (true) {
      print(
          "Select the bus type by entering 1 or 2 (0 to cancel)\n1- economy\n2- vip");
      busType = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
      if (busType == 0) {
        return 0;
      } else if (busType == -1 || (busType != 1 && busType != 2)) {
        print("Invalid input! try again ...");
      }
      else {
        break;
      }
    }
    return busType;
  }

  String getTravelStartingOrDestinationPoint({required String whichPoint}){
    String point;
    while (true) {
      print("Enter an $whichPoint: ");
      point = stdin.readLineSync() ?? '';
      if (point.trim().isEmpty) {
        print("Invalid input! Please enter a non-empty string for travel $whichPoint.");
        continue;
      } else {
        break;
      }
    }
    return point;
  }
}
