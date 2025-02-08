enum SortFilter {
  lowestPrice(title: 'Lowest price'),
  highestPrice(title: 'Highest price'),
  highestSealScore(title: 'Highest deal score'),
  lowestSealScore(title: 'Lowest deal score');

  final String title;
  const SortFilter({required this.title});
}
