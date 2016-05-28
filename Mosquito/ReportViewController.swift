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

class ReportViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    
    @IBOutlet weak var mapaRep: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        mapaRep.delegate = self
        let startCoord = CLLocationCoordinate2DMake(-8.0524415,-34.92565148689435);
        let adjustedRegion = mapaRep.regionThatFits(MKCoordinateRegionMakeWithDistance(startCoord, 3000, 3000))
        mapaRep.setRegion(adjustedRegion, animated: true)
    }

    
    }
    
    

}