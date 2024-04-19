//
//  MapViewController.swift
//  Navigation
//
//  Created by Руслан Усманов on 14.04.2024.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        return manager
    }()
    
    private var destination: MKPlacemark?
    private var btnState: RouteBtnState = RouteBtnState.startRoute {
        didSet {
            navigateButton.setTitle(btnState.rawValue, for: .normal)
        }
    }
    
    //MARK: Subviews
    
    private let map: MKMapView
    
    private lazy var navigateButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Set a route", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.alpha = 0.5
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(navigateButtonDidTap), for: .touchUpInside)
        return btn
    }()
    
    //MARK: LifeCycle
    
    init(map: MKMapView) {
        self.map = map
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureMapView()
        setConstraints()
        checkLocationPermission()
        addGestureForAnnotation()

    }
    
    //MARK: Private
    
    private func setConstraints() {
        let safe = view.safeAreaLayoutGuide
        [map, navigateButton].forEach({
            view.addSubview($0)
        })
        NSLayoutConstraint.activate([
            map.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            map.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            map.topAnchor.constraint(equalTo: safe.topAnchor),
            map.bottomAnchor.constraint(equalTo: safe.bottomAnchor),
            
            navigateButton.leadingAnchor.constraint(equalTo: safe.leadingAnchor,constant: 16),
            navigateButton.heightAnchor.constraint(equalToConstant: 50),
            navigateButton.widthAnchor.constraint(equalToConstant: 150),
            navigateButton.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -75),
            
            
        ])
    }
    
    private func checkLocationPermission() {
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            map.showsUserLocation = true
            map.userTrackingMode =  .follow
        case .restricted, .denied:
            showMessageWithAction(title: "For this app feature geolocation access is required", message: nil, actionMessage: "Open Settings", completion: {
                UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!)
            })
        case .authorizedAlways, .authorizedWhenInUse:
            map.showsUserLocation = true
            map.userTrackingMode =  .follow
        @unknown default:
            break
        }
    }
    
    private func configureMapView() {
        map.translatesAutoresizingMaskIntoConstraints = false
        map.delegate = self
    }
    
    
    //MARK: AddGestures
    private func addGestureForAnnotation(){
        map.gestureRecognizers?.forEach({
            map.removeGestureRecognizer($0)
        })
        let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(addAnnotation))
        map.addGestureRecognizer(gesture)
    }
    
    private func addGestureForRouting(){
        map.gestureRecognizers?.forEach({
            map.removeGestureRecognizer($0)
        })
        let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(setDestinationGesture))
        map.addGestureRecognizer(gesture)
    }
    
    //MARK: Gestures
    @objc func addAnnotation(recognizer: UILongPressGestureRecognizer){
        let point = recognizer.location(in: map)
        let annotation = MKPointAnnotation()
        let mapPoint = map.convert(point, toCoordinateFrom: map)
        annotation.coordinate = mapPoint
        map.addAnnotation(annotation)
    }
    
    @objc func setDestinationGesture(recognizer: UILongPressGestureRecognizer){
        let point = recognizer.location(in: map)
        let mapPoint = map.convert(point, toCoordinateFrom: map)
        
        destination = MKPlacemark(coordinate: mapPoint)
        createRoute()
        
        addGestureForAnnotation()
        
        btnState = RouteBtnState.cancel
    }
    
    //MARK: ButtonDidTap
    
    @objc func navigateButtonDidTap(){
        switch btnState {
        case .startRoute:
            
            btnState = RouteBtnState.waitingForDestination
            
            addGestureForRouting()
            
        case .waitingForDestination:
            btnState = RouteBtnState.startRoute
            
        case .cancel:
            btnState = RouteBtnState.startRoute
            
            let overlays = map.overlays
            map.removeOverlays(overlays)
            
            addGestureForAnnotation()
        }
    }
    
    //MARK: Routing
    
    private func createRoute(){
        guard let destination else {return}
        let startPoint = MKPlacemark(coordinate: map.userLocation.coordinate)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startPoint)
        request.destination = MKMapItem(placemark: destination)
        request.transportType = .walking
        let directions = MKDirections(request: request)
        directions.calculate(completionHandler: {[weak self] response ,error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let direction = response?.routes.first else { return }
            self?.map.addOverlay(direction.polyline)
        })
    }
    

}

//MARK: MapKit Delegate

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay)
        render.strokeColor = .blue
        render.lineWidth = 4
        return render
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if let overlay = mapView.overlays.first {
            if mapView.overlays.count == 2 {
                mapView.removeOverlay(overlay)
            }
            createRoute()
        }
        
    }
}

