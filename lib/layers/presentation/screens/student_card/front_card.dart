import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/providers/aluno_entity_controller_provider.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/student_card/base_card.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/student_card/build_info_row.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/student_card/card_text_style.dart';
import 'package:provider/provider.dart';

Widget buildFrontCard(Size size) {
  return CardBase(
    size: size,
    child: Consumer<AlunoControllerProvider>(
      builder: (context, consumer, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Exibe a imagem em formato circular. Caso ocorra erro ou carregamento lento, apresenta alternativas.
            ClipOval(
              child: Image.network(
                consumer.alunoController.aluno!.getFullImageUrl!,
                width: size.width * 0.25,
                height: size.width * 0.25,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return SizedBox(
                    width: size.width * 0.25,
                    height: size.width * 0.25,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.account_circle,
                    size: size.width * 0.25,
                    color: Colors.white.withValues(alpha: 0.95),
                  );
                },
              ),
            ),
            Text(
              consumer.alunoController.aluno!.getNome,
              style: cardTextStyle(
                size,
                isBold: true,
                fontSize: size.width * 0.05,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                infoRow(
                  size,
                  Icons.book,
                  'Curso:',
                  consumer.alunoController.aluno!.getCurso!,
                ),
                infoRow(
                  size,
                  Icons.computer,
                  'Modalidade:',
                  consumer.alunoController.aluno!.getModalidade!,
                ),
              ],
            ),
            const Divider(color: Colors.white30, thickness: 1),
          ],
        );
      },
    ),
  );
}
