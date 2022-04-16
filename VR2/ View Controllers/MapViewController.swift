//
//  ViewController.swift
//  VR2
//
//  Created by Anton Pavlov on 09.04.2022.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

   // Расстановка точек на карте
    let annontation = MKPointAnnotation()
        annontation.coordinate = CLLocationCoordinate2D (latitude: 45.0663, longitude: 39.0047)
        annontation.title = "Гарантия на Карякина"
        
        mapView.addAnnotation(annontation)
        
    let annontation2 = MKPointAnnotation()
            annontation2.coordinate = CLLocationCoordinate2D (latitude: 45.0622, longitude: 39.0092)
            annontation2.title = "Кубанский"
        
            mapView.addAnnotation(annontation2)
        
    let annontation3 = MKPointAnnotation()
            annontation3.coordinate = CLLocationCoordinate2D (latitude: 45.0976, longitude: 39.0020)
            annontation3.title = "ЖК Лучший"

            mapView.addAnnotation(annontation3)
        
    let annontation4 = MKPointAnnotation()
            annontation4.coordinate = CLLocationCoordinate2D (latitude: 45.0911, longitude: 39.0115)
            annontation4.title = "Оникс"

            mapView.addAnnotation(annontation4)
        
    let annontation5 = MKPointAnnotation()
            annontation5.coordinate = CLLocationCoordinate2D (latitude: 45.0622, longitude: 38.9624)
            annontation5.title = "Тургенев"

            mapView.addAnnotation(annontation5)
        
    let annontation6 = MKPointAnnotation()
            annontation6.coordinate = CLLocationCoordinate2D (latitude: 45.0559, longitude: 38.9982)
            annontation6.title = "Сказка"

            mapView.addAnnotation(annontation6)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        chechLocationEnable()
        
        let initiaLocation = CLLocation(latitude: 45.0402, longitude: 38.9756)
        mapView.centerLocation(initiaLocation)
        
        let cameraCenter = CLLocation(latitude: 45.0402, longitude: 38.9756)
        // Ограничение камеры по удалению
        let region = MKCoordinateRegion(center: cameraCenter.coordinate, latitudinalMeters: 20000, longitudinalMeters: 20000)
        mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        
        let zoomRage  = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 35000)
        mapView.setCameraZoomRange(zoomRage, animated: true)
    }
    
    func chechLocationEnable(){
        if CLLocationManager.locationServicesEnabled(){
            setupManager()
            checkAutorization()
            
        } else {

            showAllertLocation(title: "У вас выключена служба геолокации", message: "Чтобы включить перейдите в настройки", url: URL (string: "App-prefs:root = LOCATION_SERVICES"))
            
        }
    }
    func setupManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
}
    
    func checkAutorization(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
        break
        case .denied:
            showAllertLocation(title: "Вы запретили использование местоположения", message: "Хоите это изменить?", url: URL(string: UIApplication.openSettingsURLString))
        break
        case .restricted:
        break
        case .notDetermined:
        locationManager.requestWhenInUseAuthorization()
       
        }
    }
    
    func showAllertLocation(title: String, message: String?, url: URL?){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction (title: "Настройки", style: .default) {(alert) in
            if let url = url{
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction (title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(settingsAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        }
    
    
}
extension MapViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last?.coordinate{
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 2000, longitudinalMeters: 2000)
            mapView.setRegion(region, animated: false)
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkAutorization()
}

}

extension MKMapView {
    func centerLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 2000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: false)
}

}
