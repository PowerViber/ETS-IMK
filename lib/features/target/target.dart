import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'target_model.dart';
import 'target_provider.dart';

class TargetScreen extends ConsumerStatefulWidget {
  const TargetScreen({super.key});

  @override
  ConsumerState<TargetScreen> createState() => _TargetScreenState();
}

class _TargetScreenState extends ConsumerState<TargetScreen> {
  DateTime _newTargetDate = DateTime.now();

  DateTime _normalize(DateTime value) {
    return DateTime(value.year, value.month, value.day);
  }

  void _showTargetSheet({TargetItem? item}) {
    final titleController = TextEditingController(text: item?.title ?? '');
    final descController = TextEditingController(text: item?.description ?? '');
    final selectedDate = item?.date ?? _newTargetDate;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        DateTime localDate = selectedDate;

        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 14,
                right: 14,
                bottom: MediaQuery.of(context).viewInsets.bottom + 14,
                top: 14,
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8EFEC),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tambah Target Baru',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF23483F),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: 'Judul target',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFFC7D8D1)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFFC7D8D1)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: descController,
                      maxLines: 2,
                      decoration: InputDecoration(
                        hintText: 'Deskripsi target',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFFC7D8D1)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFFC7D8D1)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: localDate,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          setModalState(() {
                            localDate = picked;
                          });
                        }
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFC7D8D1)),
                        ),
                        child: Text(
                          'Tanggal: ${localDate.day}/${localDate.month}/${localDate.year}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF32564D),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final title = titleController.text.trim();
                          final desc = descController.text.trim();
                          if (title.isEmpty) {
                            return;
                          }
                          ref.read(targetProvider.notifier).addTarget(
                                title,
                                desc,
                                localDate,
                              );
                          setState(() {
                            _newTargetDate = localDate;
                          });
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF63B295),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Simpan Target',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final allTargets = ref.watch(targetProvider);
    final notifier = ref.read(targetProvider.notifier);
    final today = _normalize(DateTime.now());

    final todayTargets = allTargets
        .where((t) => _normalize(t.date) == today && !t.isCompleted)
        .toList();
    final upcomingTargets = allTargets
        .where((t) => _normalize(t.date).isAfter(today) && !t.isCompleted)
        .toList();
    final archivedTargets = allTargets.where((t) => t.isCompleted).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF0F1F1),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(12, 16, 12, 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _showTargetSheet,
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFCEE0DA),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x22000000),
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'MULAI TARGET BARU   +',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF355D52),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Target Hari Ini',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF234B41),
              ),
            ),
            const SizedBox(height: 8),
            ...todayTargets.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _TargetCard(
                  item: item,
                  onEdit: () => _showTargetSheet(item: item),
                  onToggleDone: () => notifier.toggleCompletion(item.id),
                  onDelete: () => notifier.deleteTarget(item.id),
                ),
              ),
            ),
            if (todayTargets.isEmpty) const _EmptySectionCard(),
            const SizedBox(height: 14),
            const Text(
              'Target Mendatang',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF234B41),
              ),
            ),
            const SizedBox(height: 8),
            if (upcomingTargets.isEmpty)
              const _EmptySectionCard()
            else
              ...upcomingTargets.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _TargetCard(
                    item: item,
                    onEdit: () => _showTargetSheet(item: item),
                    onToggleDone: () => notifier.toggleCompletion(item.id),
                    onDelete: () => notifier.deleteTarget(item.id),
                  ),
                ),
              ),
            const SizedBox(height: 14),
            const Text(
              'Diarsipkan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF234B41),
              ),
            ),
            const SizedBox(height: 8),
            if (archivedTargets.isEmpty)
              const _EmptySectionCard()
            else
              ...archivedTargets.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _TargetCard(
                    item: item,
                    onEdit: () => _showTargetSheet(item: item),
                    onToggleDone: () => notifier.toggleCompletion(item.id),
                    onDelete: () => notifier.deleteTarget(item.id),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _TargetCard extends StatelessWidget {
  const _TargetCard({
    required this.item,
    required this.onEdit,
    required this.onToggleDone,
    required this.onDelete,
  });

  final TargetItem item;
  final VoidCallback onEdit;
  final VoidCallback onToggleDone;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 10, 10),
      decoration: BoxDecoration(
        color: const Color(0xFFD3DFDB),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF234B41),
                    decoration:
                        item.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 2),
                if (item.description.isNotEmpty)
                  Text(
                    item.description,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF3A5C53),
                    ),
                  ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF63B295),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Text(
                    'Mulai Sesi',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFEAF5F1),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                visualDensity: VisualDensity.compact,
                iconSize: 18,
                onPressed: onEdit,
                icon: const Icon(Icons.edit_outlined, color: Color(0xFF315B50)),
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                iconSize: 18,
                onPressed: onToggleDone,
                icon: const Icon(Icons.task_alt, color: Color(0xFF315B50)),
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                iconSize: 18,
                onPressed: onDelete,
                icon: const Icon(Icons.delete, color: Color(0xFF315B50)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmptySectionCard extends StatelessWidget {
  const _EmptySectionCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 112,
      decoration: BoxDecoration(
        color: const Color(0xFFD3DFDB),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: const Center(
        child: Text(
          'Tidak Ada',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w500,
            color: Color(0xFF4C6960),
          ),
        ),
      ),
    );
  }
}
