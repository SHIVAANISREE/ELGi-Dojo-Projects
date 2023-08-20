import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:share/share.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => ExportedData())],
    child: MyApp(),
  ));
}

class ExportedData extends ChangeNotifier {
  List<String> testData = [];
  List<String> description1Spec1 = [];
  List<String> description1Data1 = [];
  List<String> description1Data2 = [];
  List<String> description1Data3 = [];
  List<String> description2Spec2 = [];
  List<String> description2Actual = [];
  List<String> description2SPC = [];
  List<String> description2LoadPower = [];
  List<String> description2FAD = [];
  List<String> description2manometerData = [];
  List<String> description2P3 = [];
  List<String> description2P4 = [];
  List<String> description3Volts = [];
  List<String> description3Amps = [];
  List<String> description3Power = [];
  List<String> description3PF = [];
  List<String> description3fanReadings = [];
  List<String> description3VFDReadings = [];
  List<String> description3Inlet = [];
  List<String> description3Outlet = [];
  List<String> description4Data1 = [];
  List<String> description4Data2 = [];

  void updateTestData(List<String> newData) {
    testData = newData;
    notifyListeners();
  }

  void updateDescription1Data(List<String> newData) {
    description1Spec1 = newData;
    description1Data1 = newData;
    description1Data2 = newData;
    description1Data3 = newData;
    notifyListeners();
  }

  void updateDescription2Data(List<String> newData) {
    description2Spec2 = newData;
    description2Actual = newData;
    description2SPC = newData;
    description2LoadPower = newData;
    description2FAD = newData;
    description2manometerData = newData;
    description2P3 = newData;
    description2P4 = newData;
    notifyListeners();
  }

  void updateDescription3Data(List<String> newData) {
    description3Volts = newData;
    description3Amps = newData;
    description3Power = newData;
    description3PF = newData;
    description3fanReadings = newData;
    description3VFDReadings = newData;
    description3Inlet = newData;
    description3Outlet = newData;
    notifyListeners();
  }

