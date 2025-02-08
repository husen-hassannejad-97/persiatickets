enum HeaderNavigationStep {
  step1(title: 'Select Date & Time'),
  step2(title: 'Select Seats'),
  step3(title: 'User Info & Invoice'),
  step4(title: 'Payment'),
  step5(title: 'Tickets');

  final String title;
  const HeaderNavigationStep({required this.title});
}
