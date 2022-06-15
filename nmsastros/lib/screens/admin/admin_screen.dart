import 'package:flutter/material.dart';
import 'package:nmsastros/screens/chart/chart_list_screen.dart';
import 'package:nmsastros/screens/dashboard/itens_dashboard.dart';
import 'package:nmsastros/screens/users/users_list_screen.dart';

class AdminMain extends StatefulWidget {
  final String title;
  const AdminMain(this.title, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return AdminMainState();
  }
}

class AdminMainState extends State<AdminMain>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    super.build(context);
    ItemsDashboard item1 = ItemsDashboard(
      "Mapas",
      "Serviços disponíveis",
      "https://ctl.s6img.com/society6/img/PJ26VBjhcj2PvgvJTVL1-72xAFg/w_1500/wall-clocks/front/white-frame/white-hands/~artwork,fw_3500,fh_3500,iw_3500,ih_3500/s6-original-art-uploads/society6/uploads/misc/40e66b735cac4357a0c9ec14cc262595/~~/vintage-zodiac-astrology-chart-charcoal-gold-wall-clocks.jpg",
    );

    ItemsDashboard item2 = ItemsDashboard(
      "Usuários",
      "Registro de Usuários",
      "https://static.vecteezy.com/ti/vetor-gratis/p1/5005892-user-icon-in-trendy-flat-style-isolated-on-gray-background-user-symbol-for-your-web-site-design-logo-app-ui-vector-illustration-eps10-gr%C3%A1tis-vetor.jpg",
    );

    List<ItemsDashboard> myList = List.empty(growable: true);
    myList.add(item1);
    myList.add(item2);
    return Scaffold(
      // backgroundColor: const Color(0xFFDADAD9),
      backgroundColor: Colors.black12,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20.0),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: myList.length,

                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  childAspectRatio: width / (height / 2),
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => callCommand(context, index),
                    child: Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(myList[index].title),
                            const SizedBox(height: 10),
                            Image.network(
                              myList[index].image,
                              width: 80,
                              height: 60,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                // scrollDirection: Axis.vertical,
              ),
              const SizedBox(height: 20.0),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  callCommand(BuildContext context, int index) {
    if (index == 0) {
      Navigator.of(context).pushNamed("/chart");
    } else if (index == 3) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ChartListScreen(),
        ),
      );
    }
    if (index == 1) {
      Navigator.of(context).pushNamed("/users");
    } else if (index == 3) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const UsersListScreen(),
        ),
      );
    }
  }
}
