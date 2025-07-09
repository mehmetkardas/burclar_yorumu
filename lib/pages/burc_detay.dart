import 'package:burclar_yorumu/model/burc.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class BurcDetay extends StatefulWidget {
  final Burc secilenBurc;
  const BurcDetay({super.key, required this.secilenBurc});

  @override
  State<BurcDetay> createState() => _BurcDetayState();
}

class _BurcDetayState extends State<BurcDetay> {
  //Burc detay sayfasında yukarı kaydırınca büyük resmin rengini alıp appbara veririz.
  Color appBarRengi = Colors.pink;
  late PaletteGenerator _generator;

  @override
  void initState() {
    appBarRenginiBul();
    super.initState();
  }

  void appBarRenginiBul() async {
    _generator = await PaletteGenerator.fromImageProvider(
      AssetImage("images/${widget.secilenBurc.burcBuyukResim}"),
    );

    setState(() {
      appBarRengi = _generator.vibrantColor!.color;
    });
    print(appBarRengi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: appBarRengi,
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text("${widget.secilenBurc.burcAdi} Burcu ve Özellikleri"),
              background: Image.asset(
                "images/${widget.secilenBurc.burcBuyukResim}",
                fit: BoxFit.cover,
              ),
            ),
          ),
          //eğer custom içinde normal bir widget kullanmak istiyorsanız..
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Text(
                  widget.secilenBurc.burcDetay,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
