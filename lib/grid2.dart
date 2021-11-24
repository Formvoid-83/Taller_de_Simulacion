import 'package:flutter/material.dart';

class Grid2 extends StatefulWidget {
  Grid2({Key? key}) : super(key: key);

  @override
  _Grid2State createState() => _Grid2State();
}

class _Grid2State extends State<Grid2> {

  List<String> arr = List.generate(50, (index) => index.toString());
  List<TextEditingController> cont = List.generate(50, (index) => TextEditingController(text: '$index'));

  @override
  Widget build(BuildContext context) {
   List<Widget>list = [];
   for(int i  = 0 ; i < arr.length ; i++)
    list.add(Container(
             height: 100,
             width: 200,
             child: TextFormField(
                // initialValue: arr[i],
                controller: cont[i],
             ),
           )); 
    return Scaffold(
      body: GridView.count(crossAxisCount: 6,
        // gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        //         maxCrossAxisExtent:1080/6 ,
        //         childAspectRatio: 2/1,
        //         crossAxisSpacing: 0,
        //         mainAxisSpacing: 0), 
        //  itemCount: arr.length,

        //  itemBuilder:(context , i  ){
        //    return Container(
        //      height: 100,
        //      width: 200,
        //      child: TextFormField(
        //         initialValue: arr[i],
        //      ),
        //    );
        //  }),
        children: list )
    );
  }
}