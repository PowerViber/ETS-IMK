import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import 'target_model.dart';
import 'target_provider.dart';

class TargetScreen extends ConsumerStatefulWidget {
  const TargetScreen({super.key});

  @override
  ConsumerState<TargetScreen> createState() => _TargetScreenState();
}

class _TargetScreenState extends ConsumerState<TargetScreen> {
  DateTime _newTargetDate = DateTime.now();
  final List<String> _activityLogs = [];

  DateTime _normalize(DateTime value) {
    return DateTime(value.year, value.month, value.day);
  }

  String _formatTime(DateTime value) {
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  void _recordActivity(String message) {
    final timestamp = _formatTime(DateTime.now());
    setState(() {
      _activityLogs.insert(0, '$timestamp - $message');
      if (_activityLogs.length > 5) {
        _activityLogs.removeLast();
      }
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  Future<void> _confirmDelete(TargetItem item) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus Target?'),
          content: Text(
            'Target "${item.title}" akan dihapus dari daftar. Aksi ini tidak dapat dibatalkan.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFB94A48),
                foregroundColor: Colors.white,
              ),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      ref.read(targetProvider.notifier).deleteTarget(item.id);
      _recordActivity('Target "${item.title}" dihapus');
      _showSnackBar('Target berhasil dihapus');
    }
  }

  void _toggleCompletion(TargetItem item) {
    ref.read(targetProvider.notifier).toggleCompletion(item.id);
    _recordActivity(
      item.isCompleted
          ? 'Target "${item.title}" dikembalikan'
          : 'Target "${item.title}" dipindahkan ke arsip',
    );
    _showSnackBar(
      item.isCompleted ? 'Target dikembalikan' : 'Target dipindahkan ke arsip',
    );
  }

  void _showTargetSheet({TargetItem? item}) {
    final isEditing = item != null;
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
                  color: context.appSurface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isEditing ? 'Edit Target' : 'Tambah Target Baru',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: context.appTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: 'Judul target',
                        filled: true,
                        fillColor: context.appBackground,
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
                        fillColor: context.appBackground,
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
                          color: context.appBackground,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFC7D8D1)),
                        ),
                        child: Text(
                          'Tanggal: ${localDate.day}/${localDate.month}/${localDate.year}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: context.appTextPrimary,
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
                            _showSnackBar('Judul target tidak boleh kosong');
                            return;
                          }
                          if (isEditing) {
                            ref.read(targetProvider.notifier).updateTarget(
                                  item.id,
                                  title,
                                  desc,
                                  localDate,
                                );
                          } else {
                            ref.read(targetProvider.notifier).addTarget(
                                  title,
                                  desc,
                                  localDate,
                                );
                          }
                          setState(() {
                            _newTargetDate = localDate;
                          });
                          Navigator.pop(context);
                          _recordActivity(
                            isEditing
                                ? 'Target "$title" diperbarui'
                                : 'Target "$title" ditambahkan',
                          );
                          _showSnackBar(
                            isEditing
                                ? 'Target berhasil diperbarui'
                                : 'Target berhasil ditambahkan',
                          );
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
                        child: Text(
                          isEditing ? 'Simpan Perubahan' : 'Simpan Target',
                          style: const TextStyle(fontWeight: FontWeight.w700),
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
    final today = _normalize(DateTime.now());

    final todayTargets = allTargets
        .where((t) => _normalize(t.date) == today && !t.isCompleted)
        .toList();
    final upcomingTargets = allTargets
        .where((t) => _normalize(t.date).isAfter(today) && !t.isCompleted)
        .toList();
    final archivedTargets = allTargets.where((t) => t.isCompleted).toList();

    return Scaffold(
      backgroundColor: context.appBackground,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Target',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: context.appTextPrimary,
                height: 1.05,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Atur rencana belajar dan pantau statusnya.',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: context.appTextSecondary,
              ),
            ),
            const SizedBox(height: 18),
            GestureDetector(
              onTap: _showTargetSheet,
              child: Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF166D56),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x240B5A45),
                      blurRadius: 18,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle_outline,
                        color: Colors.white, size: 22),
                    SizedBox(width: 8),
                    Text(
                      'Mulai Target Baru',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const _TargetSectionHeader(
              title: 'Target Hari Ini',
              subtitle: 'Hal yang perlu diselesaikan sebelum hari berakhir.',
            ),
            const SizedBox(height: 10),
            ...todayTargets.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _TargetCard(
                  item: item,
                  onEdit: () => _showTargetSheet(item: item),
                  onToggleDone: () => _toggleCompletion(item),
                  onDelete: () => _confirmDelete(item),
                ),
              ),
            ),
            if (todayTargets.isEmpty)
              const _EmptySectionCard(
                icon: Icons.today_outlined,
                title: 'Belum ada target hari ini',
                subtitle: 'Tambahkan target baru untuk memulai rutinitas.',
              ),
            const SizedBox(height: 18),
            const _TargetSectionHeader(
              title: 'Target Mendatang',
              subtitle: 'Rencana yang sudah dijadwalkan setelah hari ini.',
            ),
            const SizedBox(height: 10),
            if (upcomingTargets.isEmpty)
              const _EmptySectionCard(
                icon: Icons.event_available_outlined,
                title: 'Belum ada target mendatang',
                subtitle:
                    'Target dengan tanggal berikutnya akan muncul di sini.',
              )
            else
              ...upcomingTargets.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _TargetCard(
                    item: item,
                    onEdit: () => _showTargetSheet(item: item),
                    onToggleDone: () => _toggleCompletion(item),
                    onDelete: () => _confirmDelete(item),
                  ),
                ),
              ),
            const SizedBox(height: 18),
            const _TargetSectionHeader(
              title: 'Diarsipkan',
              subtitle: 'Target yang sudah selesai tersimpan di sini.',
            ),
            const SizedBox(height: 10),
            if (archivedTargets.isEmpty)
              const _EmptySectionCard(
                icon: Icons.inventory_2_outlined,
                title: 'Belum ada arsip',
                subtitle: 'Target selesai akan otomatis masuk ke arsip.',
              )
            else
              ...archivedTargets.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _TargetCard(
                    item: item,
                    onDelete: () => _confirmDelete(item),
                  ),
                ),
              ),
            const SizedBox(height: 18),
            const _TargetSectionHeader(
              title: 'Riwayat Aktivitas',
              subtitle: 'Aksi terbaru yang membentuk kondisi target saat ini.',
            ),
            const SizedBox(height: 10),
            _ActivityLogCard(logs: _activityLogs),
          ],
        ),
      ),
    );
  }
}

