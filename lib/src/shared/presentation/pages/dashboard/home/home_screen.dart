part of '../../../pages.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final List<DashboardWidgetData> dashboardWidgetDataList = [
    DashboardWidgetData(
        Icons.pie_chart, "Chart Profit", "Liat hasil profit anda di sini", () {
      Navigation.navigateToPage(Approute.CHART_ROUTE);
    }),
    DashboardWidgetData(Icons.table_rows, "Produk Table",
        "Liat Produk Tabel produk anda di sini", () {
      Navigation.navigateToPage(Approute.PRODUK_TABLE);
    }),
    DashboardWidgetData(Icons.abc, "Graph 3", "Description 3", () {
      print("Navigate to Graph 3 page");
    }),
    DashboardWidgetData(Icons.abc, "Graph 4", "Description 4", () {
      print("Navigate to Graph 4 page");
    }),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: 50.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: _buildTopBar(),
              titlePadding: EdgeInsets.only(left: 0),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: edge, vertical: edge),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [SizedBox(height: 10), _buildCourseGrid()],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return ListTile(
      leading: CircleAvatar(
        maxRadius: 30,
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage("assets/images/Memoji.png"),
      ),
      title: Text(
        'Home',
        style: BlackText.copyWith(fontSize: 20),
      ),
      subtitle: Row(
        children: [
          Text(
            'Class ',
            style: BlackText,
          ),
          SizedBox(width: 10),
          Text(
            '8',
            style: BlackText,
          ),
        ],
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.notification_add,
          color: Colors.yellow,
        ),
      ),
    );
  }

  Widget _buildCourseGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: dashboardWidgetDataList.length,
      itemBuilder: (context, index) {
        return DashboardWidget(
          icons: dashboardWidgetDataList[index].icon,
          title: dashboardWidgetDataList[index].title,
          description: dashboardWidgetDataList[index].description,
          onTap: () {
            dashboardWidgetDataList[index].onTap();
          },
        );
      },
    );
  }
}

class DashboardWidgetData {
  final IconData icon;
  final String title;
  final String description;
  final Function() onTap;

  DashboardWidgetData(this.icon, this.title, this.description, this.onTap);
}
