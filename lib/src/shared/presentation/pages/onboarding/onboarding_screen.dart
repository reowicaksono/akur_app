part of '../../pages.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final AppPreferences _preferences = AppPreferences();
  final PageController _pageController = PageController();
  final List<Widget> pages = [
    const OnboardingPage(
      title: 'Welcome to MyApp',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      imageUrl: 'assets/lottie/book.json',
    ),
    const OnboardingPage(
      title: 'Explore Features',
      description: 'Discover amazing features that make MyApp unique.',
      imageUrl: 'assets/lottie/quiz.json',
    ),
    const OnboardingPage(
      title: 'Get Started',
      description: 'Sign up now and start using MyApp today!',
      imageUrl: 'assets/lottie/welcome.json',
    ),
  ];

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: pages.length,
              itemBuilder: (context, index) {
                return pages[index];
              },
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
            ),
          ),
          const SizedBox(height: 16.0),
          if (currentPage < pages.length - 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentPage > 0)
                  ElevatedButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    child: const Text('Back'),
                  ),
                ElevatedButton(
                  onPressed: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  },
                  child: const Text('Next'),
                ),
              ],
            ),
          if (currentPage == pages.length - 1)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _preferences.setOnBoardingState(true);
                });
                Navigation.navigateToPageReplacement(Approute.DASHBOARD);
              },
              child: const Text('Mulai'),
            ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            imageUrl,
            height: 200,
          ),
          const SizedBox(height: 16.0),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
