import 'package:docotg/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ReportPage extends StatefulWidget {
  final snap;
  const ReportPage({super.key, this.snap});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
 
  @override
  Widget build(BuildContext context) {
     var items = widget.snap['description'];
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueColor,
        title: Text("Report"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(width*0.07),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("X-Ray Image",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),),
              SizedBox(height: height*0.02,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(widget.snap['postUrl']),
                  fit: BoxFit.cover
                ),
              ),
                  height: height*0.35,
                  width: double.infinity,
        ),
        SizedBox(height: height*0.02,),
         Text("Symptoms",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),),
              SizedBox(height: height*0.02,),
              Expanded(
                child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 80,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                child: Text(
                  items[index],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                ),);}
                
                ),
              )
          ]),
        )
      ),
    );
  }
}