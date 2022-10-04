
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class BottomNavigationBarController extends GetxController{
   static var selectedIndex=0.obs;


   static onChanged(index){
     selectedIndex.value=index;

    
   }
}