class _TargetCard extends StatelessWidget {
  const _TargetCard({
    required this.item,
    required this.onDelete,
    this.onEdit,
    this.onToggleDone,
  });

  final TargetItem item;
  final VoidCallback onDelete;
  final VoidCallback? onEdit;
  final VoidCallback? onToggleDone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 8, 12),
      decoration: BoxDecoration(
        color: context.appSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.appBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 12,
            offset: Offset(0, 4),
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
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: context.appTextPrimary,
                    decoration:
                        item.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 2),
                if (item.description.isNotEmpty)
                  Text(
                    item.description,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: context.appTextSecondary,
                      height: 1.25,
                    ),
                  ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFB9C9C3),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Text(
                    'Sesi belum tersedia',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF315B50),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              if (onEdit != null)
                IconButton(
                  visualDensity: VisualDensity.compact,
                  iconSize: 18,
                  onPressed: onEdit,
                  icon:
                      const Icon(Icons.edit_outlined, color: Color(0xFF166D56)),
                ),
              if (onToggleDone != null)
                IconButton(
                  visualDensity: VisualDensity.compact,
                  iconSize: 18,
                  onPressed: onToggleDone,
                  icon: const Icon(Icons.task_alt, color: Color(0xFF166D56)),
                ),
              IconButton(
                visualDensity: VisualDensity.compact,
                iconSize: 18,
                onPressed: onDelete,
                icon:
                    const Icon(Icons.delete_outline, color: Color(0xFF9A4B46)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TargetSectionHeader extends StatelessWidget {
  const _TargetSectionHeader({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: context.appTextPrimary,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: context.appTextSecondary,
            height: 1.25,
          ),
        ),
      ],
    );
  }
}

class _EmptySectionCard extends StatelessWidget {
  const _EmptySectionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        color: context.appSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.appBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: context.appSoftSurface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF166D56), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: context.appTextPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: context.appTextSecondary,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityLogCard extends StatelessWidget {
  const _ActivityLogCard({required this.logs});

  final List<String> logs;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: context.appSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.appBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: logs.isEmpty
          ? Text(
              'Belum ada aktivitas target',
              style: TextStyle(
                color: context.appTextSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final log in logs) ...[
                  Text(
                    log,
                    style: TextStyle(
                      color: context.appTextPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                  ),
                  if (log != logs.last) const SizedBox(height: 6),
                ],
              ],
            ),
    );
  }
}