  void updateDescription4Data(List<String> newData) {
    description4Data1 = newData;
    description4Data2 = newData;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ExportedData exportedData = ExportedData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[300],
        title: Text('Test Report'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.all(15.0)),
            SizedBox(
              width: 160.0,
              height: 60.0,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red[300]),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Test(exportedData: exportedData),
                    ),
                  );
                },
                child: Text(
                  'Test Report',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Test extends StatefulWidget {
  final ExportedData exportedData;

  const Test({Key? key, required this.exportedData}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  ExportedData exportedData = ExportedData();
  void navigateToNextPage() {
    widget.exportedData.testData =
        data.map((controller) => controller.text).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Description1(exportedData: widget.exportedData),
      ),
    );
  }

  final List<String> _test = [
    'Model',
    'FAB',
    'Nozzle Size',
    'Test Date',
    'TPL',
    'Corrected to Rated RPM',
  ];

  List<TextEditingController> data =
      List.generate(6, (_) => TextEditingController());

  @override
  void initState() {
    super.initState();
    loadSavedData();
  }

  void loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < _test.length; i++) {
      String savedData = prefs.getString('data_$i') ?? '';
      data[i].text = savedData;
    }
  }

  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < _test.length; i++) {
      prefs.setString('data_$i', data[i].text);
    }
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void resetData() {
    for (var controller in data) {
      controller.clear();
    }
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[300],
        title: Text('Test Report'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () async {
              await saveData();
            },
          ),
          IconButton(
            onPressed: () {
              setState(() {
                resetData();
              });
            },
            icon: Icon(Icons.delete_forever),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Table(
                  defaultColumnWidth: FixedColumnWidth(120.0),
                  columnWidths: {
                    0: FixedColumnWidth(140.0),
                    1: FixedColumnWidth(240.0),
                  },
                  border: TableBorder.all(color: Colors.black),
                  children: [
                    TableRow(
                      decoration: BoxDecoration(color: Colors.red[300]),
                      children: [
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Center(
                              child: Text('Test Report'),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Center(child: Text('Data')),
                          ),
                        ),
                      ],
                    ),
                    ...List.generate(_test.length, (index) {
                      return TableRow(
                        decoration: BoxDecoration(color: Colors.grey[300]),
                        children: [
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Center(
                                child: Text(_test[index]),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: TextFormField(
                                controller: data[index],
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[300],
        onPressed: () {
          navigateToNextPage();
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}

class Description1 extends StatefulWidget {
  final ExportedData exportedData;

  const Description1({Key? key, required this.exportedData}) : super(key: key);

  @override
  State<Description1> createState() => _Description1State();
}

class _Description1State extends State<Description1> {
  void navigateToNextPage() {
    widget.exportedData.description1Spec1 =
        spec1.map((controller) => controller.text).toList();
    widget.exportedData.description1Data1 =
        d1.map((controller) => controller.text).toList();
    widget.exportedData.description1Data2 =
        d2.map((controller) => controller.text).toList();
    widget.exportedData.description1Data3 =
        d3.map((controller) => controller.text).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Description2(exportedData: widget.exportedData),
      ),
    );
  }

  final List<String> _description1 = [
    'Time   (Start At)',
    'Duration   (in hrs)',
    'Loading   (%)',
    'Ambient Temp.   (Dbt)',
    'Ambient Temp.   (Wbt)',
    'Line Pressure   (bar/Kg/cm^2/PSI(g))',
    'Sump Pressure   (bar/Kg/cm^2/PSI(g))',
    'Cooling Water Pr.   (bar/Kg/cm^2(g))',
    'Air Oil Discharge Temp.',
    'Manometer Read.   (P3)',
    'Manometer Read.   (P4)',
    'Air Inlet Temp',
    'Air Outlet Temp',
    'Free Air Delivery   (CFM)',
    'Input Voltage   (V)',
    'Current with fan motor   (A)',
    'Frequency   (Hz)',
    'Input Power with Fan motor   (kW)',
    'Power Factor',
    'Speed   (Rpm)',
    'Fan Motor Current   (A)',
    'Fan Motor Input Power   (KW)',
    'Current without fan motor   (A)',
    'Input Power w/o Fan motor   (KW)',
  ];

  List<TextEditingController> spec1 =
      List.generate(25, (_) => TextEditingController());
  List<TextEditingController> d1 =
      List.generate(25, (_) => TextEditingController());
  List<TextEditingController> d2 =
      List.generate(25, (_) => TextEditingController());
  List<TextEditingController> d3 =
      List.generate(25, (_) => TextEditingController());

  @override
  void initState() {
    super.initState();
    loadSavedData1();
  }

  void loadSavedData1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < _description1.length; i++) {
      String savedData = prefs.getString('desc1_data_$i') ?? '';
      spec1[i].text = savedData;
      String savedD1 = prefs.getString('desc1_d1_$i') ?? '';
      d1[i].text = savedD1;
      String savedD2 = prefs.getString('desc1_d2_$i') ?? '';
      d2[i].text = savedD2;
      String savedD3 = prefs.getString('desc1_d3_$i') ?? '';
      d3[i].text = savedD3;
    }
  }

  Future<void> saveData1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < _description1.length; i++) {
      prefs.setString('desc1_data_$i', spec1[i].text);
      prefs.setString('desc1_d1_$i', d1[i].text);
      prefs.setString('desc1_d2_$i', d2[i].text);
      prefs.setString('desc1_d3_$i', d3[i].text);
    }
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void resetData() {
    for (var controller in spec1) {
      controller.clear();
    }
    for (var controller in d1) {
      controller.clear();
    }
    for (var controller in d2) {
      controller.clear();
    }
    for (var controller in d3) {
      controller.clear();
    }
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[300],
        title: Text('Description'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () async {
              await saveData1();
            },
          ),
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              setState(() {
                resetData();
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Table(
                  defaultColumnWidth: FixedColumnWidth(120.0),
                  columnWidths: {
                    0: FixedColumnWidth(200.0),
                    1: FixedColumnWidth(180.0),
                    2: FixedColumnWidth(100.0),
                    3: FixedColumnWidth(100.0),
                    4: FixedColumnWidth(100.0),
                  },
                  border: TableBorder.all(color: Colors.black),
                  children: [
                    TableRow(
                      decoration: BoxDecoration(color: Colors.red[300]),
                      children: [
                        TableCell(
                            child: Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Center(child: Text('Test No')))),
                        TableCell(
                            child: Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Center(child: Text('Spec')))),
                        TableCell(
                            child: Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Center(child: Text('1')))),
                        TableCell(
                            child: Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Center(child: Text('2')))),
                        TableCell(
                            child: Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Center(child: Text('3')))),
                      ],
                    ),
                    ...List.generate(
                      _description1.length,
                      (index) {
                        return TableRow(
                          decoration: BoxDecoration(color: Colors.grey[300]),
                          children: [
                            TableCell(
                                child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Center(
                                        child: Text(_description1[index])))),
                            TableCell(
                              child: Center(
                                child: TextFormField(
                                  controller: spec1[index],
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Center(
                                child: TextFormField(
                                  controller: d1[index],
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Center(
                                child: TextFormField(
                                  controller: d2[index],
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Center(
                                child: TextFormField(
                                  controller: d3[index],
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[300],
        onPressed: () {
          navigateToNextPage();
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}

class Description2 extends StatefulWidget {
  final ExportedData exportedData;
  const Description2({Key? key, required this.exportedData}) : super(key: key);

  @override
  State<Description2> createState() => _Description2State();
}

class _Description2State extends State<Description2> {
  ExportedData exportedData = ExportedData();

  void navigateToNextPage() {
    widget.exportedData.description2Spec2
        .addAll(Spec2.map((controller) => controller.text));
    widget.exportedData.description2Actual
        .addAll(Actual.map((controller) => controller.text));
    widget.exportedData.description2SPC.add(SPC.text);
    widget.exportedData.description2LoadPower.add(NoLoadPower.text);
    widget.exportedData.description2FAD.add(FAD.text);
    widget.exportedData.description2manometerData
        .addAll(manometerData.map((controller) => controller.text));
    widget.exportedData.description2P3.add(P3.text);
    widget.exportedData.description2P4.add(P4.text);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Description3(exportedData: widget.exportedData),
      ),
    );
  }

  final List<String> _description2 = [
    'Input Power   (KW)',
    'Shaft Power   (KW)',
    'Package Input Power   (KW)',
    'SPC   (PIP)',
    'Noload Power   (KW)',
  ];

  List<TextEditingController> Spec2 =
      List.generate(5, (_) => TextEditingController());
  List<TextEditingController> Actual =
      List.generate(5, (_) => TextEditingController());

  TextEditingController SPC = TextEditingController();
  TextEditingController NoLoadPower = TextEditingController();
  TextEditingController FAD = TextEditingController();
  TextEditingController P3 = TextEditingController();
  TextEditingController P4 = TextEditingController();

  final List<String> _manometerReadings = [
    '      P1',
    '      P2',
    '      P5',
    '      P6',
  ];

  List<TextEditingController> manometerData =
      List.generate(4, (_) => TextEditingController());

  @override
  void initState() {
    super.initState();
    loadSavedData2();
  }

  void loadSavedData2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < _description2.length; i++) {
      String savedSpec2Data = prefs.getString('desc2_spec2_data_$i') ?? '';
      Spec2[i].text = savedSpec2Data;

      String savedActualData = prefs.getString('desc2_actual_data_$i') ?? '';
      Actual[i].text = savedActualData;

      for (int j = 0; j < _manometerReadings.length; j++) {
        String savedManometerData =
            prefs.getString('desc2_manometerData_$j') ?? '';
        manometerData[j].text = savedManometerData;
      }
    }

    SPC.text = prefs.getString('desc2_spc') ?? '';
    NoLoadPower.text = prefs.getString('desc2_noLoadPower') ?? '';
    FAD.text = prefs.getString('desc2_fad') ?? '';
    P3.text = prefs.getString('desc2_p3') ?? '';
    P4.text = prefs.getString('desc2_p4') ?? '';
  }

  Future<void> saveData2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < _description2.length; i++) {
      prefs.setString('desc2_spec2_data_$i', Spec2[i].text);
      prefs.setString('desc2_actual_data_$i', Actual[i].text);
    }
    for (int j = 0; j < _manometerReadings.length; j++) {
      prefs.setString('desc2_manometerData_$j', manometerData[j].text);
    }

    prefs.setString('desc2_spc', SPC.text);
    prefs.setString('desc2_noLoadPower', NoLoadPower.text);
    prefs.setString('desc2_fad', FAD.text);
    prefs.setString('desc2_p3', P3.text);
    prefs.setString('desc2_p4', P4.text);

    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void resetData() {
    for (var controller in Spec2) {
      controller.clear();
    }
    for (var controller in Actual) {
      controller.clear();
    }
    for (var controller in manometerData) {
      controller.clear();
    }
    SPC.clear();
    NoLoadPower.clear();
    FAD.clear();
    P3.clear();
    P4.clear();
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[300],
          title: Text('Description'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () async {
                await saveData2();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Data saved successfully')),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: () {
                setState(() {
                  resetData();
                });
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Table(
                      defaultColumnWidth: FixedColumnWidth(120.0),
                      columnWidths: {
                        0: FixedColumnWidth(200.0),
                        1: FixedColumnWidth(180.0),
                        2: FixedColumnWidth(180.0),
                      },
                      border: TableBorder.all(color: Colors.black),
                      children: [
                        TableRow(
                          decoration: BoxDecoration(color: Colors.red[300]),
                          children: [
                            Padding(
                              padding: EdgeInsets.all(15.0),
                              child: TableCell(
                                child: Center(
                                  child: Text('Test No'),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15.0),
                              child: TableCell(
                                child: Center(
                                  child: Text('Spec'),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15.0),
                              child: TableCell(
                                child: Center(
                                  child: Text('Actual'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        ...List.generate(_description2.length, (index) {
                          return TableRow(
                              decoration:
                                  BoxDecoration(color: Colors.grey[300]),
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: TableCell(
                                    child: Center(
                                      child: Text(_description2[index]),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: TextFormField(
                                      controller: Spec2[index],
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: TextFormField(
                                      controller: Actual[index],
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]);
                        })
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Text(
                      '          SPC %          ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: SPC,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          labelText: 'SPC %',
                          labelStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Text(
                      'No Load Power %',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: NoLoadPower,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          labelText: 'No Load Power %',
                          labelStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Text(
                      '          FAD %          ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: FAD,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          labelText: 'FAD%',
                          labelStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        onChanged: (value) {
                          // Handle the text field value change if needed
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Table(
                      defaultColumnWidth: FixedColumnWidth(120.0),
                      columnWidths: {
                        0: FixedColumnWidth(200.0),
                        1: FixedColumnWidth(180.0),
                      },
                      border: TableBorder.all(color: Colors.black),
                      children: [
                        TableRow(
                            decoration: BoxDecoration(color: Colors.red[300]),
                            children: [
                              Padding(
                                padding: EdgeInsets.all(15.0),
                                child: TableCell(
                                  child: Center(
                                    child: Text('Manometer Reading'),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(15.0),
                                child: TableCell(
                                  child: Center(
                                    child: Text('Data'),
                                  ),
                                ),
                              ),
                            ]),
                        ...List.generate(_manometerReadings.length, (index) {
                          return TableRow(
                            decoration: BoxDecoration(color: Colors.grey[300]),
                            children: [
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: TableCell(
                                  child: Center(
                                    child: Text(_manometerReadings[index]),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Center(
                                  child: TextFormField(
                                    controller: manometerData[index],
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        })
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Text(
                      'P3',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: P3,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          labelText: 'P3 = P1 - P2',
                          labelStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        onChanged: (value) {
                          // Handle the text field value change if needed
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Text(
                      'P4',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: P4,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          labelText: 'P4 = P5 - P6',
                          labelStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red[300],
          onPressed: () {
            navigateToNextPage();
          },
          child: Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}

class Description3 extends StatefulWidget {
  final ExportedData exportedData;

  const Description3({Key? key, required this.exportedData}) : super(key: key);

  @override
  State<Description3> createState() => _Description3State();
}

class _Description3State extends State<Description3> {
  final exportedData = ExportedData();
  void navigateToNextPage() {
    widget.exportedData.description3Volts =
        Volts.map((controller) => controller.text).toList();
    widget.exportedData.description3Amps =
        Amps.map((controller) => controller.text).toList();
    widget.exportedData.description3Power =
        Power.map((controller) => controller.text).toList();
    widget.exportedData.description3PF =
        PF.map((controller) => controller.text).toList();
    widget.exportedData.description3fanReadings =
        fanReadings.map((controller) => controller.text).toList();
    widget.exportedData.description3VFDReadings =
        VFDReadings.map((controller) => controller.text).toList();
    widget.exportedData.description3Inlet.add(Inlet.text);
    widget.exportedData.description3Outlet.add(Outlet.text);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Description4(exportedData: widget.exportedData),
      ),
    );
  }

  final List<String> mainMotor = ['R', 'Y', 'B'];

  List<TextEditingController> Volts =
      List.generate(3, (_) => TextEditingController());
  List<TextEditingController> Amps =
      List.generate(3, (_) => TextEditingController());
  List<TextEditingController> Power =
      List.generate(3, (_) => TextEditingController());
  List<TextEditingController> PF =
      List.generate(3, (_) => TextEditingController());

  final List<String> fanMotor = ['Volts', 'Amps', 'Power', 'Hz', 'PF', 'RPM'];

  List<TextEditingController> fanReadings =
      List.generate(6, (_) => TextEditingController());
  List<TextEditingController> VFDReadings =
      List.generate(6, (_) => TextEditingController());

  TextEditingController Inlet = TextEditingController();
  TextEditingController Outlet = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadSavedData3();
  }

  void loadSavedData3() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < mainMotor.length; i++) {
      String savedSpec2Data = prefs.getString('desc3_volts_data_$i') ?? '';
      Volts[i].text = savedSpec2Data;

      String savedActualData = prefs.getString('desc3_amps_data_$i') ?? '';
      Amps[i].text = savedActualData;

      String savedPowerData = prefs.getString('desc3_power_data_$i') ?? '';
      Power[i].text = savedPowerData;

      String savedPFData = prefs.getString('desc3_pf_data_$i') ?? '';
      PF[i].text = savedPFData;

      for (int j = 0; j < fanMotor.length; j++) {
        String savedFanReadings = prefs.getString('desc3_fanReadings_$j') ?? '';
        fanReadings[j].text = savedFanReadings;

        String savedVFDReadings = prefs.getString('desc3_VFDReadings_$j') ?? '';
        VFDReadings[j].text = savedVFDReadings;

        Inlet.text = prefs.getString('desc3_inlet') ?? '';
        Outlet.text = prefs.getString('desc3_outlet') ?? '';
      }
    }
  }

  Future<void> saveData3() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < mainMotor.length; i++) {
      prefs.setString('desc3_volts_data_$i', Volts[i].text);
      prefs.setString('desc3_amps_data_$i', Amps[i].text);
      prefs.setString('desc3_power_data_$i', Power[i].text);
      prefs.setString('desc3_pf_data_$i', PF[i].text);
    }
    for (int j = 0; j < fanMotor.length; j++) {
      prefs.setString('desc3_fanReadings_$j', fanReadings[j].text);
      prefs.setString('desc3_VFDReadings_$j', VFDReadings[j].text);
    }

    prefs.setString('desc3_inlet', Inlet.text);
    prefs.setString('desc3_outlet', Outlet.text);

    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void resetData() {
    for (var controller in Volts) {
      controller.clear();
    }
    for (var controller in Amps) {
      controller.clear();
    }
    for (var controller in Power) {
      controller.clear();
    }
    for (var controller in PF) {
      controller.clear();
    }
    for (var controller in fanReadings) {
      controller.clear();
    }
    for (var controller in VFDReadings) {
      controller.clear();
    }
    Inlet.clear();
    Outlet.clear();
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[300],
          title: Text('Main Motor Power Details'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () async {
                await saveData3();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Data saved successfully')),
                );
              },
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    resetData();
                  });
                },
                icon: Icon(Icons.delete_forever))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Table(
                      defaultColumnWidth: FixedColumnWidth(120.0),
                      columnWidths: {
                        0: FixedColumnWidth(200.0),
                        1: FixedColumnWidth(180.0),
                        2: FixedColumnWidth(100.0),
                        3: FixedColumnWidth(100.0),
                        4: FixedColumnWidth(100.0),
                      },
                      border: TableBorder.all(color: Colors.black),
                      children: [
                        TableRow(
                          decoration: BoxDecoration(color: Colors.red[300]),
                          children: [
                            Padding(
                              padding: EdgeInsets.all(15.0),
                              child: TableCell(
                                child: Center(
                                  child: Text('Phase'),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15.0),
                              child: TableCell(
                                  child: Center(child: Text('Volts'))),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15.0),
                              child:
                                  TableCell(child: Center(child: Text('Amps'))),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15.0),
                              child: TableCell(
                                  child: Center(child: Text('Power'))),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15.0),
                              child:
                                  TableCell(child: Center(child: Text('PF'))),
                            ),
                          ],
                        ),
                        ...List.generate(mainMotor.length, (index) {
                          return TableRow(
                            decoration: BoxDecoration(color: Colors.grey[300]),
                            children: [
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: TableCell(
                                    child: Center(
                                  child: Text(mainMotor[index]),
                                )),
                              ),
                              TableCell(
                                child: Center(
                                  child: TextFormField(
                                    controller: Volts[index],
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Center(
                                  child: TextFormField(
                                    controller: Amps[index],
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Center(
                                  child: TextFormField(
                                    controller: Power[index],
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Center(
                                  child: TextFormField(
                                    controller: PF[index],
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        })
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Table(
                      defaultColumnWidth: FixedColumnWidth(120.0),
                      columnWidths: {
                        0: FixedColumnWidth(200.0),
                        1: FixedColumnWidth(180.0),
                        2: FixedColumnWidth(180.0),
                      },
                      border: TableBorder.all(color: Colors.black),
                      children: [
                        TableRow(
                          decoration: BoxDecoration(color: Colors.red[300]),
                          children: [
                            Padding(
                              padding: EdgeInsets.all(15.0),
                              child: TableCell(
                                  child: Center(
                                child: Text('Fan Motor'),
                              )),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15.0),
                              child: TableCell(
                                  child: Center(
                                child: Text('Fan Motor Readings'),
                              )),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15.0),
                              child: TableCell(
                                  child: Center(
                                child: Text('VFD Readings'),
                              )),
                            ),
                          ],
                        ),
                        ...List.generate(fanMotor.length, (index) {
                          return TableRow(
                            decoration: BoxDecoration(color: Colors.grey[300]),
                            children: [
                              TableCell(
                                  child: Padding(
                                padding: EdgeInsets.all(13.0),
                                child: TableCell(
                                  child: Center(
                                    child: Text(fanMotor[index]),
                                  ),
                                ),
                              )),
                              TableCell(
                                child: Center(
                                  child: TextFormField(
                                    controller: fanReadings[index],
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Center(
                                  child: TextFormField(
                                    controller: VFDReadings[index],
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        })
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      ' Inlet ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                        child: TextField(
                      controller: Inlet,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        labelText: 'Cooling Water Inlet Temperature',
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      onChanged: (value) {},
                    ))
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      'Outlet',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                        child: TextField(
                      controller: Outlet,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        labelText: 'Cooling Water Outlet Temperature',
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      onChanged: (value) {},
                    ))
                  ],
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red[300],
          onPressed: () {
            navigateToNextPage();
          },
          child: Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}

class Description4 extends StatefulWidget {
  final ExportedData exportedData;

  const Description4({Key? key, required this.exportedData}) : super(key: key);

  @override
  State<Description4> createState() => _Description4State();
}

class _Description4State extends State<Description4> {
  void navigateToExportPage() {
    widget.exportedData.description4Data1 =
        _data1.map((controller) => controller.text).toList();
    widget.exportedData.description4Data2 =
        _data2.map((controller) => controller.text).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExportPage(exportedData: widget.exportedData),
      ),
    );
  }

  final List<String> _description4 = [
    'Safety Valve: WP+3 Kg/cm^2(g)',
    'High Dish.Temp. Switch/Transmitter',
    'High Sump Pr. Switch: WP+2 Kg/cm^2(g)',
    'Unloading Pressure',
    'Unloading Auto trip & Restart',
    'Main/Fan Over Load Trip',
    'Power Auto ON',
    'Reverse Direction Trip',
    'Separator Continuity Test',
    'Low Water Pr. Switch Trip',
  ];

  List<TextEditingController> _data1 =
      List.generate(10, (_) => TextEditingController());
  List<TextEditingController> _data2 =
      List.generate(10, (_) => TextEditingController());

  @override
  void initState() {
    super.initState();
    loadSavedData4();
  }

  void loadSavedData4() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < _description4.length; i++) {
      String savedData1 = prefs.getString('desc4_data1_$i') ?? '';
      _data1[i].text = savedData1;
      String savedData2 = prefs.getString('desc4_data2_$i') ?? '';
      _data2[i].text = savedData2;
    }
  }

  Future<void> saveData4() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < _description4.length; i++) {
      prefs.setString('desc4_data1_$i', _data1[i].text);
      prefs.setString('desc4_data2_$i', _data2[i].text);
    }

    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void resetData() {
    for (var controller in _data1) {
      controller.clear();
    }
    for (var controller in _data2) {
      controller.clear();
    }
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[300],
          title: Text('Safety Setting Details'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () async {
                await saveData4();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Data saved successfully')),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: () {
                setState(() {
                  resetData();
                });
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Table(
                    defaultColumnWidth: FixedColumnWidth(120.0),
                    columnWidths: {
                      0: FixedColumnWidth(250.0),
                      1: FixedColumnWidth(180.0),
                      2: FixedColumnWidth(180.0),
                    },
                    border: TableBorder.all(color: Colors.black),
                    children: [
                      TableRow(
                        decoration: BoxDecoration(color: Colors.red[300]),
                        children: [
                          TableCell(
                              child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Center(
                              child: Text('Safety Setting Details'),
                            ),
                          )),
                          TableCell(
                              child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Center(
                              child: Text('Data1'),
                            ),
                          )),
                          TableCell(
                              child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Center(
                              child: Text('Data2'),
                            ),
                          )),
                        ],
                      ),
                      ...List.generate(_description4.length, (index) {
                        return TableRow(
                          decoration: BoxDecoration(color: Colors.grey[300]),
                          children: [
                            TableCell(
                                child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Center(
                                child: Text(_description4[index]),
                              ),
                            )),
                            TableCell(
                                child: Center(
                              child: TextFormField(
                                controller: _data1[index],
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                ),
                              ),
                            )),
                            TableCell(
                                child: Center(
                              child: TextFormField(
                                controller: _data2[index],
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                ),
                              ),
                            )),
                          ],
                        );
                      })
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(120.0, 20.0, 30.0, 20.0),
                    child: SizedBox(
                      width: 90.0,
                      height: 60.0,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red[300]),
                        ),
                        onPressed: () {
                          navigateToExportPage();
                        },
                        child: Icon(
                          Icons.file_upload_outlined,
                          size: 35.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ExportPage extends StatelessWidget {
  final ExportedData exportedData;

  const ExportPage({Key? key, required this.exportedData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[300],
        title: Text('Exported Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Exported Data:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Test Report:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Data: ${exportedData.testData}'),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Description1:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Spec: ${exportedData.description1Spec1}'),
                Text('1: ${exportedData.description1Data1}'),
                Text('2: ${exportedData.description1Data2}'),
                Text('3: ${exportedData.description1Data3}'),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Description2:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Spec: ${exportedData.description2Spec2}'),
                Text('Actual: ${exportedData.description2Actual}'),
                Text('SPC %: ${exportedData.description2SPC}'),
                Text('No Load Power %: ${exportedData.description2LoadPower}'),
                Text('FAD %: ${exportedData.description2FAD}'),
                Text(
                    'Manometer Reading: ${exportedData.description2manometerData}'),
                Text('P3: ${exportedData.description2P3}'),
                Text('P4: ${exportedData.description2P4}'),
              ],
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Main Motor and Fan Motor Readings:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Volts: ${exportedData.description3Volts}'),
                Text('Amps: ${exportedData.description3Amps}'),
                Text('Power: ${exportedData.description3Power}'),
                Text('PF: ${exportedData.description3PF}'),
                Text(
                    'Fan Motor Readings: ${exportedData.description3fanReadings}'),
                Text('VFD Readings: ${exportedData.description3VFDReadings}'),
                Text('Inlet: ${exportedData.description3Inlet}'),
                Text('Outlet: ${exportedData.description3Outlet}'),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Safety Setting Details:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Data1: ${exportedData.description4Data1}'),
                Text('Data2: ${exportedData.description4Data2}'),
              ],
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[300],
        onPressed: () {
          String formattedData = """
Test Report:
Data: ${exportedData.testData.join(', ')}

Description1:
Spec: ${exportedData.description1Spec1.join(', ')}
1: ${exportedData.description1Data1.join(', ')}
2: ${exportedData.description1Data2.join(', ')}
3: ${exportedData.description1Data3.join(', ')}

Description2:
Spec: ${exportedData.description2Spec2.join(', ')}
Actual: ${exportedData.description2Actual.join(', ')}
SPC %: ${exportedData.description2SPC}
No Load Power %: ${exportedData.description2LoadPower}
FAD %: ${exportedData.description2FAD}
Manometer Reading: ${exportedData.description2manometerData.join(', ')}
P3: ${exportedData.description2P3}
P4: ${exportedData.description2P4}

Main Motor and Fan Motor Readings:
Volts: ${exportedData.description3Volts}
Amps: ${exportedData.description3Amps}
Power: ${exportedData.description3Power}
PF: ${exportedData.description3PF}
Fan Motor Readings: ${exportedData.description3fanReadings.join(', ')}
VFD Readings: ${exportedData.description3VFDReadings.join(', ')}
Inlet: ${exportedData.description3Inlet}
Outlet: ${exportedData.description3Outlet}

Safety Setting Details:
Data1: ${exportedData.description4Data1.join(', ')}
Data2: ${exportedData.description4Data2.join(', ')}
""";
          Share.share(formattedData);
        },
        child: Icon(Icons.share_outlined),
      ),
    );
  }
}
