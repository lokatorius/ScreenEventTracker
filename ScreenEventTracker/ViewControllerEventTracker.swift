final class ViewControllerEventTracker: UIViewController {
    private let screen: ScreenEventConfig
    private let tracker: ScreenEventTracker
    private var stopTracking: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.isUserInteractionEnabled = false
        view.backgroundColor = .clear
        print("tracker viewDidLoad")
        if case ScreenTrackingMode.loaded = screen.mode, !stopTracking {
            tracker.track(screen)
            stopTracking = true
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if stopTracking {
            return
        }
        switch screen.mode {
        case .appeared:
            tracker.track(screen)
        case .appearedOnce:
            tracker.track(screen)
            stopTracking = true
        case .loaded:
            return
        }
    }

    init(screen: ScreenEventConfig, tracker: ScreenEventTracker) {
        self.screen = screen
        self.tracker = tracker
        super.init(nibName: nil, bundle: nil)
    }

    func pause() {
        stopTracking = true
    }

    func resume() {
        stopTracking = false
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
