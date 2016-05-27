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

class mapaAgoraViewController: UIViewController, MKMapViewDelegate {
    
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
    
    override func viewDidLoad() {
 
        super.viewDidLoad()
        mapa.delegate = self
        let startCoord = CLLocationCoordinate2DMake(-8.0526143,-34.8801386);
        let adjustedRegion = mapa.regionThatFits(MKCoordinateRegionMakeWithDistance(startCoord, 1000, 1000))
        mapa.setRegion(adjustedRegion, animated: true)
        mapa.addAnnotation(Lugar(title:"Jump Brasil", subtitle: "Aceleradora", coordinate:startCoord))
        
        let cac = MKPointAnnotation()
        cac.title = "CAC"
        cac.subtitle = "UFPE"
        cac.coordinate = CLLocationCoordinate2DMake(-8.050594, -34.953424)
        mapa.addAnnotation(cac)
        
        
       
    }
    
    
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}