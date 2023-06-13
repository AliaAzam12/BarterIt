import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:lab_assign_2/config.dart';
import 'package:ndialog/ndialog.dart';

class NewItemScreen extends StatefulWidget {
  const NewItemScreen({Key? key}) : super(key: key);

  @override
  State<NewItemScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {

  final _formKey = GlobalKey<FormState>();
  final focus = FocusNode();
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  final focus4 = FocusNode();

final TextEditingController _itemnameEditingController = TextEditingController();
final TextEditingController _itemdelEditingController = TextEditingController();
final TextEditingController _itemlocalEditingController = TextEditingController();
final TextEditingController _itemstateEditingController = TextEditingController();
final TextEditingController _itemqtyEditingController = TextEditingController();
final TextEditingController _itempriceEditingController = TextEditingController();
final TextEditingController _itemdescEditingController = TextEditingController();

double screenHeight=0.0, screenWidth=0.0;
File? _image;
get pathAsset => "assets/images/camera.jpg";

bool _checked=false;

  late Position currPosition;
String curaddress = "";
 String curstate = "";
  String prlat = "";
  String prlong = ""; 

//List productlist = [];
//String titlecenter = "Loading data...";

  @override
  void initState(){
    super.initState();
    determinePosition();
  }


  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Item Registration Form"),
      ),
      body: Column(children: [
        Flexible(
          flex: 4,
          child: GestureDetector(
            onTap: selectImage,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: _image == null 
                      ? AssetImage(pathAsset)
                      : FileImage(_image!) as ImageProvider,
                      fit: BoxFit.scaleDown,),
                  ),
                ),
              ),
              ),
          ),
        ),
        Flexible(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (val) => val!.isEmpty || (val.length < 3)
                      ? "Item name must be longer than 3" : null,
                      onFieldSubmitted: (v){
                        FocusScope.of(context).requestFocus(focus);
                      },
                      controller: _itemnameEditingController,
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.amber,
                      decoration: const InputDecoration(
                        labelText: "Item Name",
                        labelStyle: TextStyle(),
                        icon: Icon(Icons.person),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        )
                      ),
                    ),

                    TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (val) => val!.isEmpty || (val.length < 10)
                      ? "Item name must be longer than 10" : null,
                      onFieldSubmitted: (v){
                        FocusScope.of(context).requestFocus(focus);
                      },
                       controller: _itemdescEditingController,
                       keyboardType: TextInputType.text,
                       decoration: const InputDecoration(
                        labelText: "Item Description",
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(),
                        icon: Icon(Icons.note),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        )
                      ),
                    ),

                    Row(
                      children: [
                        Flexible(
                          flex: 5,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                           validator: (val) => val!.isEmpty || (val.length < 3)
                           ? "Item price must contain value" : null,
                           focusNode: focus,
                           onFieldSubmitted: (v){
                           FocusScope.of(context).requestFocus(focus1);
                           },
                           controller: _itempriceEditingController,
                           keyboardType: TextInputType.number,
                           cursorColor: Colors.amber,
                           decoration: const InputDecoration(
                           labelText: "Item Price",
                           labelStyle: TextStyle(),
                           icon: Icon(Icons.money),
                           focusedBorder: OutlineInputBorder(
                           borderSide: BorderSide(width: 2.0),
                        )
                      ),
                          )),

                          Flexible(
                          flex: 5,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                           validator: (val) => val!.isEmpty
                           ? "Item Quantity must be more than 0" : null,
                           focusNode: focus1,
                           onFieldSubmitted: (v){
                           FocusScope.of(context).requestFocus(focus2);
                           },
                           controller: _itemqtyEditingController,
                           keyboardType: TextInputType.number,
                           cursorColor: Colors.amber,
                           decoration: const InputDecoration(
                           labelText: "Item Quantity",
                           labelStyle: TextStyle(),
                           icon: Icon(Icons.ad_units),
                           focusedBorder: OutlineInputBorder(
                           borderSide: BorderSide(width: 2.0),
                        )
                      ),
                          )),
                            ],
                    ),

                    Row(
                      children: [
                        Flexible(
                          flex: 5,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                           validator: (val) => val!.isEmpty || (val.length < 3)
                           ? "State" : null,
                           //enabled: false,
                           controller: _itemstateEditingController,
                           keyboardType: TextInputType.text,
                           cursorColor: Colors.amber,
                           decoration: const InputDecoration(
                           labelText: "States",
                           labelStyle: TextStyle(),
                           icon: Icon(Icons.flag),
                           focusedBorder: OutlineInputBorder(
                           borderSide: BorderSide(width: 2.0),
                        )
                      ),
                          )),

                          Flexible(
                            flex: 5, 
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                           validator: (val) => val!.isEmpty || (val.length < 3)
                           ? "Locality" : null,
                           controller: _itemlocalEditingController,
                           keyboardType: TextInputType.text,
                           cursorColor: Colors.amber,
                           decoration: const InputDecoration(
                           labelText: "Locality",
                           labelStyle: TextStyle(),
                           icon: Icon(Icons.map),
                           focusedBorder: OutlineInputBorder(
                           borderSide: BorderSide(width: 2.0),
                        )
                      ),
                          ),
                )], ),
                    

                    Row(
                      children: [
                        Flexible(
                          flex: 5,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                           validator: (val) => val!.isEmpty
                           ? "Must be more than 0" : null,
                           focusNode: focus3,
                           onFieldSubmitted: (v){
                            FocusScope.of(context).requestFocus(focus4);
                           },
                           controller: _itemdelEditingController,
                           keyboardType: TextInputType.number,
                           decoration: const InputDecoration(
                           labelText: "Delivery charge",
                           labelStyle: TextStyle(),
                           icon: Icon(Icons.delivery_dining),
                           focusedBorder: OutlineInputBorder(
                           borderSide: BorderSide(width: 2.0),
                        )
                      ),
                          ),
                        ),

                        Flexible(
                          flex: 5,
                          child: CheckboxListTile(
                            title: const Text("Legal Item?", style: TextStyle(color: Colors.white),),
                            value: _checked,
                            onChanged: (bool? value){
                              setState(() {
                                _checked = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(screenWidth, screenHeight / 13)),
                        child: const Text("Add Item", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        onPressed: () => {
                          _addItemDialog()
                        },
                    ),

                  ],
                ),
              ),
            ),
            ),
        )
      ],),
    );
  }
  
 void _addItemDialog() {
   if(!_formKey.currentState!.validate()){
    Fluttertoast.showToast(
      msg: "Please fill in all information",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      fontSize: 14);
      return;
   }

   if(_image == null){
    Fluttertoast.showToast(
      msg: "Please take a product picture",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      fontSize: 14);
      return;
   }

   showDialog(
    context: context, 
    builder: (BuildContext context){
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text("Are you sure", style: TextStyle(),),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                addNewProduct();
              }, 
              child: const Text("Yes", style: TextStyle())),

              TextButton(
                child: const Text("No", style: TextStyle(),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
          ],
      );
    });
 }



  void selectImage() {
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text("Select from"),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(screenWidth / 4, screenHeight / 6)
              ),
              child: const Text('Gallery'),
              onPressed: () => {
                Navigator.of(context).pop(),
                selectGallery(),
              },
            ),

             ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(screenWidth / 4, screenHeight / 6),
              ),
              child: const Text('Camera'),
              onPressed: () => {
                Navigator.of(context).pop(),
                selectCamera(),
              },
            ),
          ],
        ));
      }
      );}
  
  Future <void> selectGallery() async {
    final picker = ImagePicker();
    final PickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 800,
    );

    if(PickedFile != null){
      _image = File(PickedFile.path);
      cropImage();
    }else{
      print("No image selected");
    }
  }

  
  Future <void> selectCamera() async {
    final picker = ImagePicker();
    final PickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 800,
      maxWidth: 800,
    );

    if(PickedFile != null){
      _image = File(PickedFile.path);
      cropImage();
    }else{
      print("No image selected");
    }
  }

  Future<void> cropImage() async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: _image!.path,
        aspectRatioPresets:
             [
              CropAspectRatioPreset.ratio5x4,
      
              ],
              uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop',
            toolbarColor: Colors.green[600],
            toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.ratio5x4,
            lockAspectRatio: true),
        IOSUiSettings(
          title: 'Crop Image',
        )]);
    if (croppedFile != null) {
      File imageFile = File(croppedFile.path);
      _image = imageFile;
      int? sizeInBytes = _image?.lengthSync();
      double sizeInMb = sizeInBytes! /  (1024 * 1024);
      print(sizeInBytes);

      setState(() {});
    }
  }

  void determinePosition() async{
    bool serviceEnabled;
      LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      return Future.error('Location services are disabled');
    }

    permission= await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
        }
    }

    if(permission == LocationPermission.deniedForever){
      print('Location permission are permanantly denied');
      return;
    }
    currPosition = await Geolocator.getCurrentPosition();
    getAddress(currPosition);
    //return await Geolocator.getCurrentPosition();
  }
  
  getAddress(Position pos) async {
    List <Placemark> placemarks = await placemarkFromCoordinates(pos.latitude, pos.longitude);
    if(placemarks.isEmpty){
       _itemlocalEditingController.text = "Changlun";
      _itemstateEditingController.text = "Kedah";
      prlat = "6.443455345";
      prlong = "100.05488449";
    }else{
      _itemlocalEditingController.text = placemarks [0].locality.toString();
      _itemstateEditingController.text = placemarks [0].administrativeArea.toString();
      prlat = currPosition.latitude.toString();
      prlong = currPosition.longitude.toString();
    }
    setState(() {
      
    });
  }
  
  void addNewProduct() {
    String name = _itemnameEditingController.text;
    String desc = _itemdescEditingController.text;
    String price = _itempriceEditingController.text;
    String qty = _itemqtyEditingController.text;
    String del = _itemdelEditingController.text;
    String state = _itemstateEditingController.text;
    String loc = _itemlocalEditingController.text;
    print(name + " "+ desc+" "+price+" "+qty+" "+del+" "+state+" "+loc);

    FocusScope.of(context).requestFocus(FocusNode());
    FocusScope.of(context).unfocus();
    ProgressDialog progressDialog = ProgressDialog(
      context, 
      title: const Text("Processing..."), 
      message: const Text("Adding new product.."));
      progressDialog.show();

      String base64Image = base64Encode(_image!.readAsBytesSync());

      http.post(Uri.parse("${MyConfig().SERVER}/labassign2/php/new_item.php"),
      body: {
        "prname": name,
        "prdesc": desc,
        "prprice": price,
        "prqty": qty,
        "prdel": del,
        "prstate": state,
        "prloc": loc,
        "prlat": prlat,
        "prlong": prlong,
        "image": base64Image,
      }).then((response){
        print(response.body);
        progressDialog.dismiss();

       // var data = jsonDecode(response.body);
       /*if(response.statusCode == 200 && data['status'] == 'success'){
          Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14);
            progressDialog.dismiss();
            Navigator.of(context).pop();
            return;
        }else{
          Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14);
            progressDialog.dismiss();
            return;
        }
      });
  }*/

  /*loadItem(){
    String name = _itemnameEditingController.text;

    http.post(Uri.parse("${MyConfig().SERVER}/labassign2/php/new_item.php"),
    body: {
      
      "prname": name,
      }).then((response){
        print(response.body);

        var data = jsonDecode(response.body);
        if (response.statusCode == 200 && data['status'] == 'success') {
          var extractdata = data['data'];
          setState(() {
            productlist = extractdata["items"];
            print(productlist);
          });
        }else{
          setState(() {
            titlecenter = "No Data";
          });
        }*/

    });
  }
  
  
}