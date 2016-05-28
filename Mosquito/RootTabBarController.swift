//
//  RootTabBarController.swift
//  Mosquito
//
//  Created by Alexandre Cisneiros on 28/05/2016.
//  Copyright © 2016 Victor Leal Porto de Almeida Arruda. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController, CLLocationManagerDelegate {
    
    var locationManager:CLLocationManager!
    var userCoord:CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()

    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationArray = locations as NSArray
        let locationObj = locationArray.lastObject as! CLLocation
        let coord = locationObj.coordinate
        print(coord)
        self.userCoord = coord;
        self.locationManager.stopUpdatingLocation()
        
        if let vc = self.childViewControllers[1] as? UINavigationController {
            if let dvc = vc.viewControllers[0] as? TelaGraficosViewController {
                let info = Information.areaData(0)
                dvc.bairroCidadeV = info["bairroCidadeV"]
                dvc.ultimosCasosV = info["ultimosCasosV"]
                dvc.ultimosAnosV = info["ultimosAnosV"]
                dvc.casoPorKMV = info["casoPorKMV"]
            }
        }
    }
}
