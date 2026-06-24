public enum SupportedCountry: String, CaseIterable, Codable, Equatable, Hashable, Sendable {
    case austria = "AT"
    case belgium = "BE"
    case denmark = "DK"
    case finland = "FI"
    case france = "FR"
    case germany = "DE"
    case italy = "IT"
    case netherlands = "NL"
    case norway = "NO"
    case spain = "ES"
    case sweden = "SE"
    case switzerland = "CH"

    public var code: String {
        rawValue
    }

    public var name: String {
        switch self {
        case .austria:
            return "Austria"
        case .belgium:
            return "Belgium"
        case .denmark:
            return "Denmark"
        case .finland:
            return "Finland"
        case .france:
            return "France"
        case .germany:
            return "Germany"
        case .italy:
            return "Italy"
        case .netherlands:
            return "Netherlands"
        case .norway:
            return "Norway"
        case .spain:
            return "Spain"
        case .sweden:
            return "Sweden"
        case .switzerland:
            return "Switzerland"
        }
    }
}
