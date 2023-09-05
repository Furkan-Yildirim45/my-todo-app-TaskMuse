import 'package:flutter/material.dart';
import 'package:task_muse/ui_test/bottom_sheet_ui_test/bottom_sheet_mixin.dart';

class BottomSheetUiTest extends StatefulWidget {
  const BottomSheetUiTest({Key? key}) : super(key: key);

  @override
  State<BottomSheetUiTest> createState() => _BottomSheetUiTestState();
}

class _BottomSheetUiTestState extends State<BottomSheetUiTest> with BottomSheetMixin{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: ValueListenableBuilder<String>(
        valueListenable: titleNotifier,
        builder: (context, String value, child) {
          return Text(value);
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: showModelBottomSheetWithMixin,
        child: const Icon(Icons.add),
      ),
    );
  }
}

///baba bottomSheet cok kompleks ve hatalar silsilesi içerir düzgün yapmazsan bunun için adımlar sunlar:
///1. mixin yapıcaksın!
///2.kullandıgın değişkenler olsun instanceler olsun onları da bu mixin'in içine yolla abi
///3.daha sonrasında burdaki showModalBottomSheet kodunu mixinin içinde bi metoda atıyorsun! (ilk etap tammalandı ui ile ayrılma kısmı!)
///4.baba hiçbir zaman setState özelliğini kullanmıyorsun cünkü bi yenileme diger widgetları tetikleyebilir bu yuzden örnek: ValueNotifier kullanılabilir
///5. 4. kısım entegrasyonları bittikten sonra bu mixin metodunda kod o sekilde kalmamalı abi! cünkü bu metot ana bir metot sen gelip birden fazla bototmsheet
///kullanıcagın senaryoda abi ordan türeticegin için ana kısım sürekli olarak aynı kalmamalı! değişebilir olmalı! veya şimdilik o kısmı extract etmelisin!
///
/// şimdi burda bi teknik detayı bahsetmemiz gerek:diyelim ki siz bir stateManagment paketi kullandınız burda bottomSheeti açtıgınız state de hiçbir zaman bu data gelemz
/// sizin bu datayı buraya alabilmeniz için o yeni açılan statelere bunları bi şekilde paslamanız gerkeiyor! bazen derler abi çalısmıyor calısmaması normal!
///6. olarak abi daha temize ve kontrol gücünü katmak amacıyla kendi sayfasındaki bi static metot ile kendi sayfasını cagırıyorum ve orda kontrol ediyorum ben bu
///bottom sheet componentini!
///ama bu onValueSelected yerine bu Future<T?> dönüyormus abi okey bunu kullanalım!
///sonuc olarak tertemiz component kendi içinde calısıyor sıkıntısı vs yok mis
///baba burda şu önemli ayırdıktan sonra alt dallarda oldugun için bu tarz setState işlemlerini yapabilirisn ama yukarıda olsaydın olmazdı cünkü bütün widgetlar
///yenilenicek ve tetiklenicek buna gerke yok!
///valueları asla maple vs dönme direkt olarak model şeklinde dön!!!