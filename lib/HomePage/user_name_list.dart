// ignore_for_file: avoid_print, library_private_types_in_public_api, dead_code, use_build_context_synchronously, unused_local_variable, unused_element, deprecated_member_use
import 'package:doodhwala/Add_Data/Add%20&%20Get%20Quantity/view.dart';
import 'package:doodhwala/Add_Data/Add_User_Name_data/add_user_name_data.dart';
import 'package:doodhwala/themes/Light_Dark_theme/themes_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../model/User_name_model_class/model.dart';
import 'package:doodhwala/HomePage/home_page.dart';

//---Class
class Dudhwale extends StatefulWidget {
  final ThemeController themeController = Get.put(ThemeController());
  Dudhwale({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Dudhwale> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ThemeController themeController = Get.find<ThemeController>();
  // final QuantityController controller = Get.put(QuantityController());
  List<DudhWala> items = [];
  bool isSorted = false;

  void _sortItemsCombine() {
    // _sortedItemsname();
    _sortedItemid();
  }

  void _sortItemsname() {
    setState(() {
      items.sort(
            (a, b) => a.username.compareTo(b.username),

      );
    });
  }

  void _sortedItemid() {
    setState(() {
      items.sort(
            (a, b) => a.idno.compareTo(b.idno),
      );
    });
  }


  //--- Add User Name Data
  Future<String> addData({
    required String username,
    required String idno,
    required String phoneno,
  }) async {
    const String scriptUrl =
        'https://script.google.com/macros/s/AKfycbzFjcI8TbRFmEqDikIMYE10A9UzZeMY1H7L1IcbxWtOhtLezo5bNgGvbnYeRLlQhvRB/exec';
    try {
      final Uri uri = Uri.parse('$scriptUrl?action=addData&'
          'username=$username&'
          'idno=$idno&'
          'phoneno=$phoneno&');

      final response = await http.get(uri, headers: {});

      return response.body;
    } catch (error) {
// Handle errors appropriately
      print('Error calling Google Apps Script function: $error');
      return "error";
    }
  }

  //---Add Username Deta (Dialog box)
  void _showAddContactDialog() {
    final idnoController = TextEditingController();
    final usernameController = TextEditingController();
    final phonenoController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Customer'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // const  Text(
                      //    "Add☺Data",
                      //    style: TextStyle(fontSize: 25),
                      //  ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextFormField(
                          controller: usernameController,
                          decoration: InputDecoration(
                              labelText: 'Name',
                              hintText: "Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              prefixIcon: const Icon(Icons.person)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the Customer name';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextFormField(
                          controller: idnoController,
                          decoration: InputDecoration(
                              labelText: 'id no.',
                              hintText: "id no.",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              prefixIcon: const Icon(Icons.account_circle)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the id no.';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextFormField(
                          controller: phonenoController,
                          decoration: InputDecoration(
                              labelText: 'Contact Number',
                              hintText: "Contact Number",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              prefixIcon: const Icon(Icons.call_rounded)),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            LengthLimitingTextInputFormatter(10),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the Contact Number';
                            } else if (value.length != 10) {
                              return 'Contact Number must be 10 digits';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Ok'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, call the function to add data
                  final result = await addData(
                    username: usernameController.text,
                    idno: idnoController.text,
                    phoneno: phonenoController.text,
                    // points: _pointsController.text,
                  ); // Handle the result from the addData function
                  if (kDebugMode) {
                    print("successful");
                    Get.to(const MyHomePage());
                    Get.snackbar(
                      'Successfull',
                      'Customer Add Successfully',
                      titleText: const Text(
                        'Successfull',
                        style: TextStyle(color: Colors.white),
                      ),
                      messageText: const Text(
                        'Customer Add Successfully',
                        style: TextStyle(color: Colors.white),
                      ),
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: const Color(0xFF9066ee),
                      borderRadius: 30,
                      animationDuration: const Duration(milliseconds: 1500),
                    );
                  } else {
                        (kDebugMode) {
                      print("UnSuccessfull");
                      Get.snackbar(
                        'UnSuccessfull',
                        'Please try again',
                        titleText: const Text(
                          'UnSuccessfull',
                          style: TextStyle(color: Colors.white),
                        ),
                        messageText: const Text(
                          'Please try again',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: const Color(0xFF9066ee),
                        borderRadius: 30,
                        animationDuration: const Duration(seconds: 2),
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    };
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fetchDataFromApi();
  }

  //---Pull to Refresh
  Future<void> _handleRefresh() async {
    return await Future.delayed(
      const Duration(seconds: 3),
    );
  }

  //---Fetching User Name Data
  Future<void> fetchDataFromApi() async {
    try {
      var baseUrl =
          'https://script.google.com/macros/s/AKfycbzFjcI8TbRFmEqDikIMYE10A9UzZeMY1H7L1IcbxWtOhtLezo5bNgGvbnYeRLlQhvRB/exec?action=getUsername';
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final dudhwala = dudhWalaFromJson(response.body.toString());
        setState(() {
          items = dudhwala;
        });
      } else {
        throw Exception('Failed to load data from API');
      }
    } catch (error) {
      // Handle errors appropriately
    }
  }

  //---Add Quantity Data
  Future<String> addQuantity(
      {required String idno, required String qt,}) async {
    const String scriptUrl =
        'https://script.google.com/macros/s/AKfycbzFjcI8TbRFmEqDikIMYE10A9UzZeMY1H7L1IcbxWtOhtLezo5bNgGvbnYeRLlQhvRB/exec';
    try {
      final Uri uri = Uri.parse('$scriptUrl?action=addQuantity&'
          'idno=$idno&'
          'qt=$qt&'
          'time=${DateTime
          .now()
          .millisecondsSinceEpoch}');
      final response = await http.get(uri, headers: {});
      return response.body;
    } catch (error) {
      // Handle errors appropriately
      print('Error calling Google Apps Script function: $error');
      return "error";
    }
  }

  //---Scaffold
  @override
  Widget build(BuildContext context) {
    print('Build');
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade400,

      //  AppBar
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade100,
        title: const Text(
          'DoodhWala',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            // color: Colors.deepPurple ,
          ),
        ),
        centerTitle: true,
        // backgroundColor: const Color(0xFF7accb8),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.sort_rounded,
              color: Colors.deepPurple,
            ),
            onPressed: _sortItemsCombine,
          ),
        ],
      ),

      //  Drawer
      drawer: Drawer(
        backgroundColor: Colors.deepPurple.shade100,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            ListTile(
              title: const Text('Home'),
              leading: Icon(
                Icons.home,
                color: Colors.deepPurple.shade400,
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Account'),
              leading: Icon(
                Icons.account_box,
                color: Colors.deepPurple.shade400,
              ),
            ),
            ListTile(
              title: const Text('Logout'),
              leading: Icon(
                Icons.logout,
                color: Colors.deepPurple.shade400,
              ),
            ),
            ListTile(
              title: const Text('Language'),
              leading: Icon(
                Icons.language,
                color: Colors.deepPurple.shade400,
              ),
              onTap: () {
                Get.defaultDialog(
                  title: 'Select Language',
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: const Text('Gujarati'),
                        leading: Icon(
                          Icons.language_sharp,
                          color: Colors.deepPurple.shade400,
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        title: const Text('English'),
                        leading: Icon(
                          Icons.language_sharp,
                          color: Colors.deepPurple.shade400,
                        ),
                        onTap: () {},
                      )
                    ],
                  ),
                );
              },
            ),
            ListTile(
                title: const Text('Themes'),
                leading: Icon(
                  Icons.wb_sunny_sharp,
                  color: Colors.deepPurple.shade400,
                ),
                onTap: () {
                  Get.defaultDialog(
                    barrierDismissible: false,
                    title: 'Select Themes',
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: const Text('Dark Themes'),
                          leading: Icon(
                            Icons.dark_mode_rounded,
                            color: Colors.deepPurple.shade400,
                          ),
                          onTap: () {
                            print('Dark Mode Selected');
                            themeController.switchToDarkTheme();
                            Get.back();
                          },
                        ),
                        ListTile(
                          title: const Text('Light Modes'),
                          leading: Icon(
                            Icons.light_mode,
                            color: Colors.deepPurple.shade400,
                          ),
                          onTap: () {
                            print('Light Mode Selected');
                            themeController.switchToLightTheme();
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  );
                }),
            ListTile(
              title: const Text('Theme Modes'),
              leading: Icon(
                Icons.sunny_snowing,
                color: Colors.deepPurple.shade400,
              ),
              onTap: () {
                Get.bottomSheet(
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: Wrap(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.sunny),
                          title: const Text('Light Mode'),
                          onTap: () {
                            // Get.changeTheme(ThemeData.light());
                            themeController.switchToLightTheme();
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.sunny),
                          title: const Text('Dark Modes'),
                          onTap: () {
                            themeController.switchToDarkTheme();
                            // Get.changeTheme(ThemeData.dark());
                          },
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      //  Body
      body: LiquidPullToRefresh(
          color: Colors.deepPurple.shade200,
          height: 300,
          backgroundColor: Colors.deepPurple[400],
          animSpeedFactor: 2,
          // showChildOpacityTransition: false,
          onRefresh: _handleRefresh,
          child: buildBody()),

      //Add Data Floating Action Button

      floatingActionButton: FloatingActionButton(
        elevation: 8,
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepPurple.shade400,
        onPressed: () {
          Get.to(const AddDataForm());
          // _showAddContactDialog();
        },
        tooltip: 'Add Data',
        // child: const Icon(Icons.add),
        child: SvgPicture.asset(
          'assets/icons/user-add.svg', height: 22, width: 22,
          color: Colors.deepPurple,
        ),
      ),
    );
  }

  //--- Id, Username
  //--- Widget BuildBody
  Widget buildBody() {
    if (items.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    else {
      if (!isSorted) {
        isSorted = true;
      }
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(4),
            child: Card(
              color: Colors.deepPurple.shade100,
              elevation: 7,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(

                  children: [
//  Username
                    ListTile(
                      // Title
                        title: Text(
                          " ${items[index].username}",
                          style: const TextStyle(
                            fontSize: 20,
                            // color:Colors.deepPurple.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
//  Id No.
                        // Sub Title
                        subtitle: Text(
                          "ID-No: ${items[index].idno}",
                          style: const TextStyle(
                            fontSize: 16,
                            // color:Colors.deepPurple.shade600,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Leading
                        leading: const Icon(
                          Icons.person_rounded,
                          // color: Colors.deepPurple.shade600,
                        ),
// Add Quantity Button
                        // Trailing
                        trailing: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            elevation: 8,
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.deepPurple.shade400,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                  bottomLeft: Radius.circular(25),
                                  bottomRight: Radius.circular(25)),
                            ),
                          ),
                          onPressed: () {
                            _showOptionDialog(context, items[index].idno);
                          },
                          label: const Text('QTY'),
                          icon: const Icon(
                            Icons.add,
                          ),
                        ),


                        onLongPress: () {
                          // Perform delete operation
                          Get.defaultDialog(
                            backgroundColor: Colors.deepPurple.shade400,
                            title: "Conform Delete Item",
                            titleStyle: const TextStyle(color: Colors.white),

                            content: Text(
                              "Are you sure you want to Delete this Item ${items[index]
                                  .idno}",
                              style: const TextStyle(color: Colors.white),),
                            barrierDismissible: false,

                            cancel: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 12,
                                // foregroundBuilder:Colors.white ,
                                // backgroundColor: Colors.deepPurple.shade400,
                              ),
                              child: const Text("Cancel"),
                            ),

                            confirm: ElevatedButton(
                              onPressed: () {
                                _deleteItem(items[index].idno);
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 12,
                                // foregroundBuilder:Colors.white ,
                                // backgroundColor: Colors.deepPurple.shade400,
                              ),
                              child: const Text("Ok"),
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 3,
                      width: 200,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(17, 0, 8, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Phone Number
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.call_rounded,
                                // color: Colors.deepPurple.shade600,
                              ),
                              Text(
                                '${items[index].phoneno}',
                                style: const TextStyle(
                                  // color:Colors.deepPurple.shade600,
                                    fontSize: 17),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 15, 8),
                            child: Column(
                              children: [
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 8,
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.deepPurple.shade400,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25),
                                          // topRight: Radius.circular(20),
                                          topRight: Radius.circular(25),
                                          bottomLeft: Radius.circular(25),
                                          bottomRight: Radius.circular(25)),
                                    ),
                                  ),
                                  onPressed: () {
                                    // Used Getx with UserDetailPage
                                    Get.to(UserDetailsPage(
                                      name: items[index].username,
                                      id: items[index].idno,
                                      phones: items[index].phoneno,
                                    ));
                                  },
                                  label: const Text('View'),
                                  icon: const Icon(Icons.remove_red_eye),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }

  //---Delete item function
  void _deleteItem(String id) async {
    try {
      const String scriptUrl =
          'https://script.google.com/macros/s/AKfycbzFjcI8TbRFmEqDikIMYE10A9UzZeMY1H7L1IcbxWtOhtLezo5bNgGvbnYeRLlQhvRB/exec';
      final Uri uri = Uri.parse('$scriptUrl?action=deletenameData&idno=$id');
      final response = await http.get(uri, headers: {});
      if (response.statusCode == 200) {
        setState(() {
          // Remove the item from the list
          items.removeWhere((element) => element.idno == id);
          Get.snackbar(
            'Successfull',
            '$id Customer Delete Successfully',
            snackPosition: SnackPosition.BOTTOM,
            titleText: const Text(
              'Successfull',
              style: TextStyle(color: Colors.white),
            ),
            messageText: Text(
              '$id Customer Delete Successfully',
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: const Color(0xFF9066ee),
            borderRadius: 20,
            animationDuration: const Duration(milliseconds: 1500),
          );
        });
      } else {
        throw Exception('Failed to delete item');
      }
      // Handle errors appropriately
    } catch (error) {
      print('Error deleting item: $error');
      Get.snackbar(
        'UnSuccessfull',
        'Failed to delete item',
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text(
          'UnSuccessfull',
          style: TextStyle(color: Colors.white),
        ),
        messageText: const Text(
          'Failed to delete item',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF9066ee),
        borderRadius: 20,
        animationDuration: const Duration(milliseconds: 1500),
      );
    }
  }



  //  Select Quantity
  void _showOptionDialog(BuildContext context, String id) {
    String? selectedValue;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Quantity'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildRadioOption(context, 'અચ્છેર', selectedValue, (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  }),
                  _buildRadioOption(context, 'સેર', selectedValue, (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  }),
                  _buildRadioOption(context, 'પોણા સેર', selectedValue,
                          (value) {
                        setState(() {
                          selectedValue = value;
                        });
                      }),
                  _buildRadioOption(context, 'એક લીટર', selectedValue, (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  }),
                  _buildRadioOption(context, 'બે  લીટર', selectedValue,
                          (value) {
                        setState(() {
                          selectedValue = value;
                        });
                      }),
                  _buildRadioOption(context, 'ત્રણ  લીટર', selectedValue,
                          (value) {
                        setState(() {
                          selectedValue = value;
                        });
                      }),
                ],
              );
            },
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 8,
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepPurple.shade400),
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Close the dialog without passing the value
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 8,
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepPurple.shade400),
              onPressed: () {
                if (selectedValue != null) {
                  Navigator.of(context)
                      .pop(selectedValue); // Pass the selected value
                  // }
                  Get.snackbar(
                    'Success',
                    '$selectedValue added successfully',
                    snackPosition: SnackPosition.BOTTOM,
                    titleText: const Text(
                      'Success',
                      style: TextStyle(color: Colors.white),
                    ),
                    messageText: Text(
                      '$selectedValue added successfully',
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: const Color(0xFF9066ee),
                    borderRadius: 30,
                    animationDuration: const Duration(milliseconds: 1500),
                  );
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    ).then((value) {
      // Handle the selected option
      if (value != null) {
        setState(() {
          print('Id No: $id');
          print('Select Quantity: $value');
          // Integrate switch-case logic here
          double quantity;
          switch (value) {
            case 'અચ્છેર':
              quantity = 0.25;
              break;
            case 'સેર':
              quantity = 0.50;
              break;
            case 'પોણા સેર':
              quantity = 0.75;
              break;
            case 'એક લીટર':
              quantity = 1;
              break;
            case 'બે  લીટર':
              quantity = 2;
              break;
            case 'ત્રણ  લીટર':
              quantity = 3;
              break;
            default:
              quantity = 0;
              break;
          }
          print('Quantity: $quantity');
          addQuantity(
            idno: id,
            qt: quantity.toString(),
          );
        });
      }
    });
  }

  Widget _buildRadioOption(BuildContext context, String option,
      String? selectedValue, Function(String) onSelect) {
    return RadioListTile<String>(
      title: Text(option,
      // style: const TextStyle(
      //     fontWeight: FontWeight.w400,
      //     fontFamily: "Noto Sans Gujarati"
      // ),
    ),
      value: option,
      groupValue: selectedValue,
      onChanged: (value) {
        onSelect(value!);
      },
    );
  }
}



