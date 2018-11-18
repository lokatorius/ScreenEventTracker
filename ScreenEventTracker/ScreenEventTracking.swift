import UIKit

public protocol ScreenEventTracking: AnyObject {
    func track(tracker: ScreenEventTracker, screen: ScreenEventConfig)
    func pauseTracking()
    func resumeTracking()
}

public extension ScreenEventTracking where Self: UIViewController {
    public func track(tracker: ScreenEventTracker, screen: ScreenEventConfig) {
        track(tracker: tracker, screen: screen, in: self)
    }

    private func track(tracker: ScreenEventTracker, screen: ScreenEventConfig, in viewController: UIViewController) {
        let viewControllerTracker = ViewControllerEventTracker(screen: screen, tracker: tracker)
        viewController.addChild(viewControllerTracker)
        viewControllerTracker.didMove(toParent: viewController)
        viewController.view.addSubview(viewControllerTracker.view)
        viewController.view.sendSubviewToBack(viewControllerTracker.view)
    }

    public func pauseTracking() {
        viewControllerEventTracker?.pause()
    }

    public func resumeTracking() {
        viewControllerEventTracker?.resume()
    }

    private var viewControllerEventTracker: ViewControllerEventTracker? {
        return children.compactMap({ $0 as? ViewControllerEventTracker }).first
    }
}
