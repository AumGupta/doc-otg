import 'dart:typed_data';

import 'package:docotg/screens/mobile_screen_layout.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../resources/auth_methods.dart';
import '../utils/constants.dart';
import '../utils/utils.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key, required this.email, required this.password,required this.isDoctor});
  final String email;
  final String password;
  final bool isDoctor;

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  String dropdownvalue = 'Male';   
  Uint8List? _image;
  bool _isLoading = false;
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  int age = 18;

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String result = widget.isDoctor? 
    await AuthMethods().signUpDoc(
        fname: _fnameController.text,
        email: widget.email,
        password: widget.password,
        lname: _lnameController.text,
        gender: dropdownvalue,
        number: _numberController.text,
        nationality: _nationalityController.text,
        age: age,
        file: _image!)
    :await AuthMethods().signUpUser(
        fname: _fnameController.text,
        email: widget.email,
        password: widget.password,
        lname: _lnameController.text,
        gender: dropdownvalue,
        number: _numberController.text,
        nationality: _nationalityController.text,
        age: age,
        file: _image!);

    setState(() {
      _isLoading = false;
    });

    if (result != "success") {
      showSnackBar(result, context);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MobileScreenLayout(isDoctor: widget.isDoctor)));
    }
  }
  
  // List of items in our dropdown menu
  var items = [    
    'Male',
    'Female',
    'Others'
  ];
  String nationalitydropdownvalue = '';

  
  
  @override
  Widget build(BuildContext context) {
    void increment(){
      setState(() {
        age++;
      });
    }
    void decrement(){
      setState(() {
        age--;
      });
    }
     var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
       backgroundColor: screenBgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.all(width*0.07),
            child: Form(
              key: formKey,
              child: Column(
                
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text("Let's know you",style: TextStyle(fontWeight: FontWeight.bold,fontSize: height*0.045),),
                      Text("better!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: height*0.045),),
                      SizedBox(height: height*0.015,),
                      Text("Please share your details",style: TextStyle(color: greyColor,fontSize: 15),),
                      SizedBox(height: height*0.045,),
                       GestureDetector(
                        onTap: selectImage,
                         child: Center(
                           child: _image != null
                                         ? CircleAvatar(
                          radius: 64, backgroundImage: MemoryImage(_image!))
                                         : Container(
                                         height: height*0.15,
                                         width: height*0.15,
                                         decoration: BoxDecoration(
                            color: blueTint,
                            borderRadius: const BorderRadius.all(Radius.circular(100))),
                                         child: Icon(
                                           Icons.add_a_photo_outlined,
                                           color: Colors.grey,
                                           size: height*0.07,
                                         )),
                         ),
                       ),
                  SizedBox(height: height*0.08,),
                  const Text("Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  SizedBox(height: height*0.02,),
                  Row(
                    children: [
                      Expanded(child: TextFormField(
                        validator: (value) {
                    if (value!.isEmpty) {
                        return 'Please enter your first name';
                    }
                    return null;
                },
                        controller: _fnameController,
                        decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                      
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
              width: 3, color: Colors.greenAccent),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical:15,horizontal: 20),
                      hintText: 'First name',
                      hintStyle: TextStyle(color: Color(0xFFacb1c8))
                      ))),
                     const SizedBox(width: 9,),
                      Expanded(child: TextFormField(
                        controller: _lnameController,
                           validator: (value) {
                    if (value!.isEmpty) {
                        return 'Please enter your last name';
                    }
                    return null;
                },
                        decoration: const InputDecoration(
                       border: OutlineInputBorder(
                        borderSide: BorderSide(
              width: 3, color: Colors.greenAccent),
                      ),
                       fillColor: Colors.white,
                        filled: true,
                      contentPadding: EdgeInsets.symmetric(vertical:15,horizontal: 20),
                      hintText: 'Last name',
                      hintStyle: TextStyle(color: Color(0xFFacb1c8))
                      )))
                    ],
                  ),
                  SizedBox(height: height*0.02,),
                  const Text("Age",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  SizedBox(height: height*0.01,),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: decrement,
                        child: CircleAvatar(
                          radius: width*0.06,
                          backgroundColor: lightGreenColor,
                          child: Icon(Icons.remove,color: greenColor,),
                        ),
                      ),
                      const SizedBox(width: 15,),
                      Container(
                        width: width*0.29,
                        height: height*0.06,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                        child: Center(child: Text("$age")),
                      ),
                      const SizedBox(width: 15,),
                       GestureDetector(
                        onTap: increment,
                         child: CircleAvatar(
                          radius: width*0.06,
                          backgroundColor: lightGreenColor,
                          child: Icon(Icons.add,color: greenColor,),
                                             ),
                       ),
                    ],
                  ),
                  SizedBox(height: height*0.02,),
                  const Text("Gender",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  SizedBox(height: height*0.01,),
                   Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                    
                     child: Padding(
                       padding:  EdgeInsets.symmetric(horizontal: width*0.05),
                       child: DropdownButton(
                        underline: const SizedBox(),
                        hint: const Text("Gender"),
                        
                  // Initial Value
                  value: dropdownvalue,
                  isExpanded: true,
                        
                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),    
                        
                  // Array list of items
                  items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) { 
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                  },
                ),
                     ),
                   ),
                    SizedBox(height: height*0.02,),
                  const Text("Nationality",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  SizedBox(height: height*0.01,),
                  TextFormField(
                    controller: _nationalityController,
                       validator: (value) {
                    if (value!.isEmpty) {
                        return 'Please enter your Nationality';
                    }
                    return null;
                },
                        decoration: const InputDecoration(
                       border: OutlineInputBorder(
                        borderSide: BorderSide(
              width: 3, color: Colors.greenAccent),
                      ),
                       fillColor: Colors.white,
                        filled: true,
                      contentPadding: EdgeInsets.symmetric(vertical:15,horizontal: 20),
                      hintText: 'Nationality',
                      hintStyle: TextStyle(color: Color(0xFFacb1c8))
                      )),
                       SizedBox(height: height*0.02,),
                  const Text("Phone Number",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  SizedBox(height: height*0.01,),
                  TextFormField(
                    controller: _numberController,
                       validator: (value) {
                    if (value!.isEmpty) {
                        return 'Please enter your number';
                    }
                    return null;
                },
                        decoration: const InputDecoration(
                       border: OutlineInputBorder(
                        borderSide: BorderSide(
              width: 3, color: Colors.greenAccent),
                      ),
                       fillColor: Colors.white,
                        filled: true,
                      contentPadding: EdgeInsets.symmetric(vertical:15,horizontal: 20),
                      hintText: 'Phone Number',
                      hintStyle: TextStyle(color: Color(0xFFacb1c8))
                      )),
                      SizedBox(height: height*0.07,),
                      GestureDetector(
                        onTap: signUpUser,
                        child: Container(
                                          width: double.infinity,
                                          height: 50,
                                          decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color(0xff585ce5)
                                          ),
                                          child:_isLoading
                                          ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.greenAccent,
                          ),
                        )
                                          : const Center(child: Text("Submit")),
                                          ),
                      )
                    
                    
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}