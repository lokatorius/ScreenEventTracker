public typealias ScreenEventConfig = (name: String, mode: ScreenTrackingMode)

public enum ScreenTrackingMode {
    case loaded
    case appeared
    case appearedOnce
}

