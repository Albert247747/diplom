import 'package:diplom/ui/common/theme/colors.dart';
import 'package:diplom/ui/mobile/detail_vacancy/detail_vacancy.dart';
import 'package:diplom/ui/mobile/main_screen/widgets/profile.dart';
import 'package:diplom/ui/mobile/main_screen/widgets/vacancy_item.dart';
import 'package:diplom/utils/translations.g.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int currentIndex = 0;

  final List<Widget> pages = [
    const HomePage(),
    const Center(child: Text('Избранное')),
    const Center(child: Text('Сообщения')),
    const Profile(user: 'Гатиятуллин Альберт Рустемович', post: 'Официант'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackground,

      body: pages[currentIndex],

      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },

          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,

          showSelectedLabels: false,
          showUnselectedLabels: false,

          selectedItemColor: mainGreen,
          unselectedItemColor: Colors.grey,

          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: '',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded),
              label: '',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.chat_rounded),
              label: '',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackground,

      appBar: AppBar(
        title: Text(
          context.t.mobile.shifts,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        backgroundColor: mainBackground,
      ),

      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),

        child: ListView.builder(
          itemCount: 10,

          itemBuilder: (context, index) {
            return Column(
              children: [

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DetailVacancy(
                          post: 'Официант',
                          price: 2000,
                          date: '11.10.2026',
                          time: '11:00 - 23:45',
                          totalUser: 12,
                          currentUser: 2,
                          comment:
                          'Работаем быстро. Гости максимально придирчивые и требовательные.',
                          requirements:
                          'дресс-код(рубашка, брюки, темная обувь)',
                        ),
                      ),
                    );
                  },

                  child: const VacancyItem(
                    timing: '12:00 - 00:00',
                    dateEvent: '12.10.26',
                    salary: '1000',
                    assignedEmployeesCount: '5',
                    requiredEmployeesCount: '10',
                  ),
                ),

                const SizedBox(height: 15),
              ],
            );
          },
        ),
      ),
    );
  }
}