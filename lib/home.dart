import 'package:flutter/material.dart';
import 'package:flutter_app_controle_casa/mqtt.dart';
import 'package:flutter_app_controle_casa/widgets/cabecalho.dart';
import 'package:flutter_app_controle_casa/widgets/configuracao.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool valor = false;
  String valorR = "";
  double valorSlider = 0;
  bool btlamp = false;
  bool btar = false;
  bool btwifi = false;
  bool bttv = false;
  bool btsom = false;
  int counter = 0;

  late Broker broker; // Declare a variável broker
  final client = MqttServerClient('mqtt.eclipseprojects.io', '');

  @override
  void initState() {
    super.initState();
    broker = Broker(client); // Inicialize broker dentro do initState
    broker.conectar(); // Chame o método conectar do Broker
    
  }

  Cabecalho cabecalho =
      Cabecalho("S m a r t H o m e", "assets/casa_cabecalho.png");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 56, 210, 252),
        body: ListView(children: [
          Column(
            children: [
              cabecalho.cabecalho(),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Ambietes",
                        style: TextStyle(
                          fontSize: 20,
                        )),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color.fromARGB(255, 0, 0, 0)
                                          .withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 5)),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(11)),
                            child: Column(
                              children: [
                                const Text(
                                  "Quarto",
                                  style: TextStyle(fontSize: 13),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon:
                                      const Icon(Icons.bed_outlined, size: 40),
                                ),
                                const Text(
                                  "3 dispositivos",
                                  style: TextStyle(fontSize: 8),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0)
                                                .withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(0, 5)),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(11)),
                              child: Column(
                                children: [
                                  const Text(
                                    "Sala",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.living_outlined,
                                        size: 40),
                                  ),
                                  const Text(
                                    "4 dispositivos",
                                    style: TextStyle(fontSize: 8),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color.fromARGB(255, 0, 0, 0)
                                          .withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 5)),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(11)),
                            child: Column(
                              children: [
                                const Text(
                                  "Banheiro",
                                  style: TextStyle(fontSize: 13),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.bathtub_outlined,
                                      size: 40),
                                ),
                                const Text(
                                  "2 dispositivos",
                                  style: TextStyle(fontSize: 8),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text("Dispositivos",
                        style: TextStyle(
                          fontSize: 20,
                        )),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0)
                                                .withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(0, 5)),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(51)),
                              child: IconButton(
                                onPressed: () {
                                  
                                  setState(() {
                                    btar = false;
                                    btlamp = false;
                                    btsom =  false;
                                    bttv =  false;
                                    btwifi = true;
                                  });
                                },
                                icon: Icon(
                                  Icons.wifi_rounded,
                                  size: 30,
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              const Color.fromARGB(255, 0, 0, 0)
                                                  .withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0, 5)),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(51)),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      btar = true;
                                    btlamp = false;
                                    btsom =  false;
                                    bttv =  false;
                                    btwifi = false;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.air_outlined,
                                    size: 30,
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                            child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              const Color.fromARGB(255, 0, 0, 0)
                                                  .withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0, 5)),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(51)),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      btlamp = true;
                                      btar = false;
                                    
                                    btsom =  false;
                                    bttv =  false;
                                    btwifi = false;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.light_outlined,
                                    size: 32,
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                            child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              const Color.fromARGB(255, 0, 0, 0)
                                                  .withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0, 5)),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(51)),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      bttv = true;
                                      btar = false;
                                    btlamp = false;
                                    btsom =  false;
                                    
                                    btwifi = false;
                                    });
                                  },
                                  icon: Icon(Icons.tv_rounded, size: 30),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                            child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              const Color.fromARGB(255, 0, 0, 0)
                                                  .withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0, 5)),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(51)),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      btsom = true;
                                      btar = false;
                                    btlamp = false;
                                    
                                    bttv =  false;
                                    btwifi = false;
                                    });
                                  },
                                  icon: Icon(Icons.volume_up, size: 30),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                            child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              const Color.fromARGB(255, 0, 0, 0)
                                                  .withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0, 5)),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(51)),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.abc),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                            child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              const Color.fromARGB(255, 0, 0, 0)
                                                  .withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0, 5)),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(51)),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.abc),
                                )),
                          ),
                        ],
                      ),
                    ),
                    const Text("Configurações",
                        style: TextStyle(
                          fontSize: 20,
                        )),
                    if (btwifi)
                      Configuracao(
                        titulo: "Wiriless",
                        icone: Icons.wifi,
                        icone2: Icons.wifi_1_bar,
                        infor: 'Status',
                        infor2: "Sinal",
                        topico: "wifi",
                      ),
                    if (btar)
                      Configuracao(
                          titulo: "Ar",
                          icone: Icons.air,
                          icone2: Icons.mode_fan_off_outlined,
                          infor: "Status",
                          infor2: "Temperatura",
                          topico: "ar",
                          ),
                    if (btlamp)
                      const Configuracao(
                        titulo: "Lâmpada de filamento",
                        icone: Icons.light,
                        icone2: Icons.light_mode_outlined,
                        infor: "Status",
                        infor2: "Brilho",
                        topico: "luzes",
                      )
                  ],
                ),
              )
            ],
          ),
        ]));
  }
}
