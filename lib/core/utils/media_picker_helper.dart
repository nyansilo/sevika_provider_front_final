import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

/// A simple data class to pass both the path and the display name back to the UI
class PickedFileMeta {
  final String path;
  final String name;

  PickedFileMeta({required this.path, required this.name});
}

/// 🛠️ Centralized Media Picker Helper
///
/// Decouples the `image_picker` and `file_picker` SDKs from the UI layer.
class MediaPickerHelper {
  const MediaPickerHelper._();

  static final ImagePicker _imagePicker = ImagePicker();

  /// Captures or selects an image using the device camera or gallery.
  ///
  /// * Returns the file path (`String`) if successful.
  /// * Returns `null` if the user cancels.
  /// * Throws an Exception if hardware access fails (e.g., permissions).
  static Future<String?> pickImage({required ImageSource source}) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: source,
        imageQuality: 80, // Compress to avoid backend limits
        maxWidth: 1200, // Standardize width
      );

      return pickedFile?.path;
    } catch (e) {
      throw Exception('Hardware access denied or failed.');
    }
  }

  /// Selects a document (PDF, PNG, JPG) from the device file system.
  ///
  /// * Returns a `PickedFileMeta` object containing the path and filename.
  /// * Returns `null` if the user cancels.
  /// * Throws an Exception if the file system access fails.
  /// Selects a document (PDF, PNG, JPG) from the device file system.
  static Future<PickedFileMeta?> pickDocument() async {
    try {
      // 🚀 v12 MIGRATION FIX:
      // We now use FilePicker.pickFile() directly instead of FilePicker.platform.pickFiles().
      // It cleanly returns a single PlatformFile? instead of a nested FilePickerResult object.
      final PlatformFile? file = await FilePicker.pickFile(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      );

      // Extract the path securely from the new V12 object
      if (file != null && file.path != null) {
        return PickedFileMeta(path: file.path!, name: file.name);
      }

      return null;
    } catch (e) {
      throw Exception('File system access denied or failed.');
    }
  }
}
