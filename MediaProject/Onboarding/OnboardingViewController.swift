//
//  OnboardingViewController.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/25.
//

import UIKit
import SnapKit

final class OnboardingViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    fileprivate var list: [UIViewController] = []

    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        list = [FirstOnboardingViewController(), SecondOnboardingViewController(), ThirdOnboardingViewController()]

        view.backgroundColor = .black
        delegate = self
        dataSource = self

        guard let first = list.first else { return }
        setViewControllers([first], direction: .forward, animated: true)

    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = list.firstIndex(of: viewController),
                currentIndex > 0 else { return nil }
        let previousIndex = currentIndex - 1
        return list[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = list.firstIndex(of: viewController),
              currentIndex < list.count-1 else { return nil }

        let nextIndex = currentIndex + 1
        return list[nextIndex]
    }

}

private class FirstOnboardingViewController: UIViewController {

    let mainLabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 30)
        label.text = "영화"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(mainLabel)
        setLayout()
    }

    func setLayout() {
        mainLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

}

private class SecondOnboardingViewController: UIViewController {

    let mainLabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 30)
        label.text = "TV"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(mainLabel)
        setLayout()
    }

    func setLayout() {
        var a = [1]
        a.append(1)
        mainLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

}

private class ThirdOnboardingViewController: UIViewController {

    private let startButton = {
        let button = UIButton()
        button.setTitle("시작하기", for: .normal)
        button.backgroundColor = .systemPink
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(startButton)
        setLayout()
        setConfiguration()
    }


    @objc private func startButtonDidTap() {

        UserDefaults.standard.setValue(true, forKey: "isNotFirstRunnig")

        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate

        let vc = MovieViewController()
        
        sceneDelegate?.window?.rootViewController = UINavigationController(rootViewController: vc)
        sceneDelegate?.window?.makeKeyAndVisible()
    }

    private func setLayout() {
        startButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

    private func setConfiguration() {
        startButton.addTarget(self, action: #selector(startButtonDidTap), for: .touchUpInside)
    }
}
