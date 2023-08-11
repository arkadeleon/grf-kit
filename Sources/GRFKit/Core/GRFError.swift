//
//  GRFError.swift
//  GRFKit
//
//  Created by Leon Li on 2023/8/11.
//

enum GRFError: Error {
    case nullPathException(path: String)
    case invalidTextEncoding(path: String)
    case pathNotFound(path: String)
    case pathsIdentical(path1: String, path2: String)
    case invalidCharactersInPath(path: String)
    case destIsSubfolder
    case folderNameAlreadyExists(path: String)
    case destMustBeFolder(path1: String, path2: String)
    case destMustBeFile(path1: String, path2: String)
    case hiddenFolderConflict(path: String)
    case fileNameAlreadyExists(path: String)
    case doubleSlashPath(path: String)
    case argumentNullValue(name: String)
    case invalidContainerFormat(path: String, expectedFormat: String)
    case fileNotFound(path: String)
    case headerLengthInvalid(length: Int, expected: Int)
    case readContainerNotOpened
    case accessContainerNotOpened
    case readContainerNotProperlyLoaded
    case nonInstiatedContainer
    case fileLocked(path: String)
    case patcherRequiresUpdate
    case containerBusy
    case containerSaving
    case unsupportedFileFormat(value: String)
    case unsupportedAction
    case unsupportedCompression
    case argumentOutOfRangeMin(name: String, minInclude: any Comparable)
    case argumentOutOfRangeMax(name: String, maxInclude: any Comparable)
    case closedImage
    case nonLoadedImage
    case unsupportedImageFormat
    case noFilesSelected
    case checksumFailed
    case invalidImagePosition(name: String, value: Int)
    case noImageConverter
    case noKeyFileSet
    case wrongKeyFile
    case invalidRepairArguments
    case invalidFileHeaderLength(type: String, length: Int)
    case encryptionCheckFlagInProgress
    case lzmaCompression
    case compressionDllGuard
    case repackInstead
    case entryDataInvalid(path: String)
    case cannotConvertWithErrors
    case fileFormatException(ext: String)
    case fileFormatException2(ext: String, extra: String)
    case unsupportedPixelFormat(bits: Int8)
    case unknownHashAlgorithm
    case unsupportedFileVersion
    case compressionDllFailed(dllName: String)
    case failedToCompressData
    case failedToDecompressData
    case mergeVersionEncryptionException
    case mergeNotSupported
    case couldNotLoadGrf
    case containerNotSavedForRepack
    case operationNotAllowed
    case containerNotSavedForCompact
    case addedGrfModified
    case unsupportedEncryption
    case changeVersionNotAllowed
    case grfAccessViolationOpened
    case grfAccessViolationClosed
    case invalidImageFormat
    case corruptedOrEncryptedEntry(path: String)
    case grfSizeLimitReached

