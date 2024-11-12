import 'package:actu/bloc/utilisateur/papier-journal-bloc.dart';
import 'package:actu/screen/utilisateur/widget/section-article/section-edition-widget.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SectionEditionDuJour extends StatelessWidget {
  const SectionEditionDuJour({super.key});

  @override
  Widget build(BuildContext context) {
    final papierJournalUserBloc = Provider.of<PapierJournalUserBloc>(context);

    return Column(
      children: [
        papierJournalUserBloc.papierJournals.isEmpty
            ? const SizedBox()
            : Container(
                height: 450,
                color: noir,
                child: Column(
                  children: [
                    SectionEditionWidget(
                      journalModel: papierJournalUserBloc.papierJournals.last,
                    ),
                    paddingVerticalGlobal(32),
                  ],
                ),
              ),
      ],
    );
  }
}
