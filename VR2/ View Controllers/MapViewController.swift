
import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Расстановка точек на карте
        
        let complex = MKPointAnnotation()
        complex.coordinate = CLLocationCoordinate2D (latitude: 45.0663, longitude: 39.0047)
        complex.title = "Гарантия на Карякина"
        
        mapView.addAnnotation(complex)
        
        let complex2 = MKPointAnnotation()
        complex2.coordinate = CLLocationCoordinate2D (latitude: 45.0622, longitude: 39.0092)
        complex2.title = "Кубанский"
        
        mapView.addAnnotation(complex2)
        
        let complex3 = MKPointAnnotation()
        complex3.coordinate = CLLocationCoordinate2D (latitude: 45.0976, longitude: 39.0020)
        complex3.title = "ЖК Лучший"
        
        mapView.addAnnotation(complex3)
        
        let complex4 = MKPointAnnotation()
        complex4.coordinate = CLLocationCoordinate2D (latitude: 45.0911, longitude: 39.0115)
        complex4.title = "Оникс"
        
        mapView.addAnnotation(complex4)
        
        let complex5 = MKPointAnnotation()
        complex5.coordinate = CLLocationCoordinate2D (latitude: 45.0622, longitude: 38.9624)
        complex5.title = "Тургенев"
        
        mapView.addAnnotation(complex5)
        
        let complex6 = MKPointAnnotation()
        complex6.coordinate = CLLocationCoordinate2D (latitude: 45.0559, longitude: 38.9982)
        complex6.title = "Сказка"
        
        mapView.addAnnotation(complex6)
        
        let complex7 = MKPointAnnotation()
        complex7.coordinate = CLLocationCoordinate2D (latitude: 45.0469, longitude: 38.9808)
        complex7.title = "ЖК Большой"
        
        mapView.addAnnotation(complex7)
        
        let complex8 = MKPointAnnotation()
        complex8.coordinate = CLLocationCoordinate2D (latitude: 45.0114, longitude: 39.0697)
        complex8.title = "Феникс"
        
        mapView.addAnnotation(complex8)
        
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
        default: break // Добавил чтобы убрать ворнинг
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
