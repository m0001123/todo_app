import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller/timing_page_controller.dart';

class StartTimingPageController extends GetxController{
  RxInt nowfreq = 1.obs;
  RxBool onStarted = false.obs;
  RxInt spentTime = (25*60).obs;
  List<int> timelist = <int>[];
  RxBool relaxTime = false.obs;
  RxBool isDone = false.obs;
  late ConfettiController confettiControllerTop;
  late Timer timer;
  AudioPlayer player = AudioPlayer();
  @override
  void onInit() async{
    // TODO: implement onInit
    TimingPageController timingPageController = Get.find<TimingPageController>();
    confettiControllerTop = ConfettiController();
    for(int i=1;i<=timingPageController.freq.value;i++){
      timelist.add(timingPageController.focusTime.value*60);
      timelist.add(timingPageController.relaxTime.value*60);
    }
    spentTime.value = timelist[nowfreq.value-1];
    super.onInit();
  }

  @override
  void onReady() async{
    // TODO: implement onReady
    startTiming();
    await player.setSource(AssetSource('music/dim.mp3'));
    player.setReleaseMode(ReleaseMode.stop);
    print('ready');
    super.onReady();
  }
  void playmusic(Source source)async{
    await player.stop();
    await player.play(source);
  }

  void playdim(Source source)async{
    await player.stop();
    await player.play(source);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    if(timer!=null && timer.isActive){
      print('delete timer');
      timer.cancel();
    }
    player.dispose();
    super.dispose();
  }


  void startTiming(){
    onStarted.value = !onStarted.value;
    timer=Timer.periodic(const Duration(seconds: 1), (timer) async {
      if(!onStarted.value){
        timer.cancel();
      }else{
      spentTime.value--;}
      if(nowfreq==timelist.length && spentTime.value==0){
        playmusic(AssetSource('music/done.mp3'));
        isDone.value=true;
        confettiControllerTop.play();
        timer.cancel();
      }
      if(spentTime.value==0 && nowfreq<timelist.length){
        playmusic(AssetSource('music/dim.mp3'));
        relaxTime.value=false;
        nowfreq.value++;
        spentTime.value = timelist[nowfreq.value-1];
        if((nowfreq).isEven) {
          relaxTime.value = true;
        }
      }
    });
  }

}