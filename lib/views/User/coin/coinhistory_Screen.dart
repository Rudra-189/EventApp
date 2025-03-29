import 'package:event_project_01/views/User/coin/coinControler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../../App_Resources/App_Screen_Size.dart';

class coinhistoryScreen extends StatefulWidget {
  const coinhistoryScreen({super.key});

  @override
  State<coinhistoryScreen> createState() => _coinhistoryScreenState();
}

class _coinhistoryScreenState extends State<coinhistoryScreen> {

  final coinControler controler = Get.put(coinControler());

  @override
  void initState() {
    super.initState();
    controler.getCoinHistory();
  }

  @override
  Widget build(BuildContext context) {

    final height = AppScreenSize.height(context);
    final width = AppScreenSize.width(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green.shade600,
          leading: GestureDetector(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back,size: 18,color: Colors.white,),
          ),
          title: Text("COIN",style: TextStyle(color: Colors.white,fontSize: 16,letterSpacing: 2),),
          centerTitle: true,
        ),
      body: Obx(() {
        if(controler.isLoading.value){
          return Center(child: CircularProgressIndicator(color: Colors.green.shade600,));
        }else{
          final data = controler.coinHistory;
          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: height * 0.02,),
                  SvgPicture.asset("assets/images/coin.svg",height: 50,width: 50,),
                  SizedBox(height: height * 0.025,),
                  Text("EraCoin balance",style: TextStyle(color: Colors.white,fontSize: 14,letterSpacing: 1),),
                  SizedBox(height: height * 0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/images/coin.svg",height: 20,width: 20,),
                      SizedBox(width: 5,),
                      Text("${controler.availableCoin ?? 0}",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                    ],
                  ),
                  SizedBox(height: height * 0.03,),
                  ListView.builder(itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15)
                      ),
                      alignment: Alignment.center,
                      child: ListTile(
                        leading: SvgPicture.asset("assets/images/coin.svg",height: 25,width: 25,),
                        title: Text(data[index]['title'],style: TextStyle(color: Colors.white,fontSize: 14),),
                        subtitle: Text("${DateFormat('dd MMM').format(data[index]['timestamp'])}",style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 12),),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(data[index]['type'] == "reward" ? "+" : "-",style: TextStyle(color:data[index]['type'] == "reward" ? Colors.green.shade600 : Colors.white,fontSize: 14),),
                            SizedBox(width: 3,),
                            SvgPicture.asset("assets/images/coin.svg",height: 15,width: 15,),
                            SizedBox(width: 3,),
                            Text("${data[index]['amount']}",style: TextStyle(color:data[index]['type'] == "reward" ? Colors.green.shade600 : Colors.white,fontSize: 14,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    );
                  },
                    itemCount: data.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                  )
                ],
              ),
            ),
          );
        }
      },),
    );
  }
}
