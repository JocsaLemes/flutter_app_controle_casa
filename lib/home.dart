import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_controle_casa/mqtt.dart';
import 'package:flutter_app_controle_casa/widgets/cabecalho.dart';
import 'package:flutter_app_controle_casa/widgets/configuracao.dart';
import 'package:mqtt_client/mqtt_client.dart';
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
  bool btLampClosed = false;
  bool btLampQuarto = false;
  bool btJanela = false;
  bool bttv = false;
  bool btsom = false;
  int counter = 0;

  bool quarto = false;
  bool sala = false;
  int cont = 0;

  late Broker broker; // Declare a variável broker
  final client = MqttServerClient('mqtt.eclipseprojects.io', 'Jota');

  @override
  void initState() {
    super.initState();
    broker = Broker(client); // Inicialize broker dentro do initState
    broker.conectar().then((_) {
      broker.subscribe("luz", MqttQos.atLeastOnce, (String status) {
        setState(() {
          if (status == "true") {
            btLampClosed = true;
          } else {
            btLampClosed = false;
          }
        });
      });
    }); // Chame o método conectar do Broker
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
                          //Quarto
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
                                  onPressed: () {
                                    setState(() {
                                      cont++;
                                      quarto = true;
                                      print("cont antes do if $cont");
                                      if (cont == 2) {
                                        quarto = false;
                                        cont = 0;
                                        btJanela = false;
                                        btLampQuarto = false;
                                        btLampClosed = false;

                                        print("cont no if $cont");
                                      }
                                    });
                                  },
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
                          //Sala
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
                                    onPressed: () {
                                      setState(() {
                                        cont++;
                                        sala = true;
                                        print("cont antes do if $cont");
                                        if (cont == 2) {
                                          sala = false;
                                          cont = 0;
                                          btJanela = false;
                                          btLampQuarto = false;
                                          btLampClosed = false;

                                          print("cont no if $cont");
                                        }
                                      });
                                    },
                                    icon: const Icon(Icons.living_outlined,
                                        size: 40),
                                  ),
                                  const Text(
                                    "5 dispositivos",
                                    style: TextStyle(fontSize: 8),
                                  )
                                ],
                              ),
                            ),
                          ),
                          //Banheiro
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
                                  "1 dispositivos",
                                  style: TextStyle(fontSize: 8),
                                )
                              ],
                            ),
                          ),
                          //Cozinha
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
                                    "Cozinha",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.blender, size: 40),
                                  ),
                                  const Text(
                                    "6 dispositivos",
                                    style: TextStyle(fontSize: 8),
                                  )
                                ],
                              ),
                            ),
                          ),
                          //Garagem
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
                                  icon: const Icon(Icons.garage, size: 40),
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

                    //Dispositivos do quarto
                    //Texto dispositivos do quarto
                    Visibility(
                      visible: quarto,
                      child: const Text("Dispositivos do quarto",
                          style: TextStyle(
                            fontSize: 20,
                          )),
                    ),
                    //Itens presentes no quarto
                    Visibility(
                      visible: quarto,
                      child: SingleChildScrollView(
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
                                      btLampQuarto = false;
                                      btLampClosed = false;
                                      btJanela = true;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.window_outlined,
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
                                            color: const Color.fromARGB(
                                                    255, 0, 0, 0)
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
                                        btLampQuarto = true;
                                        btLampClosed = false;
                                        btJanela = false;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.lightbulb_circle,
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
                                            color: const Color.fromARGB(
                                                    255, 0, 0, 0)
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
                                        btLampClosed = true;
                                        btLampQuarto = false;
                                        btJanela = false;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.light_outlined,
                                      size: 32,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //Texto configurações do quarto
                    Visibility(
                      visible: quarto,
                      child: const Text("Configurações do quarto",
                          style: TextStyle(
                            fontSize: 20,
                          )),
                    ),
                    //Itens das configurações de cada dispositivo
                    if (btJanela)
                      Configuracao(
                        titulo: "Janela",
                        icone: Icons.window,
                        icone2: Icons.width_normal_rounded,
                        infor: 'Tranca',
                        infor2: "Sinal",
                        topico: "cortina", //trocar cortina para o topico novo
                        valor: false,
                        //status: "",
                      ),
                    if (btLampQuarto)
                      Configuracao(
                        titulo: "Luz quarto",
                        icone: Icons.light,
                        icone2: Icons.light_mode_rounded,
                        infor: "Status",
                        infor2: "Brilho",
                        topico: "ar", //trocar topico para o novo
                        valor: true,
                        //status: '${btLampQuarto ? "trancado":"destrancado"}',
                      ),
                    if (btLampClosed)
                      const Configuracao(
                        titulo: "Luz closed",
                        icone: Icons.light,
                        icone2: Icons.light_mode_outlined,
                        infor: "Status",
                        infor2: "Brilho",
                        topico: "luz", //trocar topico para o novo
                        valor: true,
                        //status: "trancado",
                      ),


                      //Itens presentes na sala
                    Visibility(
                      visible: sala,
                      child: SingleChildScrollView(
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
                                      //btLampQuarto = false;
                                      //btLampClosed = false;
                                      //btJanela = true;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.window_outlined,
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
                                            color: const Color.fromARGB(
                                                    255, 0, 0, 0)
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
                                        //btLampQuarto = true;
                                        //btLampClosed = false;
                                        //btJanela = false;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.lightbulb_circle,
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
                                            color: const Color.fromARGB(
                                                    255, 0, 0, 0)
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
                                        //btLampClosed = true;
                                        //btLampQuarto = false;
                                        //btJanela = false;
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
                                            color: const Color.fromARGB(
                                                    255, 0, 0, 0)
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
                                        //btLampQuarto = true;
                                        //btLampClosed = false;
                                        //btJanela = false;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.lightbulb_circle,
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
                                            color: const Color.fromARGB(
                                                    255, 0, 0, 0)
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
                                        //btLampClosed = true;
                                        //btLampQuarto = false;
                                        //btJanela = false;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.light_outlined,
                                      size: 32,
                                    ),
                                  )),
                            ),
                          
                          ],
                        ),
                      ),
                    ),
                    
                  ],
                ),
              )
            ],
          ),
        ]));
  }
}
