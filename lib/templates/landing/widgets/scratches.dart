// class EventSkeletonLoader extends StatelessWidget {
//   const EventSkeletonLoader({
//     super.key,
//     required this.baseColor,
//     required this.highlightColor,
//   });
//   final Color baseColor;
//   final Color highlightColor;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: Theme.of(context).appDimensions.highlightHeightResponsive,
//       child: Stack(
//         children: [
//           // Background Skeleton
//           Shimmer.fromColors(
//             baseColor: baseColor,
//             highlightColor: highlightColor,
//             child: Container(
//               width: double.infinity,
//               height: context.logicalHeight,
//               color: baseColor,
//             ),
//           ),
//           // Gradients
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               width: context.logicalWidth,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.bottomCenter,
//                   end: Alignment.topCenter,
//                   colors: [baseColor, Colors.transparent],
//                   stops: const [0.2, 1.0],
//                 ),
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Container(
//               width: context.logicalWidth,
//               height: context.logicalHeight,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.centerLeft,
//                   end: Alignment.centerRight,
//                   colors: [baseColor, Colors.transparent],
//                   stops: const [0.0, 0.5],
//                 ),
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.topCenter,
//             child: Container(
//               width: context.logicalWidth,
//               height: context.logicalHeight,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [baseColor, Colors.transparent],
//                   stops: const [0.0, 0.6],
//                 ),
//               ),
//             ),
//           ),
//           // Event Info Skeleton
//           Positioned(
//             top: 40,
//             left: context.isRegularSmartphoneOrLess ? 18 : 96,
//             child: Row(
//               children: [
//                 // Placeholder for Date
//                 Shimmer.fromColors(
//                   baseColor: baseColor,
//                   highlightColor: highlightColor,
//                   child: Container(
//                     width: 100,
//                     height: 16,
//                     color: baseColor,
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 // Separator Placeholder
//                 Shimmer.fromColors(
//                   baseColor: baseColor,
//                   highlightColor: highlightColor,
//                   child: Container(
//                     width: 20,
//                     height: 16,
//                     color: baseColor,
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 // Placeholder for Time
//                 Shimmer.fromColors(
//                   baseColor: baseColor,
//                   highlightColor: highlightColor,
//                   child: Container(
//                     width: 60,
//                     height: 16,
//                     color: baseColor,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             top: 60,
//             left: context.isRegularSmartphoneOrLess ? 18 : 96,
//             child: Shimmer.fromColors(
//               baseColor: baseColor,
//               highlightColor: highlightColor,
//               child: Container(
//                 width: context.logicalWidth - 100,
//                 height: 20,
//                 color: baseColor,
//               ),
//             ),
//           ),
//           Positioned(
//             top: context.isRegularSmartphoneOrLess ? 130 : -140,
//             left: context.isRegularSmartphoneOrLess ? 18 : 96,
//             child: Shimmer.fromColors(
//               baseColor: baseColor,
//               highlightColor: highlightColor,
//               child: Container(
//                 width: 150,
//                 height: 16,
//                 color: baseColor,
//               ),
//             ),
//           ),
//           Positioned(
//             top: context.isRegularSmartphoneOrLess ? 160 : 200,
//             left: context.isRegularSmartphoneOrLess ? 18 : 96,
//             child: Shimmer.fromColors(
//               baseColor: baseColor,
//               highlightColor: highlightColor,
//               child: Container(
//                 width: 120,
//                 height: 40,
//                 color: baseColor,
//               ),
//             ),
//           ),
//           // Highlighted Items Skeleton
//           Positioned(
//             bottom: context.isRegularSmartphoneOrLess ? 100 : 0,
//             right: context.isRegularSmartphoneOrLess ? 18 : 96,
//             left: context.isRegularSmartphoneOrLess ? 18 : 96,
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Shimmer.fromColors(
//                       baseColor: baseColor,
//                       highlightColor: highlightColor,
//                       child: Container(
//                         width: 120,
//                         height: 16,
//                         color: baseColor,
//                       ),
//                     ),
//                     // Timer Skeleton
//                     Shimmer.fromColors(
//                       baseColor: baseColor,
//                       highlightColor: highlightColor,
//                       child: Container(
//                         width: 24,
//                         height: 24,
//                         decoration: const BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 // Placeholder for Grid or Row Items
//                 Shimmer.fromColors(
//                   baseColor: baseColor,
//                   highlightColor: highlightColor,
//                   child: Container(
//                     height: context.isRegularSmartphoneOrLess ? 100 : 200,
//                     color: baseColor,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



// class ShimmerBordersExample extends StatelessWidget {
//   const ShimmerBordersExample({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: List.generate(
//             5,
//                 (index) => Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Shimmer.fromColors(
//                 baseColor: Colors.grey[800]!, // Darker base color
//                 highlightColor: Colors.grey[600]!, // Slightly lighter highlight color
//                 child: Container(
//                   width: 200,
//                   height: 50,
//                   decoration: BoxDecoration(
//                     color: Colors.transparent,
//                     border: Border.all(
//                       color: Colors.grey[800]!,
//                       width: 2,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }