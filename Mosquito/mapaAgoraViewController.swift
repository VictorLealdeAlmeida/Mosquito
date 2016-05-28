//
//  mapaAgoraViewController.swift
//  Mosquito
//
//  Created by Victor Leal Porto de Almeida Arruda on 27/05/16.
//  Copyright © 2016 Victor Leal Porto de Almeida Arruda. All rights reserved.
//

import Foundation

import UIKit
import MapKit

class mapaAgoraViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapa: MKMapView!
    
    class Lugar:  NSObject, MKAnnotation {
        var title: String?
        var subtitle: String?
        var coordinate: CLLocationCoordinate2D
        init(title:String , subtitle:String ,coordinate: CLLocationCoordinate2D) {
            self.title = title
            self.subtitle = subtitle
            self.coordinate = coordinate
    } }
    
    var regions:[String]!
    var latitudes:[Double]!
    var longitudes:[Double]!
    var locations:[CLLocation]!
    var weights:[Double]!
    var areas:[Double]!
    var incidenceCounts:[String: Int]!
    
    var locationManager:CLLocationManager!
    var userCoord:CLLocationCoordinate2D!
    
    var heatView:UIImageView!
    var selectIndex = 0
    
    override func viewDidLoad() {
 
        super.viewDidLoad()
        
        self.heatView = UIImageView(frame: mapa.frame)
        self.heatView.contentMode = UIViewContentMode.Center;
        
        
        incidenceCounts = [:];
        locations = []
        
        regions = Information.regions()
        latitudes = Information.latitudes()
        longitudes = Information.longitudes()
        areas = Information.areas()
        weights = Information.weights();
        
       
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapa.delegate = self
        let startCoord = CLLocationCoordinate2DMake(-8.0524415,-34.92565148689435);
        let adjustedRegion = mapa.regionThatFits(MKCoordinateRegionMakeWithDistance(startCoord, 7000, 7000))
        mapa.setRegion(adjustedRegion, animated: true)
    
        
        var i = 0
        while(i < regions.count){
            let criarPonto = MKPointAnnotation()
            criarPonto.title = regions[i]
            let loc = CLLocation(latitude: latitudes[i], longitude: longitudes[i])
            locations.append(loc)
            criarPonto.coordinate = CLLocationCoordinate2DMake(latitudes[i], longitudes[i])
            mapa.addAnnotation(criarPonto)
            var area = areas[i]
            area = sqrt(area)
            area *= 50000;
            selectIndex = i
            i = i + 1
            
        }
        print (locations.count)
        print (weights.count)
        let heatImage = LFHeatMap.heatMapForMapView(mapa, boost: 1, locations: locations, weights: weights)
        self.heatView.image = heatImage;
        self.view.addSubview(heatView)
        
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) ->
        MKAnnotationView {
            let identifier = "viewLugar"
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView
            if annotationView == nil
            {
                let detailButton: UIButton = UIButton(type: UIButtonType.DetailDisclosure)
               annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView!.canShowCallout = true
                ///annotationView!.animatesDrop = true
                annotationView!.image = UIImage(named: "pino-magico-25.png")
                annotationView!.rightCalloutAccessoryView = detailButton
            }
            
            annotationView!.annotation = annotation
            return annotationView!
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print(view.annotation?.title)
        let ind = acharIndice(view.annotation!.title!!)
        self.performSegueWithIdentifier("verDetalhes", sender: Information.areaData(ind))
    }
    
    func acharIndice(nome : String) -> Int{
        var v = 0
        while(v < regions.count){
            if(regions[v] == nome){
                return v
            }
            v = v + 1
        }
        return 0
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationArray = locations as NSArray
        let locationObj = locationArray.lastObject as! CLLocation
        let coord = locationObj.coordinate
        print(coord)
        self.userCoord = coord;
        self.locationManager.stopUpdatingLocation()
        
        self.mapa.setCenterCoordinate(coord, animated: true)
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {

        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.fillColor = UIColor.blueColor().colorWithAlphaComponent(0.1)
        circleRenderer.strokeColor = UIColor.blueColor()
        circleRenderer.lineWidth = 1
        return circleRenderer
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "verDetalhes"){
            if let dvc = segue.destinationViewController as? TelaGraficosViewController {
                if let info = sender as? [String: String] {
                    dvc.bairroCidadeV = info["bairroCidadeV"]
                    dvc.ultimosCasosV = info["ultimosCasosV"]
                    dvc.ultimosAnosV = info["ultimosAnosV"]
                    dvc.casoPorKMV = info["casoPorKMV"]
                }
            }
        }
    }
    
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let heatImage = LFHeatMap.heatMapForMapView(mapView, boost: 1, locations: locations, weights: weights)
        self.heatView.image = heatImage;
    }
    
    func mapView(mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        self.heatView.image = nil
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}