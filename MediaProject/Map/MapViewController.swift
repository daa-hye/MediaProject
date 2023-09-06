//
//  MapViewController.swift
//  MediaProject
//
//  Created by 박다혜 on 2023/08/23.
//

import UIKit
import CoreLocation
import MapKit
import SnapKit

final class MapViewController: UIViewController {

    private let theaterList = TheaterList().mapAnnotations

    private let locationManager = CLLocationManager()
    private let mapView = MKMapView()
    private let selectTheaterButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "영화관 선택"
        button.backgroundColor = .darkGray
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        checkDeviceLocationAuth()
        showAll()

    }

    private func setAnnotation(theater: Theater) {

        let annotation = MKPointAnnotation()
        annotation.title = theater.location
        annotation.coordinate = CLLocationCoordinate2D(latitude: theater.latitude, longitude: theater.longitude)

        mapView.addAnnotation(annotation)

    }

    private func setRegion(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 200, longitudinalMeters: 200)
        mapView.setRegion(region, animated: true)
    }

    private func checkAppLocationAuth(status: CLAuthorizationStatus) {

        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("restricted")
        case .denied:
            showRequestLocationServiceAlert()
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .authorized:
            print("authorized")
        @unknown default:
            print("default")
        }
    }

    private func checkDeviceLocationAuth() {

        DispatchQueue.global().async {

            if CLLocationManager.locationServicesEnabled() {

                let auth: CLAuthorizationStatus

                if #available(iOS 14.0, *) {
                    auth = self.locationManager.authorizationStatus
                } else {
                    auth = CLLocationManager.authorizationStatus()
                }

                DispatchQueue.main.async {
                    self.checkAppLocationAuth(status: auth)
                }

            } else {
                self.showRequestLocationServiceAlert()
            }
        }
    }

}

extension MapViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if let cordinate = locations.last?.coordinate {
            setRegion(center: cordinate)
        }
        
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let center = CLLocationCoordinate2D(latitude: 37.51845, longitude: 126.88494)
        setRegion(center: center)
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkDeviceLocationAuth()
    }
}

extension MapViewController {

    private func showAll() {

        if !mapView.annotations.isEmpty {
            mapView.removeAnnotations(mapView.annotations)
        }

        for theater in theaterList {
            setAnnotation(theater: theater)
        }

    }

    private func showSelectedTheater(type: String) {

        mapView.removeAnnotations(mapView.annotations)

        for theater in theaterList {
            guard theater.type == type else { continue }
            setAnnotation(theater: theater)
        }
    }

    @objc private func selectTheaterButtonDidTap() {

        let selectTheaterActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let mega = UIAlertAction(title: "메가박스", style: .default) { alert in
            self.showSelectedTheater(type: alert.title!)
        }
        let lotte = UIAlertAction(title: "롯데시네마", style: .default) { alert in
            self.showSelectedTheater(type: alert.title!)
        }
        let cgv = UIAlertAction(title: "CGV", style: .default) { alert in
            self.showSelectedTheater(type: alert.title!)
        }
        let all = UIAlertAction(title: "전체보기", style: .default) { _ in
            self.showAll()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        selectTheaterActionSheet.addAction(mega)
        selectTheaterActionSheet.addAction(lotte)
        selectTheaterActionSheet.addAction(cgv)
        selectTheaterActionSheet.addAction(all)
        selectTheaterActionSheet.addAction(cancel)
        present(selectTheaterActionSheet, animated: true)

    }

    private func setUI() {

        view.addSubview(mapView)
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }

        view.addSubview(selectTheaterButton)
        selectTheaterButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(30)
            $0.trailing.equalTo(view).offset(-20)
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        selectTheaterButton.addTarget(self, action: #selector(selectTheaterButtonDidTap), for: .touchUpInside)
    }

    /*
     Location Authorization Custom Alert
     */

    private func showRequestLocationServiceAlert() {

      let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)

      let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
          if let appSetting = URL(string: UIApplication.openSettingsURLString) {
              UIApplication.shared.open(appSetting)
          }

      }
      let cancel = UIAlertAction(title: "취소", style: .default)
      requestLocationServiceAlert.addAction(cancel)
      requestLocationServiceAlert.addAction(goSetting)

      present(requestLocationServiceAlert, animated: true, completion: nil)
    }

}
