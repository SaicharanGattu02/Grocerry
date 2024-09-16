// import 'dart:convert';
// import 'dart:io';
// import 'dart:ui' as ui;
//
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:geocoding/geocoding.dart' as geocoder;
// import 'package:geolocator/geolocator.dart';
// import 'package:geolocator_platform_interface/src/enums/location_accuracy.dart'
// as geo_location;
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
//
// import '../../helper/utils/ShakeWidget.dart';
//
// class AddAddressmap extends StatefulWidget {
//   final double lat_glb;
//   final double lng_glb;
//   final int type;
//
//   const AddAddressmap(
//       {super.key,
//         required this.lat_glb,
//         required this.lng_glb,
//         required this.type});
//
//   @override
//   _AddressPageState createState() => _AddressPageState();
// }
//
// class _AddressPageState extends State<AddAddressmap> {
//   Map _source = {
//     ConnectivityResult.mobile: false,
//     ConnectivityResult.wifi: false
//   };
//   // final MyConnectivityD _connectivity = MyConnectivityD.instance;
//   var searched_string = "";
//   var isLoading = true;
//   final TextEditingController _searchController = TextEditingController();
//   final nonEditableAddressController = TextEditingController();
//   final newHouseNoController = TextEditingController();
//   final landmarkController = TextEditingController();
//   final buildingController = TextEditingController();
//   final house_noController = TextEditingController();
//   final name_Controller = TextEditingController();
//   final mobile_Controller = TextEditingController();
//   final other_address_type = TextEditingController();
//   double lat = 0.0;
//   double lng = 0.0;
//   final bool _isLoading = true;
//   Set<Marker> markers = {};
//   late String _locationName = "";
//   late String _pinCode = "";
//   late final String _loc = "";
//   late GoogleMapController mapController;
//   GoogleMapController? _controller;
//   late LatLng CurrentLocation = LatLng(17.4065, 78.4772);
//   bool isPlaceSelected = false;
//   FocusNode focusNode = FocusNode();
//   String select_address_type = "Home";
//   var latlngs = "";
//   String _validate_houseno_s = "";
//   String _validate_other_type = "";
//   String _validate_area = "";
//   String _validate_name = "";
//   String _validate_no = "";
//   String _validate_new_house = "";
//   bool _isBottomSheetVisible = false;
//   bool valid_address = true;
//
//   var address_loading = true;
//
//   // late GooglePlace googlePlace;
//
//   bool isFocused = false;
//   bool isFocused1 = false;
//   bool isFocused2 = false;
//   bool isFocused3 = false;
//   bool isFocused4 = false;
//   bool isFocused5 = false;
//   bool isFocused6 = false;
//   bool isFocused7 = false;
//   bool isFocused8 = false;
//   bool isFocusedNew1 = false;
//
//
//   FocusNode _focusNode = FocusNode();
//   FocusNode _focusNode1 = FocusNode();
//   FocusNode _focusNode2 = FocusNode();
//   FocusNode _focusNode3 = FocusNode();
//   FocusNode _focusNode4 = FocusNode();
//   FocusNode _focusNode5 = FocusNode();
//   FocusNode _focusNode6 = FocusNode();
//   FocusNode _focusNode7 = FocusNode();
//   FocusNode _focusNode8 = FocusNode();
//   FocusNode _focusNodenew1 = FocusNode();
//
//   @override
//   void initState() {
//     // FirebaseAnalytics.instance.logScreenView(screenName: "Add Address");
//     CurrentLocation = LatLng(widget.lat_glb, widget.lng_glb);
//     _focusNode.addListener(_onFocusChange);
//     _focusNode1.addListener(_onFocusChange);
//     _focusNode2.addListener(_onFocusChange);
//
//     // _connectivity.initialise();
//     // _connectivity.myStream.listen((source) {
//     //   setState(() => _source = source);
//     // });
//
//     if (widget.type == 0) {
//       requestGpsPermission();
//       _getCurrentLocation();
//
//       _getAddress(widget.lat_glb, widget.lng_glb);
//     }
//     // print("type:${widget.type}");
//
//     super.initState();
//
//     if (widget.type > 0) {
//
//     }
//     // print("widget.type${widget.type} ");
//   }
//
//
//   void _onFocusChange() {
//     setState(() {
//       isFocused = _focusNode.hasFocus;
//       isFocused1 = _focusNode1.hasFocus;
//       isFocused2 = _focusNode2.hasFocus;
//     });
//   }
//
//   Future<void> requestGpsPermission() async {
// // Check if the app has been granted location permission
//     final loc.Location location = loc.Location();
//     bool serviceEnabled;
//     serviceEnabled = await location.serviceEnabled();
//     try {
//       if (!serviceEnabled) {
//         serviceEnabled = await location.requestService();
//         if (!serviceEnabled) {
//           serviceEnabled = await location.requestService();
//         } else {
//           _getCurrentLocation();
//         }
//       } else {
//         _getCurrentLocation();
//       }
//     } catch (e, s) {
//       // FirebaseCrashlytics.instance.log('Error occurred: $e');
//       // FirebaseCrashlytics.instance.recordError(e, s);
//     }
//   }
//
//   String googleApikey = "AIzaSyAA2ukvrb1kWQZ2dttsNIMynLJqVCYYrhw";
//   List<AutocompletePrediction> placePredictions = [];
//
//
//
//
//   void _onCameraMove(CameraPosition position) async {
//     // print("${position.target.latitude}, ${position.target.longitude}");
//     setState(() {
//       lat = position.target.latitude;
//       lng = position.target.longitude;
//       latlngs = "${lat}, ${lng}";
//       address_loading = false;
//     });
//   }
//
//   Future<void> _getCurrentLocation() async {
//     ByteData data = await rootBundle.load("assets/images/marker.png");
//     Uint8List bytes = data.buffer.asUint8List();
//     ui.Codec codec = await ui.instantiateImageCodec(bytes,
//         targetWidth: 70, targetHeight: 75);
//     ui.FrameInfo fi = await codec.getNextFrame();
//     Uint8List resizedBytes =
//     (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
//         .buffer
//         .asUint8List();
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: geo_location.LocationAccuracy.bestForNavigation);
//     setState(() {
//       CurrentLocation = LatLng(position.latitude, position.longitude);
//       latlngs = "${position.latitude}, ${position.longitude}";
//       _controller?.animateCamera(CameraUpdate.newCameraPosition(
//           CameraPosition(target: CurrentLocation, zoom: 16)));
//       _getAddress(position.latitude, position.longitude);
//     });
//   }
//
//   // _getAddress(double? lat1, double? lang1) async {
//   //   if (lat1 == null || lang1 == null) return "";
//   //   List<geocoder.Placemark> placemarks =
//   //       await geocoder.placemarkFromCoordinates(lat1, lang1);
//   //   setState(() {
//   //     lat = lat1;
//   //     lng = lang1;
//   //     latlngs = "${lat}, ${lng}";
//   //     print(placemarks[0]);
//   //
//   //     _locationName = "${placemarks[0].name},${placemarks[0].subLocality},${placemarks[0].locality},${placemarks[0].subAdministrativeArea}"
//   //         "${placemarks[0].administrativeArea},${placemarks[0].postalCode}"
//   //         .toString();
//   //     buildingController.text= "${placemarks[0].name},${placemarks[0].subLocality},${placemarks[0].locality},${placemarks[0].subAdministrativeArea}"
//   //         "${placemarks[0].administrativeArea},${placemarks[0].postalCode}"
//   //         .toString();
//   //     _pinCode = placemarks[0].postalCode.toString();
//   //     address_loading = false;
//   //   });
//   // }
//
//   _getAddress(double? lat1, double? lng1) async {
//     if (lat1 == null || lng1 == null) return "";
//     List<geocoder.Placemark> placemarks =
//     await geocoder.placemarkFromCoordinates(lat1, lng1);
//
//     // Filter placemarks to only include those with the country code 'IN' and country name 'India'
//     geocoder.Placemark? validPlacemark;
//     for (var placemark in placemarks) {
//       if (placemark.country == 'India' &&
//           placemark.isoCountryCode == 'IN' &&
//           placemark.postalCode != null &&
//           placemark.postalCode!.isNotEmpty) {
//         validPlacemark = placemark;
//         break;
//       }
//     }
//     print("Placemak:${validPlacemark}");
//     if (validPlacemark != null) {
//       setState(() {
//         lat = lat1;
//         lng = lng1;
//         latlngs = "${lat}, ${lng}";
//         // print(validPlacemark);
//         _locationName =
//             "${validPlacemark?.name},${validPlacemark?.subLocality},${validPlacemark?.locality},${validPlacemark?.subAdministrativeArea},"
//                 "${validPlacemark?.administrativeArea},${validPlacemark?.postalCode}"
//                 .toString();
//         nonEditableAddressController.text =
//             "${validPlacemark?.name},${validPlacemark?.subLocality},${validPlacemark?.locality},${validPlacemark?.subAdministrativeArea},"
//                 "${validPlacemark?.administrativeArea},${validPlacemark?.postalCode}"
//                 .toString();
//         _pinCode = validPlacemark!.postalCode.toString();
//         address_loading = false;
//         valid_address = true;
//       });
//     } else {
//       // Handle case where no valid placemark is found
//       setState(() {
//         _locationName =
//         "Whoa there, explorer! \nYou've reached a place we haven't. Our services are unavailable here. \nTry another location!";
//         address_loading = false;
//         valid_address = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // switch (_source.keys.toList()[0]) {
//     //   case ConnectivityResult.mobile:
//     //     setState(() {
//     //       connection = 'Online';
//     //     });
//     //
//     //     break;
//     //   case ConnectivityResult.wifi:
//     //     setState(() {
//     //       connection = 'Online';
//     //     });
//     //     break;
//     //   case ConnectivityResult.none:
//     //   default:
//     //     setState(() {
//     //       connection = 'Offline';
//     //     });
//     // }
//     // print("string${connection}");
//     Size size = MediaQuery.of(context).size;
//
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           useMaterial3: true,
//           colorSchemeSeed: Colors.white70,
//         ),
//         home: Scaffold(
//           // appBar: appBar(context,
//           //     (widget.type > 0) ? "Edit Address" : 'Add Location', true, ""),
//           body: Padding(
//             padding: (Platform.isAndroid)
//                 ? EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom)
//                 : EdgeInsets.all(0),
//             child: Stack(
//               children: [
//                 GoogleMap(
//                   mapType: MapType.normal,
//                   initialCameraPosition: CameraPosition(
//                     target: CurrentLocation,
//                     zoom: 16.0,
//                   ),
//                   onMapCreated: (GoogleMapController controller) {
//                     _controller = controller;
//                   },
//                   onCameraMove: _onCameraMove,
//                   onCameraIdle: () {
//                     _getAddress(lat, lng);
//                   },
//                   markers: markers,
//                   myLocationEnabled: true,
//                   zoomControlsEnabled: false,
//                   zoomGesturesEnabled: true,
//                   myLocationButtonEnabled: false,
//                   minMaxZoomPreference: MinMaxZoomPreference(16, null),
//                   // onCameraMoveStarted: ,
//                 ),
//                 Center(
//                   child: SvgPicture.asset(
//                     "assets/images/pin.svg",
//                     height: 75,
//                   ),
//                 ),
//                 Column(
//                   children: [
//                     const SizedBox(
//                       height: 20.0,
//                     ),
//                     Align(
//                       alignment: Alignment.center,
//                       child: Container(
//                         width: screenWidth * 0.88,
//                         height: 45,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(25),
//                           border: Border.all(
//                             color: Color(0xFFD6D6D6),
//                             width: 0.5,
//                           ),
//                         ),
//                         child: TextField(
//                           cursorColor: Colors.black,
//                           scrollPadding: const EdgeInsets.only(top: 5),
//                           readOnly: true,
//                           focusNode: focusNode,
//                           onTap: () {
//                             _showBottomSheet1(context);
//                           },
//                           style: TextStyle(),
//                           decoration: InputDecoration(
//                             hintText: 'Search your location',
//                             hintStyle: TextStyle(
//                               color: Color(0xFF868686),
//                               fontFamily: "Inter",
//                               fontSize:15,
//                               fontWeight: FontWeight.normal,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             contentPadding: const EdgeInsets.only(
//                                 left: 30, right: 5, top: 5),
//                             prefixIcon: IconButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                               icon: Icon(
//                                 Icons.search_rounded,
//                                 size: 30,
//                                 // color: ColorConstant.appcolor,
//                               ),
//                             ),
//                             enabledBorder: InputBorder.none,
//                             focusedBorder: InputBorder.none,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                Positioned(
//                   bottom: screenHeight * 0.13,
//                   left: screenWidth * 0.06,
//                   // right: screenWidth*0.33,
//                   child: Container(
//                     // padding: EdgeInsets.only(left: screenWidth * 0.32),
//                     child: (address_loading)
//                         ? Container(
//                       padding:
//                       EdgeInsets.only(left: screenWidth * 0.49),
//                       child: Container(
//                          ),
//                     )
//                         : Container(
//                       padding:
//                       EdgeInsets.only(left: screenWidth * 0.35),
//                       child: InkWell(
//                         onTap: () {
//                           setState(() {
//                             address_loading = true;
//                           });
//                           requestGpsPermission();
//                         },
//                         child: Container(
//                             height: 35,
//                             width:130,
//                             decoration: const BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.all(
//                                   Radius.circular(25)),
//                             ),
//                             child: Center(
//                               child: Row(
//                                 children: [
//                                   const SizedBox(
//                                     width: 10,
//                                   ),
//                                   Icon(Icons.my_location_outlined,
//                                       size:
//                                           20,
//                                       color: Color(0xff219EBC)),
//                                   const SizedBox(
//                                     width: 5,
//                                   ),
//                                   Text("Locate Me",
//                                       style: TextStyle(
//                                           fontFamily: "Inter",
//                                           fontSize:
//                                               18,
//                                           fontWeight:
//                                           FontWeight.w500,
//                                           overflow:
//                                           TextOverflow.ellipsis,
//                                           color: Colors.black)),
//                                 ],
//                               ),
//                             )),
//                       ),
//                     ),
//                   ),
//                 )
//                     , Positioned(
//                   bottom: screenHeight * 0.19,
//                   // left: screenWidth*0.33,
//                   // right: screenWidth*0.33,
//                   child: Container(
//                     // padding: EdgeInsets.only(left: screenWidth * 0.32),
//                     child: (address_loading)
//                         ? Container(
//                       padding:
//                       EdgeInsets.only(left: screenWidth * 0.49),
//                       child: Container(
//                           ),
//                     )
//                         : Container(
//                       padding:
//                       EdgeInsets.only(left: screenWidth * 0.35),
//                       child: InkWell(
//                         onTap: () {
//                           setState(() {
//                             address_loading = true;
//                           });
//                           requestGpsPermission();
//                         },
//                         child: Container(
//                             height: 35,
//                             width: 130,
//                             decoration: const BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.all(
//                                   Radius.circular(25)),
//                             ),
//                             child: Center(
//                               child: Row(
//                                 children: [
//                                   const SizedBox(
//                                     width: 10,
//                                   ),
//                                   Icon(Icons.my_location_outlined,
//                                       size:20,
//                                       color: Color(0xff219EBC)),
//                                   const SizedBox(
//                                     width: 5,
//                                   ),
//                                   Text("Locate Me",
//                                       style: TextStyle(
//                                           fontFamily: "Inter",
//                                           fontSize:15,
//                                           fontWeight:
//                                           FontWeight.w500,
//                                           overflow:
//                                           TextOverflow.ellipsis,
//                                           color:
//                                           Colors.black)),
//                                 ],
//                               ),
//                             )),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 0,
//                   right: 0,
//                   left: 0,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(25.0),
//                         topRight: Radius.circular(25.0),
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.2),
//                           spreadRadius: 5,
//                           blurRadius: 3,
//                           offset: Offset(0, 2), // changes position of shadow
//                         ),
//                       ],
//                     ),
//                     height: 140,
//                     child: Column(
//                       children: [
//                         SizedBox(height: 25),
//                         Row(
//                           children: [
//                             SizedBox(width: 15),
//                             (valid_address)
//                                 ? SvgPicture.asset(
//                               "assets/images/Vector.svg",
//                               height: 35,
//                             )
//                                 : SvgPicture.asset(
//                               "assets/images/no_location_found.svg",
//                               color: Color(0xFFDE0000),
//                               height: 35,
//                             ),
//                             SizedBox(width: 10),
//                             Column(
//                               children: [
//                                 SizedBox(
//                                   width: (valid_address)
//                                       ? size.width * 0.8
//                                       : size.width * 0.85,
//                                   child: Text(
//                                     (address_loading)
//                                         ? "Loading..."
//                                         : _locationName,
//                                     maxLines: (valid_address) ? 2 : 4,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(
//                                       fontFamily: "Inter",
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10),
//                         if (valid_address) ...[
//                           TextButton(
//                             onPressed: () async {
//                               // var res = await Navigator.push(
//                               //     context,
//                               //     MaterialPageRoute(
//                               //         builder: (context) => AddAddressMap(
//                               //             type: widget.type,
//                               //             address: _locationName.toString(),
//                               //             loc: "$lat, $lng",
//                               //             pin: _pinCode)));
//                               // if (res == true) {
//                               //   Navigator.pop(context, true);
//                               // }
//                               _showBottomSheet(context);
//                               setState(() {
//                                 _isBottomSheetVisible = true;
//                               });
//                             },
//                             style: ButtonStyle(
//                               // backgroundColor: MaterialStateProperty.all(
//                               //     ColorConstant.silverforcartbarbtn),
//                               padding: MaterialStateProperty.all(
//                                 EdgeInsets.symmetric(horizontal: 60),
//                               ),
//                             ),
//                             child: Text(
//                               "Find Location and Continue",
//                               style: TextStyle(
//                                 fontFamily: "Inter",
//                                 fontSize:15,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                         ],
//                         SizedBox(height: 10),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ));
//   }
//
//   Future<void> _showBottomSheet(context) async {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
//       ),
//       isScrollControlled: true,
//       isDismissible: true,
//       builder: (BuildContext context) {
//         return SafeArea(child: StatefulBuilder(
//           builder: (BuildContext context, StateSetter setState) {
//             return SizedBox(
//               height: MediaQuery.of(context).size.height * 0.7,
//               child: Padding(
//                   padding: EdgeInsets.only(
//                     bottom: MediaQuery.of(context).viewInsets.bottom,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: 20),
//                       Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 15),
//                         decoration: BoxDecoration(),
//                         child: Text(
//                           (widget.type > 0)
//                               ? "Edit Complete Address"
//                               : "Add Complete Address",
//                           style: TextStyle(
//                             fontFamily: 'Inter',
//                             fontSize: 19,
//                             fontWeight: FontWeight.w600,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       // Expanded(
//                       //   child: SingleChildScrollView(
//                       //     child: Column(
//                       //       mainAxisSize: MainAxisSize.min,
//                       //       crossAxisAlignment: CrossAxisAlignment.start,
//                       //       children: <Widget>[
//                       //         Container(
//                       //           padding: EdgeInsets.only(left: 15, right: 10),
//                       //           child: Text(
//                       //             "Location Type",
//                       //             style: TextStyle(
//                       //                 fontFamily: "Inter",
//                       //                 fontSize: 15,
//                       //                 fontWeight: ui.FontWeight.w600),
//                       //           ),
//                       //         ),
//                       //         SizedBox(
//                       //           height: 10,
//                       //         ),
//                       //         Padding(
//                       //           padding: const EdgeInsets.only(
//                       //               left: 10.0, right: 10.0),
//                       //           child: SingleChildScrollView(
//                       //             scrollDirection: Axis.horizontal,
//                       //             child: Row(
//                       //               children: [
//                       //                 Container(
//                       //                   height: 30,
//                       //                   child: ElevatedButton(
//                       //                     onPressed: () {
//                       //                       setState(() {
//                       //                         select_address_type = "Home";
//                       //                       });
//                       //                     },
//                       //                     style: ElevatedButton.styleFrom(
//                       //                       elevation: 0,
//                       //                       backgroundColor:
//                       //                       (select_address_type == "Home")
//                       //                           ? ColorConstant.appcolor
//                       //                           : Colors.white,
//                       //                       side: BorderSide(
//                       //                           width: 0.0,
//                       //                           color: Color(0xffCCCCCC)),
//                       //                       // Set button background color
//                       //                       shape: RoundedRectangleBorder(
//                       //                         borderRadius: BorderRadius.circular(
//                       //                             25.0), // Adjust the value for desired curve shape
//                       //                       ),
//                       //                     ),
//                       //                     child: Padding(
//                       //                       padding: const EdgeInsets.symmetric(
//                       //                           horizontal: 5.0),
//                       //                       child: Row(
//                       //                         children: [
//                       //                           SvgPicture.asset(
//                       //                             "assets/images/home_outline.svg",
//                       //                             height: 20,
//                       //                             color: (select_address_type ==
//                       //                                 "Home")
//                       //                                 ? ColorConstant.white
//                       //                                 : ColorConstant.black,
//                       //                           ),
//                       //                           // Add space between icon and text
//                       //                           Text(
//                       //                             " Home ",
//                       //                             style: TextStyle(
//                       //                                 color:
//                       //                                 (select_address_type ==
//                       //                                     "Home")
//                       //                                     ? ColorConstant
//                       //                                     .white
//                       //                                     : ColorConstant
//                       //                                     .appcolor,
//                       //                                 fontSize:
//                       //                                 FontConstant.Size13
//                       //                               // Set button text color
//                       //                             ),
//                       //                           ),
//                       //                         ],
//                       //                       ),
//                       //                     ),
//                       //                   ),
//                       //                 ),
//                       //                 const SizedBox(width: 10),
//                       //                 Container(
//                       //                   height: 30,
//                       //                   child: ElevatedButton(
//                       //                     onPressed: () {
//                       //                       setState(() {
//                       //                         select_address_type = "Work";
//                       //                       });
//                       //                     },
//                       //                     style: ElevatedButton.styleFrom(
//                       //                       elevation: 0,
//                       //                       backgroundColor:
//                       //                       (select_address_type == "Work")
//                       //                           ? ColorConstant.appcolor
//                       //                           : Colors.white,
//                       //                       side: BorderSide(
//                       //                           width: 0.0,
//                       //                           color: Color(0xffCCCCCC)),
//                       //                       // Set button background color
//                       //                       shape: RoundedRectangleBorder(
//                       //                         borderRadius: BorderRadius.circular(
//                       //                             25.0), // Adjust the value for desired curve shape
//                       //                       ),
//                       //                     ),
//                       //                     child: Row(
//                       //                       children: [
//                       //                         SvgPicture.asset(
//                       //                           "assets/images/suitcase.svg",
//                       //                           height: 20,
//                       //                           color: (select_address_type ==
//                       //                               "Work")
//                       //                               ? ColorConstant.white
//                       //                               : ColorConstant.black,
//                       //                         ),
//                       //                         // Icon(Icons.,size: 18,),
//                       //                         Text(
//                       //                           " Work ",
//                       //                           style: TextStyle(
//                       //                               color:
//                       //                               (select_address_type ==
//                       //                                   "Work")
//                       //                                   ? ColorConstant
//                       //                                   .white
//                       //                                   : ColorConstant
//                       //                                   .appcolor,
//                       //                               fontSize: FontConstant
//                       //                                   .Size13 // Set button text color
//                       //                           ),
//                       //                         ),
//                       //                       ],
//                       //                     ),
//                       //                   ),
//                       //                 ),
//                       //                 const SizedBox(
//                       //                     width:
//                       //                     10), // Add spacing between buttons
//                       //                 Container(
//                       //                   height: 30,
//                       //                   child: ElevatedButton(
//                       //                     onPressed: () {
//                       //                       setState(() {
//                       //                         select_address_type = "Other";
//                       //                       });
//                       //                     },
//                       //                     style: ElevatedButton.styleFrom(
//                       //                       elevation: 0,
//                       //                       backgroundColor:
//                       //                       (select_address_type == "Other")
//                       //                           ? ColorConstant.appcolor
//                       //                           : Colors.white,
//                       //                       // Set button background color
//                       //                       shape: RoundedRectangleBorder(
//                       //                         side: BorderSide(
//                       //                             width: 0.0,
//                       //                             color: Color(0xffCCCCCC)),
//                       //                         borderRadius: BorderRadius.circular(
//                       //                             25.0), // Adjust the value for desired curve shape
//                       //                       ),
//                       //                     ),
//                       //                     child: Row(
//                       //                       children: [
//                       //                         // Icon(Icons.other_houses_outlined,size: 18,),
//                       //                         SvgPicture.asset(
//                       //                           "assets/images/menu.svg",
//                       //                           height: 15,
//                       //                           color: (select_address_type ==
//                       //                               "Other")
//                       //                               ? ColorConstant.white
//                       //                               : ColorConstant.black,
//                       //                         ),
//                       //                         Text(
//                       //                           " Others ",
//                       //                           style: TextStyle(
//                       //                               color:
//                       //                               (select_address_type ==
//                       //                                   "Other")
//                       //                                   ? ColorConstant
//                       //                                   .white
//                       //                                   : ColorConstant
//                       //                                   .appcolor,
//                       //                               fontSize: FontConstant
//                       //                                   .Size13 // Set button text color
//                       //                           ),
//                       //                         ),
//                       //                       ],
//                       //                     ),
//                       //                   ),
//                       //                 ),
//                       //               ],
//                       //             ),
//                       //           ),
//                       //         ),
//                       //         if (select_address_type == "Other") ...[
//                       //           SizedBox(
//                       //             height: 10,
//                       //           ),
//                       //           Container(
//                       //             height: 40,
//                       //             margin: EdgeInsets.fromLTRB(15, 10, 10, 0),
//                       //             child: TextField(
//                       //               autofocus: true,
//                       //               keyboardType: TextInputType.name,
//                       //               cursorWidth: 0.5,
//                       //               cursorColor: Colors.black,
//                       //               controller: other_address_type,
//                       //               style: TextStyle(
//                       //                   fontFamily: "Inter",
//                       //                   color: Colors.black,
//                       //                   fontWeight: FontWeight.w500,
//                       //                   fontSize: 5),
//                       //               focusNode: _focusNode8,
//                       //               onTapOutside: (event) {
//                       //                 setState(() {
//                       //                   isFocused8 = false;
//                       //                 });
//                       //                 _focusNode8.unfocus();
//                       //               },
//                       //               onTap: () {
//                       //                 setState(() {
//                       //                   isFocused8 = true;
//                       //                   _focusNode8.canRequestFocus;
//                       //                   _validate_other_type = "";
//                       //                 });
//                       //               },
//                       //               textInputAction: TextInputAction.next,
//                       //               decoration: InputDecoration(
//                       //                 enabledBorder: OutlineInputBorder(
//                       //                     borderSide: BorderSide(
//                       //                         color: Colors.grey, width: 0.0),
//                       //                     borderRadius:
//                       //                     BorderRadius.circular(35)),
//                       //                 focusedBorder: OutlineInputBorder(
//                       //                     borderSide: BorderSide(
//                       //                         color: (other_address_type
//                       //                             .text.length >
//                       //                             0 ||
//                       //                             _focusNode8.hasFocus)
//                       //                             ? Colors.black
//                       //                             : Color(0xffE8ECFF),
//                       //                         width: 1.0),
//                       //                     borderRadius:
//                       //                     BorderRadius.circular(35)),
//                       //                 contentPadding: EdgeInsets.only(left: 32),
//                       //                 disabledBorder: UnderlineInputBorder(
//                       //                     borderSide: BorderSide.none),
//                       //                 border: OutlineInputBorder(
//                       //                   borderRadius: BorderRadius.circular(35),
//                       //                 ),
//                       //                 label: Container(
//                       //                     width:
//                       //                     (_focusNode8.hasFocus) ? 100 : 80,
//                       //                     height: 23,
//                       //                     decoration: BoxDecoration(
//                       //                       color: (_focusNode8.hasFocus ||
//                       //                           other_address_type
//                       //                               .text.length >
//                       //                               0)
//                       //                           ? Color(0xffF4F5FA)
//                       //                           : Colors.transparent,
//                       //                       borderRadius:
//                       //                       BorderRadius.circular(16.0),
//                       //                     ),
//                       //                     child: Center(
//                       //                       child: Text(
//                       //                         'Other Type',
//                       //                         style: TextStyle(
//                       //                           fontWeight: FontWeight.w500,
//                       //                           color: (_focusNode8.hasFocus)
//                       //                               ? Colors.black
//                       //                               : Color(0xffB9BEDA),
//                       //                           fontFamily: "Inter",
//                       //                           fontSize:
//                       //                           13, // Background color of the label text
//                       //                         ),
//                       //                       ),
//                       //                     )),
//                       //               ),
//                       //             ),
//                       //           ),
//                       //           if (_validate_other_type != null) ...[
//                       //             Center(
//                       //               child: ShakeWidget(
//                       //                 key: Key("value"),
//                       //                 duration: Duration(milliseconds: 700),
//                       //                 child: Text(
//                       //                   _validate_other_type,
//                       //                   style: TextStyle(
//                       //                     fontFamily: "Inter",
//                       //                     fontSize: 13,
//                       //                     color: Color(0xff023047),
//                       //                   ),
//                       //                 ),
//                       //               ),
//                       //             ),
//                       //           ],
//                       //         ],
//                       //         const SizedBox(height: 15),
//                       //         Container(
//                       //           padding: EdgeInsets.only(left: 15, right: 10),
//                       //           child: Text(
//                       //             "Contact Details",
//                       //             style: TextStyle(
//                       //                 fontFamily: "Inter",
//                       //                 fontSize: 15,
//                       //                 fontWeight: ui.FontWeight.w600),
//                       //           ),
//                       //         ),
//                       //         Container(
//                       //           height: 40,
//                       //           margin: EdgeInsets.fromLTRB(15, 10, 10, 0),
//                       //           child: TextField(
//                       //             autofocus: true,
//                       //             keyboardType: TextInputType.name,
//                       //             cursorWidth: 0.5,
//                       //             cursorColor: Colors.black,
//                       //             focusNode: _focusNode7,
//                       //             onTapOutside: (event) {
//                       //               _focusNode7.unfocus();
//                       //               setState(() {
//                       //                 isFocused7 = false;
//                       //               });
//                       //             },
//                       //             onTap: () {
//                       //               setState(() {
//                       //                 _validate_name = "";
//                       //                 isFocused7 = true;
//                       //               });
//                       //             },
//                       //             textInputAction: TextInputAction.next,
//                       //             style: TextStyle(
//                       //                 fontFamily: "Inter",
//                       //                 color: Colors.black,
//                       //                 fontWeight: FontWeight.w500,
//                       //                 fontSize: 15),
//                       //             controller: name_Controller,
//                       //             decoration: InputDecoration(
//                       //               enabledBorder: OutlineInputBorder(
//                       //                   borderSide: BorderSide(
//                       //                       color:
//                       //                       name_Controller.text.length > 0
//                       //                           ? Colors.black
//                       //                           : Color(0xffE8ECFF),
//                       //                       width: 1.0),
//                       //                   borderRadius:
//                       //                   BorderRadius.circular(35)),
//                       //               focusedBorder: OutlineInputBorder(
//                       //                   borderSide: BorderSide(
//                       //                       color: Colors.black,
//                       //                       width: 1,
//                       //                       style: BorderStyle.solid),
//                       //                   borderRadius:
//                       //                   BorderRadius.circular(35)),
//                       //               contentPadding: EdgeInsets.only(left: 32),
//                       //               disabledBorder: UnderlineInputBorder(
//                       //                   borderSide: BorderSide.none),
//                       //               border: OutlineInputBorder(
//                       //                 borderRadius: BorderRadius.circular(35),
//                       //               ),
//                       //               label: Container(
//                       //                   width: (isFocused7) ? 100 : 50,
//                       //                   height: 23,
//                       //                   decoration: BoxDecoration(
//                       //                     color: (_focusNode7.hasFocus ||
//                       //                         name_Controller.text.length >
//                       //                             0)
//                       //                         ? Color(0xffF4F5FA)
//                       //                         : Colors.transparent,
//                       //                     borderRadius:
//                       //                     BorderRadius.circular(16.0),
//                       //                   ),
//                       //                   child: Center(
//                       //                     child: Text(
//                       //                       'Name',
//                       //                       style: TextStyle(
//                       //                         fontWeight: FontWeight.w500,
//                       //                         color: (_focusNode7.hasFocus)
//                       //                             ? Colors.black
//                       //                             : Color(0xffB9BEDA),
//                       //                         fontFamily: "Inter",
//                       //                         fontSize:
//                       //                         13, // Background color of the label text
//                       //                       ),
//                       //                     ),
//                       //                   )),
//                       //             ),
//                       //           ),
//                       //         ),
//                       //         if (_validate_name != null &&
//                       //             _validate_name.isNotEmpty) ...[
//                       //           Center(
//                       //             child: ShakeWidget(
//                       //               key: Key("value"),
//                       //               duration: Duration(milliseconds: 700),
//                       //               child: Text(
//                       //                 _validate_name,
//                       //                 style: TextStyle(
//                       //                   fontFamily: "Inter",
//                       //                   fontSize: 13,
//                       //                   color: Colors.black,
//                       //                 ),
//                       //               ),
//                       //             ),
//                       //           ),
//                       //         ],
//                       //         Container(
//                       //           height: 40,
//                       //           margin: EdgeInsets.fromLTRB(15, 10, 10, 0),
//                       //           child: TextField(
//                       //             autofocus: true,
//                       //             keyboardType: TextInputType.phone,
//                       //             cursorWidth: 0.5,
//                       //             cursorColor: Colors.black,
//                       //             style: TextStyle(
//                       //                 fontFamily: "Inter",
//                       //                 color: Colors.black,
//                       //                 fontWeight: FontWeight.w500,
//                       //                 fontSize:15),
//                       //             maxLength: 10,
//                       //             enableSuggestions: false,
//                       //             focusNode: _focusNode6,
//                       //             textInputAction: TextInputAction.next,
//                       //             onTapOutside: (event) {
//                       //               _focusNode6.unfocus();
//                       //               setState(() {
//                       //                 isFocused6 = false;
//                       //               });
//                       //             },
//                       //             onTap: () {
//                       //               setState(() {
//                       //                 _validate_no = "";
//                       //                 _focusNode6.canRequestFocus;
//                       //                 isFocused6 = true;
//                       //               });
//                       //             },
//                       //             controller: mobile_Controller,
//                       //             decoration: InputDecoration(
//                       //               counterText: "",
//                       //               enabledBorder: OutlineInputBorder(
//                       //                   borderSide: BorderSide(
//                       //                       color:
//                       //                       mobile_Controller.text.length >
//                       //                           0
//                       //                           ? Colors.black
//                       //                           : Color(0xffE8ECFF),
//                       //                       width: 1.0),
//                       //                   borderRadius:
//                       //                   BorderRadius.circular(35)),
//                       //               focusedBorder: OutlineInputBorder(
//                       //                   borderSide: BorderSide(
//                       //                       color: Colors.black,
//                       //                       width: 1,
//                       //                       style: BorderStyle.solid),
//                       //                   borderRadius:
//                       //                   BorderRadius.circular(35)),
//                       //               contentPadding: EdgeInsets.only(left: 32),
//                       //               disabledBorder: UnderlineInputBorder(
//                       //                   borderSide: BorderSide.none),
//                       //               border: OutlineInputBorder(
//                       //                 borderRadius: BorderRadius.circular(35),
//                       //               ),
//                       //               label: Container(
//                       //                   width:
//                       //                   (_focusNode6.hasFocus) ? 120 : 120,
//                       //                   height: 23,
//                       //                   decoration: BoxDecoration(
//                       //                     color: (_focusNode6.hasFocus ||
//                       //                         mobile_Controller
//                       //                             .text.length >
//                       //                             0)
//                       //                         ? Color(0xffF4F5FA)
//                       //                         : Colors.transparent,
//                       //                     borderRadius:
//                       //                     BorderRadius.circular(16.0),
//                       //                   ),
//                       //                   child: Center(
//                       //                     child: Text(
//                       //                       'Mobile Number',
//                       //                       style: TextStyle(
//                       //                         fontWeight: FontWeight.w500,
//                       //                         color: (_focusNode6.hasFocus)
//                       //                             ? Colors.black
//                       //                             : Color(0xffB9BEDA),
//                       //                         fontFamily: "Inter",
//                       //                         fontSize:
//                       //                         13, // Background color of the label text
//                       //                       ),
//                       //                     ),
//                       //                   )),
//                       //             ),
//                       //           ),
//                       //         ),
//                       //         // if (_validate_no != null) ...[
//                       //         Center(
//                       //           child: ShakeWidget(
//                       //             key: Key("value"),
//                       //             duration: Duration(milliseconds: 700),
//                       //             child: Text(
//                       //               _validate_no,
//                       //               style: TextStyle(
//                       //                 fontFamily: "Inter",
//                       //                 fontSize: 13,
//                       //                 color: Color(0xff023047),
//                       //               ),
//                       //             ),
//                       //           ),
//                       //         ),
//                       //         // ],
//                       //         Container(
//                       //           padding: EdgeInsets.only(left: 35, right: 10),
//                       //           child: Text(
//                       //             "*This number will be used for delivery assistance.",
//                       //             style: TextStyle(
//                       //                 fontFamily: "Inter",
//                       //                 fontStyle: FontStyle.italic,
//                       //                 fontSize: 10,
//                       //                 color: Color(0xffBABABA),
//                       //                 fontWeight: ui.FontWeight.w500),
//                       //           ),
//                       //         ),
//                       //         const SizedBox(height: 15),
//                       //         Container(
//                       //           padding: EdgeInsets.only(left: 15, right: 10),
//                       //           child: Text(
//                       //             "Address Details",
//                       //             style: TextStyle(
//                       //                 fontFamily: "Inter",
//                       //                 fontSize: 15,
//                       //                 fontWeight: ui.FontWeight.w600),
//                       //           ),
//                       //         ),
//                       //
//                       //         Container(
//                       //           margin: EdgeInsets.fromLTRB(15, 10, 10, 0),
//                       //           child: TextField(
//                       //             onTap: () {
//                       //               setState(() {});
//                       //             },
//                       //             onTapOutside: (event) {
//                       //               setState(() {});
//                       //             },
//                       //             keyboardType: TextInputType.streetAddress,
//                       //             textInputAction: TextInputAction.next,
//                       //             cursorWidth: 0.5,
//                       //             cursorColor: Colors.black,
//                       //             style: TextStyle(
//                       //                 fontFamily: "Inter",
//                       //                 color: Colors.black,
//                       //                 fontWeight: FontWeight.w500,
//                       //                 fontSize:15),
//                       //             enableSuggestions: false,
//                       //             controller: nonEditableAddressController,
//                       //             readOnly: true,
//                       //             decoration: InputDecoration(
//                       //               enabledBorder: OutlineInputBorder(
//                       //                   borderSide: BorderSide(
//                       //                       color: nonEditableAddressController
//                       //                           .text.length >
//                       //                           0
//                       //                           ? Colors.black
//                       //                           : Color(0xffE8ECFF),
//                       //                       width: 1.0),
//                       //                   borderRadius:
//                       //                   BorderRadius.circular(35)),
//                       //               focusedBorder: OutlineInputBorder(
//                       //                   borderSide: BorderSide(
//                       //                       color: Colors.black,
//                       //                       width: 1,
//                       //                       style: BorderStyle.solid),
//                       //                   borderRadius:
//                       //                   BorderRadius.circular(35)),
//                       //               contentPadding: EdgeInsets.only(left: 32),
//                       //               disabledBorder: UnderlineInputBorder(
//                       //                   borderSide: BorderSide.none),
//                       //               border: OutlineInputBorder(
//                       //                 borderRadius: BorderRadius.circular(35),
//                       //               ),
//                       //               label: Container(
//                       //                   width: 110,
//                       //                   height: 23,
//                       //                   decoration: BoxDecoration(
//                       //                     color: Color(0xffF4F5FA),
//                       //                     borderRadius:
//                       //                     BorderRadius.circular(16.0),
//                       //                   ),
//                       //                   child: Center(
//                       //                     child: Text(
//                       //                       'Address',
//                       //                       style: TextStyle(
//                       //                         fontWeight: FontWeight.w500,
//                       //                         color: Colors.black,
//                       //                         fontFamily: "Inter",
//                       //                         fontSize:
//                       //                         13, // Background color of the label text
//                       //                       ),
//                       //                     ),
//                       //                   )),
//                       //             ),
//                       //           ),
//                       //         ),
//                       //
//                       //         Container(
//                       //           padding: EdgeInsets.only(left: 35, right: 10),
//                       //           child: Text(
//                       //             "*Address is updated based on your map pin.",
//                       //             style: TextStyle(
//                       //                 fontFamily: "Inter",
//                       //                 fontStyle: FontStyle.italic,
//                       //                 fontSize: 10,
//                       //                 color: Color(0xffBABABA),
//                       //                 fontWeight: ui.FontWeight.w500),
//                       //           ),
//                       //         ),
//                       //         SizedBox(
//                       //           height: 10,
//                       //         ),
//                       //
//                       //         Container(
//                       //           height: 40,
//                       //           margin: EdgeInsets.fromLTRB(15, 0, 10, 0),
//                       //           child: TextField(
//                       //             autofocus: true,
//                       //             focusNode: _focusNodenew1,
//                       //             onTap: () {
//                       //               setState(() {
//                       //                 _validate_new_house = "";
//                       //                 _focusNodenew1.canRequestFocus;
//                       //                 isFocusedNew1 = true;
//                       //               });
//                       //             },
//                       //             onTapOutside: (event) {
//                       //               _focusNodenew1.unfocus();
//                       //               setState(() {
//                       //                 isFocusedNew1 = false;
//                       //               });
//                       //             },
//                       //             keyboardType: TextInputType.streetAddress,
//                       //             cursorWidth: 0.5,
//                       //             cursorColor: Colors.black,
//                       //             style: TextStyle(
//                       //                 fontFamily: "Inter",
//                       //                 color: Colors.black,
//                       //                 fontWeight: FontWeight.w500,
//                       //                 fontSize: 15),
//                       //             enableSuggestions: false,
//                       //             controller: newHouseNoController,
//                       //             textInputAction: TextInputAction.done,
//                       //             decoration: InputDecoration(
//                       //               enabledBorder: OutlineInputBorder(
//                       //                   borderSide: BorderSide(
//                       //                       color: newHouseNoController
//                       //                           .text.length >
//                       //                           0
//                       //                           ? Colors.black
//                       //                           : Color(0xffE8ECFF),
//                       //                       width: 1.0),
//                       //                   borderRadius:
//                       //                   BorderRadius.circular(35)),
//                       //               focusedBorder: OutlineInputBorder(
//                       //                   borderSide: BorderSide(
//                       //                       color: Colors.black,
//                       //                       width: 1,
//                       //                       style: BorderStyle.solid),
//                       //                   borderRadius:
//                       //                   BorderRadius.circular(35)),
//                       //               contentPadding: EdgeInsets.only(left: 32),
//                       //               disabledBorder: UnderlineInputBorder(
//                       //                   borderSide: BorderSide.none),
//                       //               border: OutlineInputBorder(
//                       //                 borderRadius: BorderRadius.circular(35),
//                       //               ),
//                       //               label: Container(
//                       //                   width: (_focusNodenew1.hasFocus)
//                       //                       ? 100
//                       //                       : 90,
//                       //                   height: 23,
//                       //                   decoration: BoxDecoration(
//                       //                     color: (_focusNodenew1.hasFocus ||
//                       //                         newHouseNoController
//                       //                             .text.length >
//                       //                             0)
//                       //                         ? Color(0xffF4F5FA)
//                       //                         : Colors.transparent,
//                       //                     borderRadius:
//                       //                     BorderRadius.circular(16.0),
//                       //                   ),
//                       //                   child: Center(
//                       //                     child: Text(
//                       //                       'House No.',
//                       //                       style: TextStyle(
//                       //                         fontWeight: FontWeight.w500,
//                       //                         color: (_focusNodenew1.hasFocus)
//                       //                             ? Colors.black
//                       //                             : Color(0xffB9BEDA),
//                       //                         fontFamily: "Inter",
//                       //                         fontSize:
//                       //                         13, // Background color of the label text
//                       //                       ),
//                       //                     ),
//                       //                   )),
//                       //             ),
//                       //           ),
//                       //         ),
//                       //         if (_validate_new_house != null) ...[
//                       //           Center(
//                       //             child: ShakeWidget(
//                       //               key: Key("value"),
//                       //               duration: Duration(milliseconds: 700),
//                       //               child: Text(
//                       //                 _validate_new_house,
//                       //                 style: TextStyle(
//                       //                   fontFamily: "Inter",
//                       //                   fontSize: 13,
//                       //                   color: Color(0xff023047),
//                       //                 ),
//                       //               ),
//                       //             ),
//                       //           ),
//                       //         ],
//                       //
//                       //         Container(
//                       //           height: 40,
//                       //           margin: EdgeInsets.fromLTRB(15, 0, 10, 0),
//                       //           child: TextField(
//                       //             autofocus: true,
//                       //             focusNode: _focusNode4,
//                       //             onTap: () {
//                       //               setState(() {
//                       //                 _validate_houseno_s = "";
//                       //                 _focusNode4.canRequestFocus;
//                       //                 isFocused4 = true;
//                       //               });
//                       //             },
//                       //             onTapOutside: (event) {
//                       //               setState(() {
//                       //                 isFocused4 = false;
//                       //               });
//                       //               _focusNode4.unfocus();
//                       //             },
//                       //             keyboardType: TextInputType.streetAddress,
//                       //             textInputAction: TextInputAction.next,
//                       //             cursorWidth: 0.5,
//                       //             cursorColor: Colors.black,
//                       //             style: TextStyle(
//                       //                 fontFamily: "Inter",
//                       //                 color: Colors.black,
//                       //                 fontWeight: FontWeight.w500,
//                       //                 fontSize: 15),
//                       //             enableSuggestions: false,
//                       //             controller: buildingController,
//                       //             decoration: InputDecoration(
//                       //               enabledBorder: OutlineInputBorder(
//                       //                   borderSide: BorderSide(
//                       //                       color:
//                       //                       buildingController.text.length >
//                       //                           0
//                       //                           ? Colors.black
//                       //                           : Color(0xffE8ECFF),
//                       //                       width: 1.0),
//                       //                   borderRadius:
//                       //                   BorderRadius.circular(35)),
//                       //               focusedBorder: OutlineInputBorder(
//                       //                   borderSide: BorderSide(
//                       //                       color: Colors.black,
//                       //                       width: 1,
//                       //                       style: BorderStyle.solid),
//                       //                   borderRadius:
//                       //                   BorderRadius.circular(35)),
//                       //               contentPadding: EdgeInsets.only(left: 32),
//                       //               disabledBorder: UnderlineInputBorder(
//                       //                   borderSide: BorderSide.none),
//                       //               border: OutlineInputBorder(
//                       //                 borderRadius: BorderRadius.circular(35),
//                       //               ),
//                       //               label: Container(
//                       //                   width:
//                       //                   (_focusNode4.hasFocus) ? 110 : 110,
//                       //                   height: 23,
//                       //                   decoration: BoxDecoration(
//                       //                     color: (_focusNode4.hasFocus ||
//                       //                         buildingController
//                       //                             .text.length >
//                       //                             0)
//                       //                         ? Color(0xffF4F5FA)
//                       //                         : Colors.transparent,
//                       //                     borderRadius:
//                       //                     BorderRadius.circular(16.0),
//                       //                   ),
//                       //                   child: Center(
//                       //                     child: Text(
//                       //                       'Area Locality',
//                       //                       style: TextStyle(
//                       //                         fontWeight: FontWeight.w500,
//                       //                         color: (_focusNode4.hasFocus)
//                       //                             ? Colors.black
//                       //                             : Color(0xffB9BEDA),
//                       //                         fontFamily: "Inter",
//                       //                         fontSize:
//                       //                         13, // Background color of the label text
//                       //                       ),
//                       //                     ),
//                       //                   )),
//                       //             ),
//                       //           ),
//                       //         ),
//                       //         if (_validate_houseno_s != null) ...[
//                       //           Center(
//                       //             child: ShakeWidget(
//                       //               key: Key("value"),
//                       //               duration: Duration(milliseconds: 700),
//                       //               child: Text(
//                       //                 _validate_houseno_s,
//                       //                 style: TextStyle(
//                       //                   fontFamily: "Inter",
//                       //                   fontSize: 13,
//                       //                   color: Color(0xff023047),
//                       //                 ),
//                       //               ),
//                       //             ),
//                       //           ),
//                       //         ],
//                       //         Container(
//                       //           height: 40,
//                       //           margin: EdgeInsets.fromLTRB(15, 0, 10, 0),
//                       //           child: TextField(
//                       //             autofocus: true,
//                       //             focusNode: _focusNode3,
//                       //             onTap: () {
//                       //               setState(() {
//                       //                 _validate_area = "";
//                       //                 _focusNode3.canRequestFocus;
//                       //                 isFocused3 = true;
//                       //               });
//                       //             },
//                       //             onTapOutside: (event) {
//                       //               _focusNode3.unfocus();
//                       //               setState(() {
//                       //                 isFocused3 = false;
//                       //               });
//                       //             },
//                       //             keyboardType: TextInputType.streetAddress,
//                       //             cursorWidth: 0.5,
//                       //             cursorColor: Colors.black,
//                       //             style: TextStyle(
//                       //                 fontFamily: "Inter",
//                       //                 color: Colors.black,
//                       //                 fontWeight: FontWeight.w500,
//                       //                 fontSize: 15),
//                       //             enableSuggestions: false,
//                       //             controller: landmarkController,
//                       //             textInputAction: TextInputAction.done,
//                       //             decoration: InputDecoration(
//                       //               enabledBorder: OutlineInputBorder(
//                       //                   borderSide: BorderSide(
//                       //                       color:
//                       //                       landmarkController.text.length >
//                       //                           0
//                       //                           ? Colors.black
//                       //                           : Color(0xffE8ECFF),
//                       //                       width: 1.0),
//                       //                   borderRadius:
//                       //                   BorderRadius.circular(35)),
//                       //               focusedBorder: OutlineInputBorder(
//                       //                   borderSide: BorderSide(
//                       //                       color: Colors.black,
//                       //                       width: 1,
//                       //                       style: BorderStyle.solid),
//                       //                   borderRadius:
//                       //                   BorderRadius.circular(35)),
//                       //               contentPadding: EdgeInsets.only(left: 32),
//                       //               disabledBorder: UnderlineInputBorder(
//                       //                   borderSide: BorderSide.none),
//                       //               border: OutlineInputBorder(
//                       //                 borderRadius: BorderRadius.circular(35),
//                       //               ),
//                       //               label: Container(
//                       //                   width:
//                       //                   (_focusNode3.hasFocus) ? 100 : 90,
//                       //                   height: 23,
//                       //                   decoration: BoxDecoration(
//                       //                     color: (_focusNode3.hasFocus ||
//                       //                         landmarkController
//                       //                             .text.length >
//                       //                             0)
//                       //                         ? Color(0xffF4F5FA)
//                       //                         : Colors.transparent,
//                       //                     borderRadius:
//                       //                     BorderRadius.circular(16.0),
//                       //                   ),
//                       //                   child: Center(
//                       //                     child: Text(
//                       //                       'Landmark',
//                       //                       style: TextStyle(
//                       //                         fontWeight: FontWeight.w500,
//                       //                         color: (_focusNode3.hasFocus)
//                       //                             ? Colors.black
//                       //                             : Color(0xffB9BEDA),
//                       //                         fontFamily: "Inter",
//                       //                         fontSize:
//                       //                         13, // Background color of the label text
//                       //                       ),
//                       //                     ),
//                       //                   )),
//                       //             ),
//                       //           ),
//                       //         ),
//                       //         if (_validate_area != null) ...[
//                       //           Center(
//                       //             child: ShakeWidget(
//                       //               key: Key("value"),
//                       //               duration: Duration(milliseconds: 700),
//                       //               child: Text(
//                       //                 _validate_area,
//                       //                 style: TextStyle(
//                       //                   fontFamily: "Inter",
//                       //                   fontSize: 13,
//                       //                   color: Color(0xff023047),
//                       //                 ),
//                       //               ),
//                       //             ),
//                       //           ),
//                       //         ],
//                       //
//                       //         SizedBox(
//                       //           height: 20,
//                       //         ),
//                       //         Row(
//                       //           mainAxisAlignment: MainAxisAlignment.center,
//                       //           children: [
//                       //             InkWell(
//                       //               onTap: () {
//                       //                 if (widget.type > 0) {
//                       //                   if (select_address_type == "Other" &&
//                       //                       other_address_type.text == "") {
//                       //                     setState(() {
//                       //                       _validate_other_type =
//                       //                       "Please, Enter other address.";
//                       //                     });
//                       //                   } else if (name_Controller.text == "") {
//                       //                     setState(() {
//                       //                       _validate_name =
//                       //                       "Please, Enter contact name.";
//                       //                     });
//                       //                   } else if (mobile_Controller.text ==
//                       //                       "") {
//                       //                     setState(() {
//                       //                       _validate_no =
//                       //                       "Please, Enter mobile number.";
//                       //                     });
//                       //                   } else if (newHouseNoController.text ==
//                       //                       "") {
//                       //                     setState(() {
//                       //                       _validate_new_house =
//                       //                       "Please, Enter House No & Floor.";
//                       //                     });
//                       //                   } else if (buildingController.text ==
//                       //                       "") {
//                       //                     setState(() {
//                       //                       _validate_houseno_s =
//                       //                       "Please, Enter House No & Floor.";
//                       //                     });
//                       //                   } else if (landmarkController.text ==
//                       //                       "") {
//                       //                     setState(() {
//                       //                       _validate_area =
//                       //                       "Please, Enetr Building name & Block no.";
//                       //                     });
//                       //                   } else {
//                       //                     EditAddressFunction();
//                       //                   }
//                       //                 }
//                       //                 if (widget.type == 0) {
//                       //                   if (select_address_type == "Other" &&
//                       //                       other_address_type.text == "") {
//                       //                     setState(() {
//                       //                       _validate_other_type =
//                       //                       "Please, Enter other address.";
//                       //                     });
//                       //                   } else if (name_Controller.text == "") {
//                       //                     setState(() {
//                       //                       _validate_name =
//                       //                       "Please, Enter contact name.";
//                       //                     });
//                       //                   } else if (mobile_Controller.text ==
//                       //                       "") {
//                       //                     setState(() {
//                       //                       _validate_no =
//                       //                       "Please, Enter mobile number.";
//                       //                     });
//                       //                   } else if (buildingController.text ==
//                       //                       "") {
//                       //                     setState(() {
//                       //                       _validate_houseno_s =
//                       //                       "Please, Enter House No & Floor.";
//                       //                       // print(_validate_houseno_s);
//                       //                     });
//                       //                   } else if (landmarkController.text ==
//                       //                       "") {
//                       //                     setState(() {
//                       //                       _validate_area =
//                       //                       "Please, Enter Building name & Block no.";
//                       //                       // print(_validate_area);
//                       //                     });
//                       //                   } else {
//                       //                     AddAddressFunction();
//                       //                   }
//                       //                 }
//                       //               },
//                       //               child: Container(
//                       //                 height: 40,
//                       //                 width: 300,
//                       //                 decoration: BoxDecoration(
//                       //                     color: Colors.yellow,
//                       //                     borderRadius:
//                       //                     BorderRadius.circular(30)),
//                       //                 child: Center(
//                       //                     child: Text(
//                       //                       "Save",
//                       //                       style: TextStyle(
//                       //                         fontFamily: 'Inter',
//                       //                         letterSpacing: 0.09,
//                       //                         color: Colors.black,
//                       //                         fontWeight: FontWeight.w600,
//                       //                         fontSize: 15,
//                       //                       ),
//                       //                     )),
//                       //               ),
//                       //             ),
//                       //           ],
//                       //         ),
//                       //         SizedBox(
//                       //           height: 20,
//                       //         )
//                       //       ],
//                       //     ),
//                       //   ),
//                       // )
//                     ],
//                   )),
//             );
//           },
//         ));
//       },
//     );
//   }
//
//   Future<void> _showBottomSheet1(context) async {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
//       ),
//       backgroundColor: Color(0xffF4F5FA),
//       isScrollControlled: true,
//       builder: (BuildContext context) {
//         return SafeArea(child: StatefulBuilder(
//           builder: (BuildContext context, StateSetter setState) {
//             return SingleChildScrollView(
//               child: SizedBox(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height * 0.8,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
//                       child: Text(
//                         "Change Location",
//                         style: TextStyle(
//                           fontFamily: 'Inter',
//                           fontSize: 22,
//                           fontWeight: FontWeight.w600,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Align(
//                       alignment: Alignment.center,
//                       child: Container(
//                         width: screenWidth * 0.88,
//                         height: 45,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(25),
//                           border: Border.all(
//                             color: Color(0xFFD6D6D6),
//                             width: 0.5,
//                           ),
//                         ),
//                         child: TextField(
//                           cursorColor: Colors.black,
//                           scrollPadding: const EdgeInsets.only(top: 5),
//                           controller: _searchController,
//                           onChanged: (value) {
//                             setState(() {
//                               searched_string = value;
//                             });
//                             // placeAutoComplete(value);
//                             setState(() {
//                               isPlaceSelected = false;
//                             });
//                           },
//                           style: TextStyle(),
//                           decoration: InputDecoration(
//                             hintText: 'Search your location',
//                             hintStyle: TextStyle(
//                               color: Color(0xFF868686),
//                               fontFamily: "Inter",
//                               fontSize: 15,
//                               fontWeight: FontWeight.normal,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             contentPadding: const EdgeInsets.only(
//                                 left: 30, right: 5, top: 5),
//                             prefixIcon: IconButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                               icon: Icon(
//                                 Icons.search_rounded,
//                                 size: 30,
//                                 // color: Colors.appcolor,
//                               ),
//                             ),
//                             enabledBorder: InputBorder.none,
//                             focusedBorder: InputBorder.none,
//                             border: InputBorder.none,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Align(
//                       alignment: Alignment.center,
//                       child: InkWell(
//                         onTap: () {
//                           setState(() {
//                             address_loading = false;
//                           });
//                           _getCurrentLocation();
//                           Navigator.pop(context);
//                         },
//                         child: Container(
//                           width: screenWidth * 0.88,
//                           height: 45,
//                           padding: EdgeInsets.symmetric(horizontal: 20),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           child: Row(
//                             children: [
//                               Icon(Icons.my_location,
//                                   size: 20, color: Color(0xff219EBC)),
//                               const SizedBox(
//                                 width: 10,
//                               ),
//                               Text("Go to current Location",
//                                   style: TextStyle(
//                                       fontFamily: "Inter",
//                                       fontSize: 13,
//                                       fontWeight: FontWeight.w500,
//                                       overflow: TextOverflow.ellipsis,
//                                       color: Colors.black)),
//                               Spacer(),
//                               Icon(Icons.arrow_forward_ios_sharp,
//                                   size: 20, color: Colors.black),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     // Only visible when no place is selected and there are predictions
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Color(0xffF4F5FA),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       margin: EdgeInsets.symmetric(horizontal: 20),
//                       height: 400, // Set background color to white
//                       child: ListView.builder(
//                         itemCount: placePredictions.length,
//                         itemBuilder: (context, index) {
//                           return Column(
//                             children: [
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(16),
//                                 ),
//                                 child: ListTile(
//                                   leading: SvgPicture.asset(
//                                       "assets/images/Vector.svg"),
//                                   title: Text(
//                                     placePredictions[index].description ?? '',
//                                     maxLines: 2,
//                                     style: TextStyle(
//                                       fontFamily: "Inter",
//                                       // fontSize: FontConstant.Size15,
//                                       letterSpacing: 0.09,
//                                       fontWeight: FontWeight.w500,
//                                       overflow: TextOverflow.ellipsis,
//                                       // color: ColorConstant.appcolor,
//                                     ),
//                                   ),
//                                   onTap: () {
//
//                                     setState(() {
//                                       focusNode.unfocus();
//                                       isPlaceSelected =
//                                       true; // Update place selection state
//                                     });
//                                     Navigator.pop(context);
//                                   },
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               )
//                             ],
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ));
//       },
//     );
//   }
// }
