//
//  FileManager+ZIP.swift
//  ZIPFoundation
//
//  Copyright © 2017-2019 Thomas Zoechling, https://www.peakstep.com and the ZIP Foundation project authors.
//  Released under the MIT License.
//
//  See https://github.com/weichsel/ZIPFoundation/blob/master/LICENSE for license information.
//

import Foundation

extension FileManager {
    typealias CentralDirectoryStructure = Entry.CentralDirectoryStructure

    // MARK: - Helpers

    func createParentDirectoryStructure(for url: URL) throws {
        let parentDirectoryURL = url.deletingLastPathComponent()
        if !self.fileExists(atPath: parentDirectoryURL.path) {
            try self.createDirectory(at: parentDirectoryURL, withIntermediateDirectories: true, attributes: nil)
        }
    }

    class func attributes(from entry: Entry) -> [FileAttributeKey: Any] {
        let centralDirectoryStructure = entry.centralDirectoryStructure
        let entryType = entry.type
        let fileTime = centralDirectoryStructure.lastModFileTime
        let fileDate = centralDirectoryStructure.lastModFileDate
        let defaultPermissions = entryType == .directory ? defaultDirectoryPermissions : defaultFilePermissions
        var attributes = [.posixPermissions: defaultPermissions] as [FileAttributeKey: Any]
        // Certain keys are not yet supported in swift-corelibs
        #if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
        attributes[.modificationDate] = Date(dateTime: (fileDate, fileTime))
        #endif
        let versionMadeBy = centralDirectoryStructure.versionMadeBy
        guard let osType = Entry.OSType(rawValue: UInt(versionMadeBy >> 8)) else { return attributes }

        let externalFileAttributes = centralDirectoryStructure.externalFileAttributes
        let permissions = self.permissions(for: externalFileAttributes, osType: osType, entryType: entryType)
        attributes[.posixPermissions] = NSNumber(value: permissions)
        return attributes
    }

    class func permissions(for externalFileAttributes: UInt32, osType: Entry.OSType,
                           entryType: Entry.EntryType) -> UInt16 {
        switch osType {
        case .unix, .osx:
            let permissions = mode_t(externalFileAttributes >> 16) & (~S_IFMT)
            let defaultPermissions = entryType == .directory ? defaultDirectoryPermissions : defaultFilePermissions
            return permissions == 0 ? defaultPermissions : UInt16(permissions)
        default:
            return entryType == .directory ? defaultDirectoryPermissions : defaultFilePermissions
        }
    }

    class func externalFileAttributesForEntry(of type: Entry.EntryType, permissions: UInt16) -> UInt32 {
        var typeInt: UInt16
        switch type {
        case .file:
            typeInt = UInt16(S_IFREG)
        case .directory:
            typeInt = UInt16(S_IFDIR)
        case .symlink:
            typeInt = UInt16(S_IFLNK)
        }
        var externalFileAttributes = UInt32(typeInt|UInt16(permissions))
        externalFileAttributes = (externalFileAttributes << 16)
        return externalFileAttributes
    }

    class func permissionsForItem(at URL: URL) throws -> UInt16 {
        let fileManager = FileManager()
        let entryFileSystemRepresentation = fileManager.fileSystemRepresentation(withPath: URL.path)
        var fileStat = stat()
        lstat(entryFileSystemRepresentation, &fileStat)
        let permissions = fileStat.st_mode
        return UInt16(permissions)
    }

    class func fileModificationDateTimeForItem(at url: URL) throws -> Date {
        let fileManager = FileManager()
        guard fileManager.fileExists(atPath: url.path) else {
            throw CocoaError.error(.fileReadNoSuchFile, userInfo: [NSFilePathErrorKey: url.path], url: nil)
        }
        let entryFileSystemRepresentation = fileManager.fileSystemRepresentation(withPath: url.path)
        var fileStat = stat()
        lstat(entryFileSystemRepresentation, &fileStat)
        #if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
        let modTimeSpec = fileStat.st_mtimespec
        #else
        let modTimeSpec = fileStat.st_mtim
        #endif

        let timeStamp = TimeInterval(modTimeSpec.tv_sec) + TimeInterval(modTimeSpec.tv_nsec)/1000000000.0
        let modDate = Date(timeIntervalSince1970: timeStamp)
        return modDate
    }

