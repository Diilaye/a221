import 'package:actu/bloc/administrateur/emission-bloc.dart';
import 'package:actu/bloc/administrateur/menu-admin.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/tv/add-emission.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/tv/update-emission.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/diallog-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvScreen extends StatefulWidget {
  const TvScreen({super.key});

  @override
  State<TvScreen> createState() => _TvScreenState();
}

class _TvScreenState extends State<TvScreen> {
  String searchQuery = '';
  int itemsPerPage = 10;
  String statusFilter = 'Tous les status';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final menuAdminBloc = Provider.of<MenuAdminBloc>(context);
    final emissionBloc = Provider.of<EmissionBloc>(context);

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.grey.shade50,
                Colors.white,
                Colors.grey.shade50,
              ],
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              // Hero Header Section
              _buildHeroHeader(context, emissionBloc, menuAdminBloc),
              const SizedBox(height: 32),
              
              // Filters and Search Bar
              _buildFiltersSection(context, size, menuAdminBloc),
              const SizedBox(height: 32),
              
              // Grid of Emissions
              _buildEmissionsGrid(context, size, emissionBloc),
              const SizedBox(height: 32),
              
              // Pagination
              _buildPagination(context, emissionBloc),
              const SizedBox(height: 32),
            ],
          ),
        ),
        if (menuAdminBloc.addEmission == 1)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: size.width * .8,
              height: size.height,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(-5, 0),
                  ),
                ],
              ),
              child: const AddEmissionScreen(),
            ),
          ),
        if (emissionBloc.showUpdate == 1)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: size.width * .8,
              height: size.height,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(-5, 0),
                  ),
                ],
              ),
              child: const UpdateEmissionScreen(),
            ),
          ),
      ],
    );
  }

  Widget _buildHeroHeader(BuildContext context, EmissionBloc emissionBloc, MenuAdminBloc menuAdminBloc) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            rouge.withOpacity(0.9),
            const Color(0xFFE31E24),
            rouge.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: rouge.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Breadcrumb
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(CupertinoIcons.home, color: blanc, size: 14),
                    const SizedBox(width: 6),
                    Icon(CupertinoIcons.chevron_forward, color: blanc.withOpacity(0.7), size: 10),
                    const SizedBox(width: 6),
                    Text('Émission', style: TextStyle(color: blanc, fontSize: 12, fontWeight: FontWeight.w500)),
                    const SizedBox(width: 6),
                    Icon(CupertinoIcons.chevron_forward, color: blanc.withOpacity(0.7), size: 10),
                    const SizedBox(width: 6),
                    Text('Dashboard', style: TextStyle(color: blanc.withOpacity(0.9), fontSize: 12)),
                  ],
                ),
              ),
              const Spacer(),
              _buildHeaderAction(CupertinoIcons.printer, 'Imprimer'),
              const SizedBox(width: 12),
              _buildHeaderAction(CupertinoIcons.folder, 'Archives'),
            ],
          ),
          const SizedBox(height: 24),
          
          // Title and Stats
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(CupertinoIcons.tv, color: blanc, size: 32),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'GESTION DES ÉMISSIONS',
                              style: TextStyle(
                                color: blanc,
                                fontSize: 32,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Gérez toutes vos émissions TV en un seul endroit',
                              style: TextStyle(
                                color: blanc.withOpacity(0.9),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // Stats Row
                    Row(
                      children: [
                        _buildStatCard(
                          icon: CupertinoIcons.tv,
                          label: 'Total',
                          value: '${emissionBloc.emissions.length}',
                        ),
                        const SizedBox(width: 16),
                        _buildStatCard(
                          icon: CupertinoIcons.checkmark_circle_fill,
                          label: 'En ligne',
                          value: '${emissionBloc.emissions.where((e) => e.statusOnline == "on").length}',
                          color: vert,
                        ),
                        const SizedBox(width: 16),
                        _buildStatCard(
                          icon: CupertinoIcons.doc_text,
                          label: 'Brouillons',
                          value: '${emissionBloc.emissions.where((e) => e.statusOnline != "on").length}',
                          color: Colors.orange,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Add Button
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => menuAdminBloc.setEmission(1),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      color: blanc,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(CupertinoIcons.add_circled_solid, color: rouge, size: 24),
                        const SizedBox(width: 12),
                        Text(
                          'NOUVELLE ÉMISSION',
                          style: TextStyle(
                            color: rouge,
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderAction(IconData icon, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: blanc, size: 20),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    Color? color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, color: color ?? blanc, size: 20),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: blanc,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  color: blanc.withOpacity(0.8),
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersSection(BuildContext context, Size size, MenuAdminBloc menuAdminBloc) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Show dropdown
          Text(
            'Afficher',
            style: TextStyle(
              color: noir.withOpacity(0.7),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: DropdownButton<int>(
              value: itemsPerPage,
              items: [10, 15, 20, 25, 50].map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text('$e', style: TextStyle(fontWeight: FontWeight.w600)),
                );
              }).toList(),
              underline: const SizedBox(),
              onChanged: (v) {
                setState(() {
                  itemsPerPage = v!;
                });
              },
            ),
          ),
          const SizedBox(width: 24),
          
          // Status filter
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: DropdownButton<String>(
              value: statusFilter,
              items: ['Tous les status', 'En ligne', 'Brouillons'].map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e, style: TextStyle(fontWeight: FontWeight.w600)),
                );
              }).toList(),
              underline: const SizedBox(),
              onChanged: (v) {
                setState(() {
                  statusFilter = v!;
                });
              },
            ),
          ),
          const Spacer(),
          
          // Search
          Container(
            width: size.width * 0.25,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Rechercher une émission...',
                hintStyle: TextStyle(
                  color: noir.withOpacity(0.4),
                  fontSize: 14,
                ),
                prefixIcon: Icon(CupertinoIcons.search, color: noir.withOpacity(0.5)),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmissionsGrid(BuildContext context, Size size, EmissionBloc emissionBloc) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.75,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
      ),
      itemCount: emissionBloc.emissions.length,
      itemBuilder: (context, index) {
        final emission = emissionBloc.emissions[index];
        return _buildEmissionCard(context, emission, emissionBloc);
      },
    );
  }

  Widget _buildEmissionCard(BuildContext context, dynamic emission, EmissionBloc emissionBloc) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with Badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: Image.network(
                    BASE_URL_ASSET + emission.photoCouverture!.url!,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                
                // Type Badge
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: emission.type == "invite" ? vert : rouge,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          emission.type == "invite" 
                            ? CupertinoIcons.person_2_fill 
                            : CupertinoIcons.play_circle_fill,
                          color: blanc,
                          size: 12,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          emission.type == "invite" ? 'Invité' : 'À suivre',
                          style: TextStyle(
                            color: blanc,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Status Badge
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: emission.statusOnline == "on" 
                        ? vert.withOpacity(0.9)
                        : Colors.orange.withOpacity(0.9),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      emission.statusOnline == "on"
                        ? CupertinoIcons.checkmark
                        : CupertinoIcons.doc_text,
                      color: blanc,
                      size: 14,
                    ),
                  ),
                ),
              ],
            ),
            
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      emission.titre!.toUpperCase(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: noir,
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    // Date
                    Row(
                      children: [
                        Icon(CupertinoIcons.calendar, color: noir.withOpacity(0.5), size: 14),
                        const SizedBox(width: 6),
                        Text(
                          emission.date!.split("T")[0].split("-").reversed.join('/'),
                          style: TextStyle(
                            color: noir.withOpacity(0.6),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    
                    // Actions
                    Row(
                      children: [
                        // Edit Button
                        Expanded(
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                emissionBloc.setEmission(emission);
                                emissionBloc.setShowUpdate(1);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  CupertinoIcons.pencil,
                                  color: Colors.blue,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        
                        // Delete/Publish Button
                        Expanded(
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () async {
                                final confirm = await dialogRequest(
                                  title: emission.statusOnline == "on"
                                    ? 'Supprimer cette émission ?'
                                    : 'Publier cette émission ?',
                                  context: context,
                                );
                                if (confirm) {
                                  emissionBloc.setEmission(emission);
                                  emissionBloc.activeEmission();
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: emission.statusOnline == "on"
                                    ? Colors.red.shade50
                                    : Colors.green.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  emission.statusOnline == "on"
                                    ? CupertinoIcons.delete
                                    : CupertinoIcons.arrow_up_circle,
                                  color: emission.statusOnline == "on"
                                    ? Colors.red
                                    : Colors.green,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPagination(BuildContext context, EmissionBloc emissionBloc) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            "Affichage de 1 à ${itemsPerPage} sur ${emissionBloc.emissions.length} émissions",
            style: TextStyle(
              color: noir.withOpacity(0.7),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          
          // Previous Button
          _buildPaginationButton(
            icon: CupertinoIcons.chevron_left,
            onTap: () {},
          ),
          const SizedBox(width: 12),
          
          // Page Numbers
          ...List.generate(5, (index) {
            final isActive = index == 0;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isActive ? rouge : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isActive ? rouge : Colors.grey.shade300,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: isActive ? blanc : noir,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
          const SizedBox(width: 12),
          
          // Next Button
          _buildPaginationButton(
            icon: CupertinoIcons.chevron_right,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildPaginationButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Icon(icon, color: noir, size: 18),
        ),
      ),
    );
  }
}
