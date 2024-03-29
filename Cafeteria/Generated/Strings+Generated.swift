// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Authorization {
    /// e-mail
    internal static let email = L10n.tr("Localizable", "authorization.email", fallback: "e-mail")
    /// Войти
    internal static let enter = L10n.tr("Localizable", "authorization.enter", fallback: "Войти")
    /// Пароль
    internal static let password = L10n.tr("Localizable", "authorization.password", fallback: "Пароль")
    /// Вход
    internal static let title = L10n.tr("Localizable", "authorization.title", fallback: "Вход")
  }
  internal enum Map {
    /// Карта
    internal static let title = L10n.tr("Localizable", "map.title", fallback: "Карта")
  }
  internal enum Menu {
    /// Перейти к оплате
    internal static let goToPay = L10n.tr("Localizable", "menu.goToPay", fallback: "Перейти к оплате")
    ///  руб
    internal static let rub = L10n.tr("Localizable", "menu.rub", fallback: " руб")
    /// Меню
    internal static let title = L10n.tr("Localizable", "menu.title", fallback: "Меню")
  }
  internal enum NearestCafeterian {
    /// от вас
    internal static let fromYou = L10n.tr("Localizable", "nearestCafeterian.fromYou", fallback: "от вас")
    ///  км 
    internal static let km = L10n.tr("Localizable", "nearestCafeterian.km", fallback: " км ")
    ///  м 
    internal static let m = L10n.tr("Localizable", "nearestCafeterian.m", fallback: " м ")
    /// На карте
    internal static let onMap = L10n.tr("Localizable", "nearestCafeterian.onMap", fallback: "На карте")
    /// Ближайшие кофейни
    internal static let title = L10n.tr("Localizable", "nearestCafeterian.title", fallback: "Ближайшие кофейни")
  }
  internal enum Order {
    /// Оплатить
    internal static let pay = L10n.tr("Localizable", "order.pay", fallback: "Оплатить")
    /// Время ожидания заказа
    ///  15 минут!
    /// Спасибо, что выбрали нас!
    internal static let thanks = L10n.tr("Localizable", "order.thanks", fallback: "Время ожидания заказа\n 15 минут!\nСпасибо, что выбрали нас!")
    /// Ваш заказ
    internal static let title = L10n.tr("Localizable", "order.title", fallback: "Ваш заказ")
  }
  internal enum Registration {
    /// e-mail
    internal static let email = L10n.tr("Localizable", "registration.email", fallback: "e-mail")
    /// Введите email
    internal static let emailPlaceholder = L10n.tr("Localizable", "registration.emailPlaceholder", fallback: "Введите email")
    /// Вы уже зарегистрированы?
    internal static let enterLogin = L10n.tr("Localizable", "registration.enterLogin", fallback: "Вы уже зарегистрированы?")
    /// Пароль
    internal static let password = L10n.tr("Localizable", "registration.password", fallback: "Пароль")
    /// ******
    internal static let passwordPlaceholder = L10n.tr("Localizable", "registration.passwordPlaceholder", fallback: "******")
    /// Регистрация
    internal static let registration = L10n.tr("Localizable", "registration.registration", fallback: "Регистрация")
    /// Повторите пароль
    internal static let repeatPassword = L10n.tr("Localizable", "registration.repeatPassword", fallback: "Повторите пароль")
  }
  internal enum Warning {
    /// Не удалось авторизоваться
    internal static let accountDidNotAuthorize = L10n.tr("Localizable", "warning.accountDidNotAuthorize", fallback: "Не удалось авторизоваться")
    /// Не удалось создать аккаунт
    internal static let accountDidNotCreate = L10n.tr("Localizable", "warning.accountDidNotCreate", fallback: "Не удалось создать аккаунт")
    /// Проверьте email
    internal static let invalidEmail = L10n.tr("Localizable", "warning.invalidEmail", fallback: "Проверьте email")
    /// Проверьте пароль
    internal static let invalidPassword = L10n.tr("Localizable", "warning.invalidPassword", fallback: "Проверьте пароль")
    /// Не удалось загрузить локации
    internal static let locationsDidNotUpdate = L10n.tr("Localizable", "warning.locationsDidNotUpdate", fallback: "Не удалось загрузить локации")
    /// Не удалось загрузить меню
    internal static let menuDidNotDownloaded = L10n.tr("Localizable", "warning.menuDidNotDownloaded", fallback: "Не удалось загрузить меню")
    /// Ошибка
    internal static let title = L10n.tr("Localizable", "warning.title", fallback: "Ошибка")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
