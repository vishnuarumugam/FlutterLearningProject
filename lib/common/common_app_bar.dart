import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final VoidCallback onLeadingTap;
  final VoidCallback onActionTap;
  final bool showLeading;
  final bool showAction;

  const CommonAppBar({super.key, 
    required this.title,
    required this.onLeadingTap,
    required this.onActionTap,
    required this.showLeading,
    required this.showAction
  });

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      title: Text(title,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold)
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: showLeading ? GestureDetector(
            onTap: onLeadingTap,
            child: Container(
              margin: const EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xffF7F8F8),
                borderRadius: BorderRadius.circular(10)
              ),
              child: SvgPicture.asset('assets/icons/left_arrow.svg',
              height: 20,
              width: 20),
            ),
          ) : null,
        actions: showAction ? [
          GestureDetector(
            onTap: onActionTap,
            child: Container(
              margin: const EdgeInsets.all(10),
              alignment: Alignment.center,
              width: 37,
              decoration: BoxDecoration(
                color: const Color(0xffF7F8F8),
                borderRadius: BorderRadius.circular(10)
              ),
              child: SvgPicture.asset('assets/icons/more.svg',
              height: 20,
              width: 20),
            ),
          )
        ] : null,
    );
    }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  
}