import 'package:flutter/material.dart';

class MenuItemButton extends StatelessWidget {
  final String imagePath;
  final String label;

  const MenuItemButton({
    super.key,
    required this.imagePath,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // ---------- ICON TILE ----------
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: const Color(0xFFFEBA2B),
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                color: Color(0x40000000),
                offset: Offset(0, 4),
                blurRadius: 4,
              ),
            ],
          ),
          child: Center(
            child: Image.asset(
              imagePath,
              width: 42,
              height: 42,
              fit: BoxFit.contain,
            ),
          ),
        ),

        const SizedBox(height: 8),

        // ---------- LABEL ----------
        Flexible( // menjaga tinggi grid tetap stabil
          child: FittedBox( // otomatis mengecilkan font kalau masih kepanjangan
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              textAlign : TextAlign.center,
              softWrap  : true,
              maxLines  : 2,                 // cukup 2 baris
              overflow  : TextOverflow.clip, // biar FittedBox yang urus skala
              style     : theme.textTheme.labelMedium?.copyWith(
                fontSize  : 12,
                color     : Colors.black87,
                height    : 1.2,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}


// import 'package:flutter/material.dart';
//
// class MenuItemButton extends StatelessWidget {
//   final String imagePath;
//   final String label;
//
//   const MenuItemButton({
//     Key? key,
//     required this.imagePath,
//     required this.label,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // Jika label mengandung newline, maka tampilkan 2 baris; jika tidak, 1 baris.
//     final bool hasNewLine = label.contains('\n');
//
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           width: 80,
//           height: 80,
//           decoration: BoxDecoration(
//             color: const Color(0xFFFEBA2B),
//             borderRadius: BorderRadius.circular(18),
//             boxShadow: const [
//               BoxShadow(
//                 color: Color(0x40000000),
//                 offset: Offset(0, 4),
//                 blurRadius: 4,
//                 spreadRadius: 0,
//               ),
//             ],
//           ),
//           child: Center(
//             child: Image.asset(
//               imagePath,
//               width: 42,
//               height: 42,
//               fit: BoxFit.contain,
//             ),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           label,
//           style: const TextStyle(fontSize: 12, color: Colors.black87),
//           textAlign: TextAlign.center,
//           maxLines: hasNewLine ? 2 : 1, // Menyesuaikan jumlah baris
//           overflow: TextOverflow.ellipsis, // Menghindari overflow dengan elipsis
//         ),
//       ],
//     );
//   }
// }
