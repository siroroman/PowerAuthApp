enum AppStringKey: String {

    // MARK: - Launch
    case launchTagline = "launch.tagline"

    // MARK: - Landing Page
    case landingTitle = "landing.title"
    case landingSubtitle = "landing.subtitle"
    case landingCTA = "landing.cta"

    // MARK: - Activation
    case activationStep = "activation.step"
    case activationTitle = "activation.title"
    case activationSubtitle = "activation.subtitle"
    case activationConfirm = "activation.confirm"

    // MARK: - Password
    case passwordStep = "password.step"
    case passwordTitle = "password.title"
    case passwordSubtitle = "password.subtitle"
    case passwordPlaceholder = "password.placeholder"
    case passwordConfirm = "password.confirm"
    case passwordRuleLength = "password.rule.length"
    case passwordRuleUppercase = "password.rule.uppercase"
    case passwordRuleSymbol = "password.rule.symbol"

    // MARK: - Result
    case resultStep = "result.step"
    case resultTitle = "result.title"
    case resultSubtitle = "result.subtitle"
    case resultDone = "result.done"

    // MARK: - Error Alerts
    case errorTitleSetupFailed = "error.title.setup_failed"
    case errorTitleActivationFailed = "error.title.activation_failed"
    case errorTitlePasswordFailed = "error.title.password_failed"
    case errorActionTryAgain = "error.action.try_again"
    case errorActionClose = "error.action.close"

    // MARK: - Auth Errors
    case authErrorNotConfigured = "auth.error.not_configured"
    case authErrorUnknown = "auth.error.unknown"
}
