//
//  ReportViewController.swift
//  Mosquito
//
//  Created by Victor Leal Porto de Almeida Arruda on 28/05/16.
//  Copyright © 2016 Victor Leal Porto de Almeida Arruda. All rights reserved.
//

import Foundation
import Foundation
import UIKit

class ReportViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var mapaRep: MKMapView!
    var mapTapRecognizer: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapaRep.delegate = self
        let startCoord = CLLocationCoordinate2DMake(-8.0524415,-34.92565148689435);
        let adjustedRegion = mapaRep.regionThatFits(MKCoordinateRegionMakeWithDistance(startCoord, 3000, 3000))
        mapaRep.setRegion(adjustedRegion, animated: true)
        
        mapTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(userTappedMap))
        mapaRep.addGestureRecognizer(mapTapRecognizer)
    }

    func novoPonto(){
        
    }
    
    @IBAction func userTappedMap(sender: UITapGestureRecognizer) {
        let touchLocation = sender.locationInView(mapaRep)
        let locationCoordinate = mapaRep.convertPoint(touchLocation, toCoordinateFromView: mapaRep)
        print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
        
        let startCoord = CLLocationCoordinate2DMake(locationCoordinate.latitude,locationCoordinate.longitude);
        let adjustedRegion = mapaRep.regionThatFits(MKCoordinateRegionMakeWithDistance(startCoord, 1000, 1000))
        mapaRep.setRegion(adjustedRegion, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = startCoord
        mapaRep.addAnnotation(annotation)
        

            
        let alert = UIAlertController(title: "Confirma denuncia no local?", message: "Seu relato é fundamental", preferredStyle: .Alert)
        self.presentViewController(alert, animated: true, completion: nil)
        let action = UIAlertAction(title: "Confirmar", style: UIAlertActionStyle.Default, handler: nil)
        
        alert.addAction(action)
         annotation.title = "Denuncia registrada"
    }
}

    

