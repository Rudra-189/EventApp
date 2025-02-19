import 'package:flutter/material.dart';

class search_Page extends StatefulWidget {
  const search_Page({super.key});

  @override
  State<search_Page> createState() => _search_PageState();
}

class _search_PageState extends State<search_Page> {

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.green.shade600,
        leading: GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back,color: Colors.white,size: 20,),),
        title: Text("Search",style: TextStyle(color: Colors.white,fontSize: 18),),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 300,
                    child: TextFormField(
                      controller: searchController,
                      cursorColor: Colors.white,
                      style: TextStyle(color:Colors.white),
                      decoration: InputDecoration(
                        hintText: "Search",
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.09),
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.2),
                                width: 0.25
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: BorderSide(
                              color: Colors.green.shade600,
                              width: 0.5,
                            )
                        ),
                        prefixIcon: Icon(Icons.search,color: Colors.green.shade600,size: 20,),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.09),
                        borderRadius: BorderRadius.circular(11)
                    ),
                    child: Icon(Icons.filter_list,color: Colors.green.shade600,size: 20,),
                  )
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              height: 1000,
              child: ListView.builder(itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.09)
                  ),
                );
              },
                itemCount: 10,
                physics: NeverScrollableScrollPhysics(),
              ),
            )
          ],
        ),
      )
    );
  }
}
