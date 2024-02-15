part of '../pages.dart';

class DashboardWidget extends StatelessWidget {
  final String title, description;
  final IconData icons;
  final Function onTap;

  const DashboardWidget(
      {super.key,
      required this.description,
      required this.icons,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: ListView(children: [
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: SizedBox(
                height: 100,
                width: 100,
                child: Icon(
                  icons,
                  color: secondaryColor,
                  size: 50,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: BlackText.copyWith(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  description,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: GreyText.copyWith(
                      fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ])),
    );
  }
}
