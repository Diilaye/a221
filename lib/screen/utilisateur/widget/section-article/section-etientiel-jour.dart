import 'package:actu/models/administrateur/post-digiteaux-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:flutter/material.dart';

class SectionEtientielJourWidget extends StatefulWidget {
  final List<PostsDigiteauxModel> posts;
  const SectionEtientielJourWidget({super.key, required this.posts});

  @override
  State<SectionEtientielJourWidget> createState() => _SectionEtientielJourWidgetState();
}

class _SectionEtientielJourWidgetState extends State<SectionEtientielJourWidget> {
  final ScrollController _scrollController = ScrollController();
  int _hoveredIndex = -1;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 1024,
        margin: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: bleuMarine,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: rouge.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      "L'essentiel".toUpperCase(),
                      style: fontFammilyDii(
                        context, 28, blanc, FontWeight.bold, FontStyle.normal),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 300,
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  scrollbars: false,
                ),
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.posts.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) => MouseRegion(
                    onEnter: (_) => setState(() => _hoveredIndex = index),
                    onExit: (_) => setState(() => _hoveredIndex = -1),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: 220,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: rouge.withOpacity(_hoveredIndex == index ? 0.4 : 0.2),
                                  blurRadius: _hoveredIndex == index ? 20 : 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                BASE_URL_ASSET + widget.posts[index].image!.url!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          if (widget.posts[index].titre != null) ...[
                            const SizedBox(height: 12),
                            SizedBox(
                              width: 280,
                              child: Text(
                                widget.posts[index].titre!,
                                style: fontFammilyDii(
                                  context, 16, blanc,
                                  FontWeight.w500, FontStyle.normal
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
     