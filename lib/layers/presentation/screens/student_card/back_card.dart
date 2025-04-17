import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/providers/aluno_entity_controller_provider.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/student_card/base_card.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/student_card/build_info_row.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/student_card/card_text_style.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';
import 'package:provider/provider.dart';

Widget buildBackCard(Size size) {
  return CardBase(
    size: size,
    showTopRightIcon: true,
    child: Consumer<AlunoControllerProvider>(
      builder: (context, userProvider, child) {
        final aluno = userProvider.alunoController.aluno;

        // Recupera os valores das datas.
        final DateTime? dataInicio = aluno?.getDataInicio;
        final DateTime? dataFim = aluno?.getDataFim;

        // Formata as datas para dd/MM/yyyy ou retorna "----" se for nulo.
        final String formattedDataInicio =
            dataInicio != null
                ? dataInicio.day.toString().padLeft(2, '0') +
                    "/" +
                    dataInicio.month.toString().padLeft(2, '0') +
                    "/" +
                    dataInicio.year.toString()
                : "----";
        final String formattedDataFim =
            dataFim != null
                ? dataFim.day.toString().padLeft(2, '0') +
                    "/" +
                    dataFim.month.toString().padLeft(2, '0') +
                    "/" +
                    dataFim.year.toString()
                : "----";

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                infoRow(
                  size,
                  Icons.check_circle,
                  'Situação:',
                  aluno?.getSituacao ?? "----",
                ),
                infoRow(
                  size,
                  Icons.access_time,
                  'Turno:',
                  aluno?.getTurno ?? "----",
                ),
                infoRow(size, Icons.date_range, 'Início:', formattedDataInicio),
                infoRow(size, Icons.date_range, 'Término:', formattedDataFim),
              ],
            ),
            Divider(
              color: AppColors.textColor.withValues(alpha: 0.3),
              thickness: 1,
            ),
            Column(
              children: [
                Icon(
                  Icons.qr_code,
                  size: size.width * 0.22,
                  color: AppColors.textColor.withValues(alpha: 0.95),
                  shadows: [
                    Shadow(
                      blurRadius: 4,
                      color: AppColors.shadowColor,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.008),
                Text(
                  'Matrícula: ${aluno?.getMatricula.toString() ?? "----"}',
                  style: cardTextStyle(size, isBold: true),
                ),
              ],
            ),
          ],
        );
      },
    ),
  );
}
