import 'package:get/get.dart';

class TimingPageController extends GetxController{
  RxInt focusTime = 25.obs;
  RxInt relaxTime = 5.obs;
  RxInt freq = 4.obs;

  void changeFocusTime(int value){
    focusTime.value = value;
  }
  void changeRelaxTime(int value){
    relaxTime.value = value;
  }
  void changeFreq(int value){
    freq.value = value;
  }

}