import 'package:actu/bloc/utilisateur/emission-user-bloc.dart';
import 'package:actu/bloc/utilisateur/flash-news-bloc.dart';
import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/bloc/utilisateur/papier-journal-bloc.dart';
import 'package:actu/bloc/utilisateur/posts-digiteaux.dart';
import 'package:actu/bloc/live-feed-bloc.dart';
import 'package:actu/screen/utilisateur/pages/mobiles/home-mobile-screen.dart';
import 'package:actu/screen/utilisateur/widget/emissions/article-top-bar.dart';
import 'package:actu/screen/utilisateur/widget/emissions/emission-top-bar.dart';
import 'package:actu/screen/utilisateur/widget/flash-info/flash-news-widget.dart';
import 'package:actu/screen/utilisateur/widget/live-feed/live-ticker-widget.dart';
import 'package:actu/screen/utilisateur/widget/footer/section-footer.dart';
import 'package:actu/screen/utilisateur/widget/menu/exit-menu-rubrique.dart';
import 'package:actu/screen/utilisateur/widget/menu/menu-bar.dart';
import 'package:actu/screen/utilisateur/widget/menu/menu-rubrique.dart';
import 'package:actu/screen/utilisateur/widget/menu/top-bar-menu.dart';
import 'package:actu/screen/utilisateur/widget/section-article/section-choix-redec.dart';
import 'package:actu/screen/utilisateur/widget/section-article/section-contribution-widget.dart';
import 'package:actu/screen/utilisateur/widget/section-article/section-economique-widget.dart';
import 'package:actu/screen/utilisateur/widget/section-article/section-etientiel-jour.dart';
import 'package:actu/screen/utilisateur/widget/section-article/section-investigation-widget.dart';
import 'package:actu/screen/utilisateur/widget/section-article/section-politique-widget.dart';
import 'package:actu/screen/utilisateur/widget/section-article/section-category-card.dart';
import 'package:actu/screen/utilisateur/widget/section-article/section-une-widget.dart';
import 'package:actu/screen/utilisateur/widget/videos/video-card-animated.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/responsive-ui.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:actu/utils/yWebUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeUtilisateurScreen extends StatelessWidget {
  const HomeUtilisateurScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    final flashNewsUserBloc = Provider.of<FlashNewsUserBloc>(context);
    final postsDigiteauxUserBloc = Provider.of<PostsDigiteauxUserBloc>(context);
    final papierJournalUserBloc = Provider.of<PapierJournalUserBloc>(context);
    final emissionUserBloc = Provider.of<EmissionUserBloc>(context);

    return deviceName(size) == ScreenType.Mobile
        ? const HomeMobileScreen()
        : Scaffold(
                backgroundColor: gris,
                appBar: AppBar(
                  elevation: .0,
                  toolbarHeight: .0,
                ),
                body: Stack(
                  children: [
                    Container(
                      color: blanc,
                    ),
                    Center(
                      child: Container(
                        height: size.height,
                        width: 1024,
                        color: blanc,
                        child: ListView(
                          controller: homeUtilisateurBloc.controllerListHome,
                          children: [
                            homeUtilisateurBloc.showMenu == 0
                                ? paddingVerticalGlobal(220)
                                : paddingVerticalGlobal(220),
                            Center(
                              child: Container(
                                width: 1024,
                                child: const LiveTickerWidget(height: 50),
                              ),
                            ),
                            paddingVerticalGlobal(4),
                            SectionUneWidget(),
                            paddingVerticalGlobal(8),
                            // Affichage forcé de la section - toujours visible pour debug
                            Container(
                              key: const ValueKey('actualite_edition_section'),
                              child: _buildActualiteEditionSection(context, size, homeUtilisateurBloc, papierJournalUserBloc),
                            ),
                            paddingVerticalGlobal(32),
                            const SectionPolitiqueWidget(),
                            paddingVerticalGlobal(32),
                            const SectionContributionWidget(),
                            paddingVerticalGlobal(32),
                            const SectionInvestigationtWidget(),
                            paddingVerticalGlobal(32),
                            const SectionEconomiqueWidget(),
                            paddingVerticalGlobal(32),
                            postsDigiteauxUserBloc.listePosts.isEmpty
                                ? SizedBox()
                                : SectionEtientielJourWidget(
                                    posts: postsDigiteauxUserBloc.listePosts
                                        .where((e) => e.type == "essentiel" && e.statusOnline =="on")
                                        .toList()
                                        .reversed
                                        .toList(),
                                  ),
                            paddingVerticalGlobal(32),
                            const SectionChoixRedacWidget(),
                            paddingVerticalGlobal(32),
                           if(homeUtilisateurBloc.videos.isNotEmpty) Container(
                              height: 420,
                              width: 1024,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    bleuMarine,
                                    bleuMarine.withOpacity(0.95),
                                    Color(0xFF0A1929),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: noir.withOpacity(0.3),
                                    blurRadius: 15,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  paddingVerticalGlobal(12),
                                  Row(
                                    children: [
                                      paddingHorizontalGlobal(),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: rouge.withOpacity(0.15),
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: rouge.withOpacity(0.5), width: 1),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(CupertinoIcons.play_circle_fill, color: rouge, size: 18,),
                                            SizedBox(width: 8),
                                            Text('VIDÉOS',style: fontFammilyDii(
                                              context,
                                              22,
                                              blanc,
                                              FontWeight.w900,
                                              FontStyle.normal,
                                            ), ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: Container(
                                          height: 32,
                                          width: 32,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(32),
                                            border: Border.all(color: blanc.withOpacity(0.3), width: 1.5),
                                            gradient: LinearGradient(
                                              colors: [blanc.withOpacity(0.1), blanc.withOpacity(0.05)],
                                            ),
                                          ),
                                          child: Center(
                                            child: Icon(CupertinoIcons.arrow_left, color: blanc, size: 16,),
                                          ),
                                        ),
                                      ),
                                      paddingHorizontalGlobal(8),
                                      MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: Container(
                                          height: 32,
                                          width: 32,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(32),
                                            border: Border.all(color: blanc.withOpacity(0.3), width: 1.5),
                                            gradient: LinearGradient(
                                              colors: [blanc.withOpacity(0.1), blanc.withOpacity(0.05)],
                                            ),
                                          ),
                                          child: Center(
                                            child: Icon(CupertinoIcons.arrow_right, color: blanc, size: 16,),
                                          ),
                                        ),
                                      ),
                                      paddingHorizontalGlobal(),
                                    ],
                                  ),
                                  paddingVerticalGlobal(12),
                                  Container(
                                    height: 330,
                                    width: 1024,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: homeUtilisateurBloc.videos.where((e) => e.statusOnline == "on" && e.isLive =="off" ).map((el) => Row(
                                        children: [
                                          paddingHorizontalGlobal(8),
                                          VideoCardAnimated(video: el),
                                        ],
                                      )).toList(),
                                    ),
                                  ),
                                  paddingVerticalGlobal(4),

                                ],
                              ),
                            ),
                            paddingVerticalGlobal(32),
                            Container(
                              height: 650,
                              width: 1024,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    if(homeUtilisateurBloc.articleSport.isNotEmpty) ...[  
                                      SectionCategoryCard(
                                        articles: homeUtilisateurBloc.articleSport,
                                        title: 'Sport',
                                        icon: CupertinoIcons.sportscourt,
                                        primaryColor: Color(0xFFE31E24),
                                      ),
                                      paddingHorizontalGlobal(),
                                    ],
                                    if(homeUtilisateurBloc.articleCultures.isNotEmpty) ...[
                                      SectionCategoryCard(
                                        articles: homeUtilisateurBloc.articleCultures,
                                        title: 'Culture & Art',
                                        icon: CupertinoIcons.paintbrush,
                                        primaryColor: Color(0xFF9C27B0),
                                      ),
                                      paddingHorizontalGlobal(),
                                    ],
                                    if(homeUtilisateurBloc.articleAfriques.isNotEmpty) ...[
                                      SectionCategoryCard(
                                        articles: homeUtilisateurBloc.articleAfriques,
                                        title: 'Afrique',
                                        icon: CupertinoIcons.globe,
                                        primaryColor: Color(0xFF00BCD4),
                                      ),
                                      paddingHorizontalGlobal(),
                                    ],
                                    if(homeUtilisateurBloc.articleInternationals.isNotEmpty)
                                      SectionCategoryCard(
                                        articles: homeUtilisateurBloc.articleInternationals,
                                        title: 'International',
                                        icon: CupertinoIcons.airplane,
                                        primaryColor: Color(0xFF2196F3),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            const SectionFooter(),
                            paddingVerticalGlobal(46)
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        top: 0,
                        child: Container(
                          height: 215,
                          width: size.width,
                          color: rouge,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 5,
                                color: blanc,
                              )
                            ],
                          ),
                        )),
                    Positioned(
                        top: 84,
                        left: (size.width - 1024) / 2,
                        right: (size.width - 1024) / 2,
                        child: SizedBox(
                          height: 75,
                          width: 1024,
                          child: Row(
                            children: [

                              Expanded(
                                  child: Container(
                                height: 120,
                                color: blanc,
                                child: Row(
                                  children: [
                                    emissionUserBloc.emissions.length == 0
                                        ? SizedBox()
                                        : EmissionTopBarWidget(
                                            emissionModel: emissionUserBloc
                                                .suivreEmission!,
                                          ),
                                    Container(
                                      width: 2,
                                      color: rouge,
                                    ),
                                    paddingHorizontalGlobal(8),
                                    homeUtilisateurBloc.topArticle == null
                                        ? SizedBox()
                                        : ArticleTopBarWidget(
                                            articlesModel: homeUtilisateurBloc
                                                .topArticle!),
                                    Container(
                                      width: 2,
                                      color: rouge,
                                    ),
                                    paddingHorizontalGlobal(8),
                                    emissionUserBloc.emissions.length == 0
                                        ? SizedBox()
                                        : EmissionTopBarWidget(
                                            emissionModel: emissionUserBloc
                                                .inviteEmission!,
                                          ),
                                  ],
                                ),
                              )),

                            ],
                          ),
                        )),
                   Positioned(
                        top: 20,
                       left: (size.width - 1024) / 2,
                       right: (size.width - 1024) / 2,
                        child: const TopBarMenu()),


                    MenuBarArticle(
                      categories: homeUtilisateurBloc.categories
                          .where((e) => e.showMenu == "1")
                          .toList(),
                    ),


                    if (homeUtilisateurBloc.hoverMenuClick != 0)
                      MenuRubrique(
                        number: homeUtilisateurBloc.hoverMenuClick,
                      ),
                    if (homeUtilisateurBloc.hoverMenuClick != 0)
                      const ExitMenuRubrique(),
                    
                    // Bandeau EN DIRECT en bas de l'écran
                    if (!homeUtilisateurBloc.showFlashInfo)
                      Positioned(
                        bottom: 0,
                        left: (size.width - 1024) / 2,
                        right: (size.width - 1024) / 2,
                        child: const SizedBox(
                          height: 50,
                          width: 1024,
                          child: LiveTickerWidget(height: 50),
                        ),
                      ),

                    if(homeUtilisateurBloc.showLiveYoutube) Positioned(
                      top: 70,
                      left: (size.width - 1024) / 2,
                      right: (size.width - 1024) / 2,
                      child: Container(
                        color: noir,
                          width: 1024,
                          child: Center(

                              child: SizedBox(
                                  width: 1024,
                                  child: YoutubeHtmlWidget(urlY: homeUtilisateurBloc.videos.where((e) => e.isLive == "on").first.url!)))),)
                  ],
                ),
              );
  }

  Widget _buildActualiteEditionSection(
    BuildContext context,
    Size size,
    HomeUtilisateurBloc homeUtilisateurBloc,
    PapierJournalUserBloc papierJournalUserBloc,
  ) {
    bool hasActualites = homeUtilisateurBloc.articleActualites.isNotEmpty;
    bool hasEdition = papierJournalUserBloc.papierJournals.isNotEmpty;
    
    // Version épurée selon l'image - sans bordures ni conteneurs colorés
    return Container(
      width: 1024,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Actualités (côté gauche) - Format de l'image
          if (hasActualites) 
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header simple avec "ACTUALITÉS" et "VOIR +"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ACTUALITÉS',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // Navigation vers la page des actualités
                          context.push('/actualites');
                        },
                        child: Text(
                          'VOIR +',
                          style: TextStyle(
                            color: rouge,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // Liste des articles sans bordure, format épuré
                  Column(
                    children: homeUtilisateurBloc.articleActualites
                        .take(4) // Limite à 4 articles comme dans l'image
                        .map((article) => Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: InkWell(
                            onTap: () => context.push('/article/${article.slug}'),
                            borderRadius: BorderRadius.circular(4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Image de l'article (plus grande)
                                if (article.imageArticle?.url != null)
                                  Container(
                                    width: 120,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      image: DecorationImage(
                                        image: NetworkImage(BASE_URL_ASSET + article.imageArticle!.url!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                const SizedBox(width: 16),
                                
                                // Contenu de l'article
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Tag/Catégorie en rouge
                                      if (article.tags?.titre != null)
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          margin: const EdgeInsets.only(bottom: 8),
                                          decoration: BoxDecoration(
                                            color: rouge,
                                            borderRadius: BorderRadius.circular(2),
                                          ),
                                          child: Text(
                                            article.tags!.titre!.toUpperCase(),
                                            style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              letterSpacing: 0.8,
                                            ),
                                          ),
                                        ),
                                      
                                      // Titre de l'article
                                      Text(
                                        article.titre ?? 'Article sans titre',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                          height: 1.3,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))
                        .toList(),
                  ),
                ],
              ),
            ),
          
          // Espace entre les sections
          if (hasActualites && hasEdition) const SizedBox(width: 40),
          
          // Section Partenariat (côté droit) - Format de l'image
          if (hasEdition)
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Header simple "PARTENARIAT"
                  Text(
                    'PARTENARIAT',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Image de l'édition papier - format équilibré avec les actualités
                  Container(
                    width: double.infinity,
                    height: 480, // Hauteur augmentée pour une image plus grande
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white,
                    ),
                    child: papierJournalUserBloc.papierJournals.last.image?.url != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.network(
                              BASE_URL_ASSET + papierJournalUserBloc.papierJournals.last.image!.url!,
                              fit: BoxFit.contain, // Cover pour remplir l'espace disponible
                              width: double.infinity,
                              height: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          CupertinoIcons.doc_text,
                                          size: 64,
                                          color: Colors.grey.shade400,
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          'Image non disponible',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.doc_text,
                                    size: 64,
                                    color: Colors.grey.shade400,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Partenariat disponible',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          
          // Si aucun contenu n'est disponible - Version minimaliste
          if (!hasActualites && !hasEdition)
            Expanded(
              child: Container(
                height: 200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.news_solid,
                        size: 48,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'ACTUALITÉS & PARTENARIAT',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Contenu en cours de chargement...',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