    var localizedDescription: String {
        switch self {
        case .nullPathException(let path):
            return "Path cannot be null or empty.\r\n\(path)";
        case .invalidTextEncoding(let path):
            return "Text encoding invalid.\r\n\(path)";
        case .pathNotFound(let path):
            return "Path not found in the container.\r\n\(path)";
        case .pathsIdentical(let path1, let path2):
            return "The paths are identical.\r\n\(path1)\r\n\(path2)";
        case .invalidCharactersInPath(let path):
            return "The path contains invalid characters.\r\n\(path)";
        case .destIsSubfolder:
            return "The destination folder is a subfolder of the source folder.";
        case .folderNameAlreadyExists(let path):
            return "Folder name already exists.\r\n\(path)";
        case .destMustBeFolder(let path1, let path2):
            return "You are trying to move '\(path1)' to a file ('\(path2)'); the destination must be a folder path.";
        case .destMustBeFile(let path1, let path2):
            return "You are trying to move '\(path1)' to a folder ('\(path2)'); the destination must be a grf file path.";
        case .hiddenFolderConflict(let path):
            return "Folder name not allowed (this happens if you had a folder with this name before; you'll have to undo the operations or save the GRF to edit the name).\r\n\(path)";
        case .fileNameAlreadyExists(let path):
            return "File name already exists.\r\nConflict with : \(path)";
        case .doubleSlashPath(let path):
            return "The path contains double slashes (this is not allowed).\r\n\(path)";
        case .argumentNullValue(let name):
            return "The value cannot be null for the argument '\(name)'.";
        case .invalidContainerFormat(let path, let expectedFormat):
            return "The container format is invalid for this operation.\r\nCurrent : \(path)\r\nExpected format : \(expectedFormat)";
        case .fileNotFound(let path):
            return "File not found.\r\n\(path)";
        case .headerLengthInvalid(let length, let expected):
            return "The length of the stream is too small for this container. Unable to parse the header.\r\nActual size : \(length)\r\nExpected minimal size : \(expected)";
        case .readContainerNotOpened:
            return "Attempted to read the container before opening it.";
        case .accessContainerNotOpened:
            return "Attempted to access a container before opening it.";
        case .readContainerNotProperlyLoaded:
            return "Attempted to read a container that wasn't loaded properly. NullReferenceException expected.";
        case .nonInstiatedContainer:
            return "Attempted to perform an operation on a non instantiated container.";
        case .fileLocked(let path):
            return "Cannot access the file '\(path)'. It is locked by another process.";
        case .patcherRequiresUpdate:
            return "The patcher requires to be updated.";
        case .containerBusy:
            return "The container is currently busy and operations are disabled.";
        case .containerSaving:
            return "The GRF is already saving... wait or cancel the operation first.";
        case .unsupportedFileFormat(let value):
            return "The file format '\(value)' is unknown or not supported.";
        case .unsupportedAction:
            return "The method is not supported for this container.";
        case .unsupportedCompression:
            return "The compression method does not support compressing files. It is meant for extracting the GRF's file content from their offset directly.";
        case .argumentOutOfRangeMin(let name, let minInclude):
            return "The argument \(name) is below the minimum value \(minInclude).";
        case .argumentOutOfRangeMax(let name, let maxInclude):
            return "The argument \(name) is above the maximum value \(maxInclude).";
        case .closedImage:
            return "The image component has been closed.";
        case .nonLoadedImage:
            return "Pixel data hasn't been set (invalid image format?).";
        case .unsupportedImageFormat:
            return "The image format doesn't support this operation.";
        case .noFilesSelected:
            return "At least one entry must be selected.";
        case .checksumFailed:
            return "The zlib checksum for the compressed data has failed.";
        case .invalidImagePosition(let name, let value):
            return "The value '\(name)' must be greater or equal to \(value).";
        case .noImageConverter:
            return "No appropriate converter was found for the image. An image converter needs to be registered at the beginning of the application. The GrfImageObject file shows an example on how to create such a class.";
        case .noKeyFileSet:
            return "No key file was set to decrypt this file.";
        case .wrongKeyFile:
            return "The key or key file is invalid.";
        case .invalidRepairArguments:
            return "When opening a GRF in the repair mode, only the repair flag can be used.";
        case .invalidFileHeaderLength(let type, let length):
            return "The minimum length of the header (\(type) is invalid, it must be greater than \(length).";
        case .encryptionCheckFlagInProgress:
            return "You cannot extract files or save while the GRF is being inspected for encrypted content. This operation should be quick, please wait.";
        case .lzmaCompression:
            return "The compression used for this entry is LZMA and it is not supported by the current compression method. Please change the compression by going in Settings > General > Compression method > Custom...";
        case .compressionDllGuard:
            return "GRF Editor has detected the custom compression DLL cannot be loaded and will most likely crash the application. The compression method has been resetted to the original file.";
        case .repackInstead:
            return "The container should be repacked instead.";
        case .entryDataInvalid(let path):
            return "The file entry for '\(path)' contains invalid information (the offset is invalid).";
        case .cannotConvertWithErrors:
            return "Cannot convert to a GRF container while the current container contains errors.";
        case .fileFormatException(let ext):
            return "Unrecognized file format (\(ext).";
        case .fileFormatException2(let ext, let extra):
            return "Unrecognized file format (\(ext). \(extra)";
        case .unsupportedPixelFormat(let bits):
            return "Unsupported pixel format : \(bits).";
        case .unknownHashAlgorithm:
            return "Unknown hash algorithm.";
        case .unsupportedFileVersion:
            return "Unsupported file version.";
        case .compressionDllFailed(let dllName):
            return "Failed to load the decompression library (\(dllName).";
        case .failedToCompressData:
            return "Failed to compress data.";
        case .failedToDecompressData:
            return "Failed to decompress data.";
        case .mergeVersionEncryptionException:
            return "The destination GRF must have a version higher than 0x100 when merging with an ecrypted GRF.";
        case .mergeNotSupported:
            return "Attempted to merge a GRF by using a method that doesn't support this feature.";
        case .couldNotLoadGrf:
            return "Couldn't load the GRF.";
        case .containerNotSavedForRepack:
            return "The container must be saved before repacking its content.";
        case .operationNotAllowed:
            return "The container cannot execute the operation requested.";
        case .containerNotSavedForCompact:
            return "The container must be saved before redirecting its content.";
        case .addedGrfModified:
            return "The GRF to add has been modified, save it first.";
        case .unsupportedEncryption:
            return "The encryption feature is incompatible with the version used on this GRF. Decrypt your GRF from an older version and encrypt it again.";
        case .changeVersionNotAllowed:
            return "Operation not allowed: you cannot change the GRF version manually, use the ChangeVersion() command instead.";
        case .grfAccessViolationOpened:
            return "Attempted to perform an operation on an opened GRF.";
        case .grfAccessViolationClosed:
            return "Attempted to perform an operation on an closed GRF.";
        case .invalidImageFormat:
            return "Unable to parse the image data. The content is either corrupted or not supported.";
        case .corruptedOrEncryptedEntry(let path):
            return "Failed to decompress data. The following entry is either corrupted or encrypted: \r\n\(path)";
        case .grfSizeLimitReached:
            return "Failed to save the GRF, size limit reached (4,294,967,295 bytes).";
        }
    }
}
