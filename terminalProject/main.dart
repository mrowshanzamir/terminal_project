import 'dart:io';
import 'sales_management.dart';

void main(){

  SalesManager salesManager = SalesManager();
  //////////////////////////////////////////////////////////////////////////////
  // Passenger passenger1 = Passenger(
  //   pName: "Reza",
  //   pLastName: "Rowshanzamir",
  //   pNationalCode: "2282970128",
  // );
  // SalesManager.passengersList.add(passenger1);
  //////////////////////////////////////////////////////////////////////////////
  while(true){

    print('\n1- Define new bus\n2- Define new travel\n3- Display available travels\n'
        '4- Reserve a ticket\n5- Buy ticket\n6- Cancel ticket\n7- Report a travel'
        '\n8- Exit');
    print('Enter your choice:');

    int choice = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

    switch (choice) {
      case 1:
        salesManager.defineNewBus();
        break;
      case 2:
        salesManager.defineNewTravel();
        break;
      case 3:
        salesManager.displayAvailableTravels();
        break;
      case 4:
        salesManager.ticketReservation();
        break;
      case 5:
        salesManager.buyTicket();
        break;
      case 6:
        salesManager.cancelTicket();
        break;
      case 7:
        salesManager.reportTravel();
        break;
      case 8:
        return;
      default:
        print('Invalid choice! Please enter a number between 1 and 6.');
    }
  }
  //////////////////////////////////////////////////////////////////////////////

}