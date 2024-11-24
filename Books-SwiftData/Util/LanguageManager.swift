//
//  LanguageManager.swift
//  Books-SwiftData
//
//  Created by Đoàn Văn Khoan on 24/11/24.
//

import Foundation

class LanguageManager {
    static func setLanguage(_ language: String) {
        UserDefaults.standard.set([language], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        Bundle.setLanguage(language)
    }
}

extension Bundle {
    private static var languageKey: UInt8 = 0

    static func setLanguage(_ language: String?) {
        let languageCode = language.flatMap {
            Locale(identifier: $0).language.languageCode?.identifier
        }
        object_setClass(Bundle.main, PrivateBundle.self)
        objc_setAssociatedObject(Bundle.main, &languageKey, languageCode, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    @objc
    private class func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        if let languageCode = objc_getAssociatedObject(self, &languageKey) as? String,
           let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            return bundle.localizedString(forKey: key, value: value, table: tableName)
        }
        return key
    }
}

private class PrivateBundle: Bundle, @unchecked Sendable {}
