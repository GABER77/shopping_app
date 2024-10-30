class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

List<BoardingModel> boardingList = [
  BoardingModel(
    image: 'assets/images/OnBoarding1.jpg',
    title: 'Discover',
    body: 'Explore top brands, unbeatable deals, and personalized recommendations. Your perfect shopping experience starts here!' ,
  ),
  BoardingModel(
    image: 'assets/images/OnBoarding2.jpg',
    title: 'Secure & Fast Checkout',
    body: 'Save your payment details for a fast, hassle-free, and secure shopping experience every time.' ,
  ),
  BoardingModel(
    image: 'assets/images/OnBoarding3.jpg',
    title: 'Enjoy',
    body: 'Experience fast and reliable delivery, with options to choose express shipping for urgent purchases.' ,
  ),
];