class Bus {
  final String busName;
  final String busType;
  final int numberOfBusSeats;
  List<String> busSeats = [];

  Bus.economy({required this.busName})
      : busType = "economy",
        numberOfBusSeats = 44,
        busSeats=[
          "01",
          "02",
          "03",
          "04",
          "05",
          "06",
          "07",
          "08",
          "09",
          "10",
          "11",
          "12",
          "13",
          "14",
          "15",
          "16",
          "17",
          "18",
          "19",
          "20",
          "21",
          "22",
          "23",
          "24",
          "25",
          "26",
          "27",
          "28",
          "29",
          "30",
          "31",
          "32",
          "33",
          "34",
          "35",
          "36",
          "37",
          "38",
          "39",
          "40",
          "41",
          "42",
          "43",
          "44",
        ];

  Bus.vip({required this.busName})
      : busType = "vip",
        numberOfBusSeats = 30,
        busSeats=[
          "01",
          "02",
          "03",
          "04",
          "05",
          "06",
          "07",
          "08",
          "09",
          "10",
          "11",
          "12",
          "13",
          "14",
          "15",
          "16",
          "17",
          "18",
          "19",
          "20",
          "21",
          "22",
          "23",
          "24",
          "25",
          "26",
          "27",
          "28",
          "29",
          "30",
        ];

  void showSeats(){
    if(busType == 'economy') {
      print('''
    ${busSeats[0]}  ${busSeats[1]}    ${busSeats[2]}  ${busSeats[3]}
    ${busSeats[4]}  ${busSeats[5]}    ${busSeats[6]}  ${busSeats[7]}
    ${busSeats[8]}  ${busSeats[9]}    ${busSeats[10]}  ${busSeats[11]}
    ${busSeats[12]}  ${busSeats[13]}    ${busSeats[14]}  ${busSeats[15]}
    ${busSeats[16]}  ${busSeats[17]}    ${busSeats[18]}  ${busSeats[19]}
    ${busSeats[20]}  ${busSeats[21]}
    ${busSeats[22]}  ${busSeats[23]}
    ${busSeats[24]}  ${busSeats[25]}    ${busSeats[26]}  ${busSeats[27]}
    ${busSeats[28]}  ${busSeats[29]}    ${busSeats[30]}  ${busSeats[31]}
    ${busSeats[32]}  ${busSeats[33]}    ${busSeats[34]}  ${busSeats[35]}
    ${busSeats[36]}  ${busSeats[37]}    ${busSeats[38]}  ${busSeats[39]}
    ${busSeats[40]}  ${busSeats[41]}    ${busSeats[42]}  ${busSeats[43]}
    ''');
    }
    else if(busType == 'vip'){
      print('''
    ${busSeats[0]}    ${busSeats[1]}  ${busSeats[2]}
    ${busSeats[3]}    ${busSeats[4]}  ${busSeats[5]}
    ${busSeats[6]}    ${busSeats[7]}  ${busSeats[8]}
    ${busSeats[9]}    ${busSeats[10]}  ${busSeats[11]}
    ${busSeats[12]}    ${busSeats[13]}  ${busSeats[14]}
    ${busSeats[15]}
    ${busSeats[16]}
    ${busSeats[17]}
    ${busSeats[18]}    ${busSeats[19]}  ${busSeats[20]}
    ${busSeats[21]}    ${busSeats[22]}  ${busSeats[23]}
    ${busSeats[24]}    ${busSeats[25]}  ${busSeats[26]}
    ${busSeats[27]}    ${busSeats[28]}  ${busSeats[29]}
    ''');
    }
  }

  int availableSeats() {
    int occupiedSeats = busSeats.where((seat) => (seat == 'rr'|| seat == 'bb')).length;
    return numberOfBusSeats - occupiedSeats;
  }



  @override
  String toString() {
    return "$busName($busType)";
  }
}

