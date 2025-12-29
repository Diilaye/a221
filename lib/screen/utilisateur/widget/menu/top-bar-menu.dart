import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/responsive-ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'dart:js' as js;

class TopBarMenu extends StatelessWidget {
  const TopBarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    Size size = MediaQuery.of(context).size;
    final isMobile = deviceName(size) == ScreenType.Mobile;

    return Center(
      child: Container(
        height: 60,
        width: isMobile ? size.width : 1024,
        decoration: BoxDecoration(
          color: blanc,
          borderRadius: BorderRadius.circular(2),
          boxShadow: [
            BoxShadow(
              color: noir.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: isMobile ? _buildMobileMenu(context, homeUtilisateurBloc) : _buildDesktopMenu(context, homeUtilisateurBloc, size),
      ),
    );
  }

  Widget _buildMobileMenu(BuildContext context, HomeUtilisateurBloc bloc) {
    return Row(
      children: [
        const SizedBox(width: 16),
        _buildMenuButton(bloc),
        const SizedBox(width: 12),
        _buildLogo(context, compact: true),
        const Spacer(),
        _buildLoginIcon(context),
        const SizedBox(width: 12),
        Container(height: 20, width: 0.5, color: noir.withOpacity(0.3)),
        const SizedBox(width: 12),
        _buildSubscribeButton(),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildDesktopMenu(BuildContext context, HomeUtilisateurBloc bloc, Size size) {
    return Row(
      children: [
        const SizedBox(width: 16),
        Flexible(child: _buildLogo(context)),
        const SizedBox(width: 16),
        Container(width: 1, height: 20, color: noir.withOpacity(0.3)),
        const SizedBox(width: 16),
        Flexible(child: _buildCorrespondentButton(bloc)),
        const Spacer(),
        _buildLiveButton(bloc),
        const SizedBox(width: 12),
        _buildCreateAccountButton(context),
        const SizedBox(width: 12),
        _buildUserIcon(bloc),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildMenuButton(HomeUtilisateurBloc bloc) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => bloc.setShowMenuMobile(),
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.shade100,
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Icon(
            bloc.showMenuMobile == 0 ? Icons.menu : Icons.close,
            color: noir,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context, {bool compact = false}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          js.context.callMethod('open', ['https://a221.net/', '_self']);
        },
        child: SizedBox(
          width: compact ? 120 : 200,
          child: Image.asset(
            "assets/images/logo_a221.png",
            color: rouge,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _buildCorrespondentButton(HomeUtilisateurBloc bloc) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => bloc.setHover(2),
      onExit: (_) => bloc.setHover(0),
      child: GestureDetector(
        onTap: () => bloc.setShowMenu(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: bloc.hover == 2 ? noir.withOpacity(0.05) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "DEVENIR CORRESPONDANT ?",
            style: TextStyle(
              fontSize: 11,
              color: noir,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLiveButton(HomeUtilisateurBloc bloc) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => bloc.setHover(3),
      onExit: (_) => bloc.setHover(0),
      child: GestureDetector(
        onTap: () => bloc.setShowLiveYoutube(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: bloc.hover == 3 ? rouge.withOpacity(0.05) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                "assets/images/live_actu.svg",
                height: 10,
                width: 10,
              ),
              const SizedBox(width: 6),
              Text(
                "EN DIRECT",
                style: TextStyle(
                  fontSize: 11,
                  color: noir,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(width: 6),
              Icon(
                CupertinoIcons.chevron_down,
                size: 10,
                color: noir,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreateAccountButton(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.go("/login"),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: rouge,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: rouge.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            "Créer mon compte",
            style: TextStyle(
              fontSize: 11,
              color: blanc,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserIcon(HomeUtilisateurBloc bloc) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => bloc.setHover(4),
      onExit: (_) => bloc.setHover(0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: bloc.hover == 4 ? noir.withOpacity(0.05) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          CupertinoIcons.person_circle,
          size: 28,
          color: noir,
        ),
      ),
    );
  }

  Widget _buildLoginIcon(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.go('/login'),
        child: Icon(
          CupertinoIcons.person_circle,
          size: 24,
          color: noir,
        ),
      ),
    );
  }

  Widget _buildSubscribeButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: jaune,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        "S'abonner",
        style: TextStyle(
          fontSize: 10,
          color: noir.withOpacity(0.8),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
