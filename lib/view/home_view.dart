import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {



  // CARD
  Widget botaoCard({

    required IconData icone,
    required String texto,
    required VoidCallback onTap,

  }) {

    return InkWell(

      onTap: onTap,

      borderRadius: BorderRadius.circular(20),

      child: Container(

        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(

          color: Colors.grey[200],

          borderRadius: BorderRadius.circular(20),

          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),

        child: Column(

          mainAxisSize: MainAxisSize.min,

          children: [

            Icon(
              icone,
              size: 50,
              color: Colors.grey[700],
            ),

            const SizedBox(height: 15),

            Text(
              texto,
              textAlign: TextAlign.center,

              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[800],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFE8F5E9),

      appBar: AppBar(

        title: const Text('Home'),

        centerTitle: true,

        backgroundColor: Colors.green[700],
      ),

      body: Center(

        child: SingleChildScrollView(

          child: Column(
            children: [

              // LOGO
              Column(
                children: [

                  Icon(
                    Icons.coronavirus_outlined,
                    color: Colors.green[700],
                    size: 70,
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Chimeric',

                    style: TextStyle(
                      color: Colors.green[800],
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // CONTAINER
              Container(

                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),

                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(

                  color: Colors.white,

                  borderRadius: BorderRadius.circular(20),

                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),

                child: Column(
                  children: [

                    // PRIMEIRA LINHA
                    Row(
                      children: [

                        Expanded(
                          child: botaoCard(

                            icone: Icons.add,

                            texto: 'Novo',

                            onTap: () {

                              Navigator.pushNamed(
                                context,
                                'novo',
                              );
                            },
                          ),
                        ),

                        const SizedBox(width: 15),

                        Expanded(
                          child: botaoCard(

                            icone:
                                Icons.access_time_filled,

                            texto: 'Em curso',

                            onTap: () {

                              Navigator.pushNamed(
                                context,
                                'emcurso',
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    // SEGUNDA LINHA
                    Row(
                      children: [

                        Expanded(
                          child: botaoCard(

                            icone: Icons.search,

                            texto: 'Pesquisar',

                            onTap: () {

                              Navigator.pushNamed(
                                context,
                                'pesquisar',
                              );
                            },
                          ),
                        ),

                        const Expanded(
                          child: SizedBox(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // MENU INFERIOR
      bottomNavigationBar: BottomNavigationBar(

        currentIndex: 1,

        selectedItemColor: Colors.green[700],

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Sobre',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            label: 'Sair',
          ),
        ],

        onTap: (index) {

          // SOBRE
          if (index == 0) {

            Navigator.pushNamed(
              context,
              'sobre',
            );
          }

          // SAIR
          if (index == 2) {

            showDialog(

              context: context,

              builder: (context) => AlertDialog(

                title: const Text('Sair'),

                content: const Text(
                  'Deseja realmente sair?',
                ),

                actions: [

                  TextButton(

                    onPressed: () {

                      Navigator.pop(context);
                    },

                    child: const Text('Cancelar'),
                  ),

                  TextButton(

                    onPressed: () {

                       Navigator.pop(context);

                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        'login',
                        (route) => false,
                      );
                    },

                    child: const Text('Sair'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}