    class func fileSizeForItem(at url: URL) throws -> UInt32 {
        let fileManager = FileManager()
        guard fileManager.fileExists(atPath: url.path) else {
            throw CocoaError.error(.fileReadNoSuchFile, userInfo: [NSFilePathErrorKey: url.path], url: nil)
        }
        let entryFileSystemRepresentation = fileManager.fileSystemRepresentation(withPath: url.path)
        var fileStat = stat()
        lstat(entryFileSystemRepresentation, &fileStat)
        return UInt32(fileStat.st_size)
    }

    class func typeForItem(at url: URL) throws -> Entry.EntryType {
        let fileManager = FileManager()
        guard fileManager.fileExists(atPath: url.path) else {
            throw CocoaError.error(.fileReadNoSuchFile, userInfo: [NSFilePathErrorKey: url.path], url: nil)
        }
        let entryFileSystemRepresentation = fileManager.fileSystemRepresentation(withPath: url.path)
        var fileStat = stat()
        lstat(entryFileSystemRepresentation, &fileStat)
        return Entry.EntryType(mode: fileStat.st_mode)
    }
}

extension Date {
    init(dateTime: (UInt16, UInt16)) {
        var msdosDateTime = Int(dateTime.0)
        msdosDateTime <<= 16
        msdosDateTime |= Int(dateTime.1)
        var unixTime = tm()
        unixTime.tm_sec = Int32((msdosDateTime&31)*2)
        unixTime.tm_min = Int32((msdosDateTime>>5)&63)
        unixTime.tm_hour = Int32((Int(dateTime.1)>>11)&31)
        unixTime.tm_mday = Int32((msdosDateTime>>16)&31)
        unixTime.tm_mon = Int32((msdosDateTime>>21)&15)
        unixTime.tm_mon -= 1 // UNIX time struct month entries are zero based.
        unixTime.tm_year = Int32(1980+(msdosDateTime>>25))
        unixTime.tm_year -= 1900 // UNIX time structs count in "years since 1900".
        let time = timegm(&unixTime)
        self = Date(timeIntervalSince1970: TimeInterval(time))
    }

    var fileModificationDateTime: (UInt16, UInt16) {
        return (self.fileModificationDate, self.fileModificationTime)
    }

    var fileModificationDate: UInt16 {
        var time = time_t(self.timeIntervalSince1970)
        guard let unixTime = gmtime(&time) else {
            return 0
        }
        var year = unixTime.pointee.tm_year + 1900 // UNIX time structs count in "years since 1900".
        // ZIP uses the MSDOS date format which has a valid range of 1980 - 2099.
        year = year >= 1980 ? year : 1980
        year = year <= 2099 ? year : 2099
        let month = unixTime.pointee.tm_mon + 1 // UNIX time struct month entries are zero based.
        let day = unixTime.pointee.tm_mday
        return (UInt16)(day + ((month) * 32) +  ((year - 1980) * 512))
    }

    var fileModificationTime: UInt16 {
        var time = time_t(self.timeIntervalSince1970)
        guard let unixTime = gmtime(&time) else {
            return 0
        }
        let hour = unixTime.pointee.tm_hour
        let minute = unixTime.pointee.tm_min
        let second = unixTime.pointee.tm_sec
        return (UInt16)((second/2) + (minute * 32) + (hour * 2048))
    }
}

#if swift(>=4.2)
#else

#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
#else

// The swift-corelibs-foundation version of NSError.swift was missing a convenience method to create
// error objects from error codes. (https://github.com/apple/swift-corelibs-foundation/pull/1420)
// We have to provide an implementation for non-Darwin platforms using Swift versions < 4.2.

public extension CocoaError {
    public static func error(_ code: CocoaError.Code, userInfo: [AnyHashable: Any]? = nil, url: URL? = nil) -> Error {
        var info: [String: Any] = userInfo as? [String: Any] ?? [:]
        if let url = url {
            info[NSURLErrorKey] = url
        }
        return NSError(domain: NSCocoaErrorDomain, code: code.rawValue, userInfo: info)
    }
}

#endif
#endif

public extension URL {
    func isContained(in parentDirectoryURL: URL) -> Bool {
        // Ensure this URL is contained in the passed in URL
        let parentDirectoryURL = URL(fileURLWithPath: parentDirectoryURL.path, isDirectory: true).standardized
        return self.standardized.absoluteString.hasPrefix(parentDirectoryURL.absoluteString)
    }
}
