//
//  TelaGraficos.swift
//  Mosquito
//
//  Created by Victor Leal Porto de Almeida Arruda on 27/05/16.
//  Copyright © 2016 Victor Leal Porto de Almeida Arruda. All rights reserved.
//

import Foundation
import UIKit

class TelaGraficosViewController: UIViewController {
    
    @IBOutlet weak var barraTermometro: UIView!
    
    @IBOutlet weak var bairroCidade: UILabel!
    @IBOutlet weak var ultimosCasos: UILabel!
    @IBOutlet weak var ultimosAnos: UILabel!
    @IBOutlet weak var casoPorKM: UILabel!
    
    var bairroCidadeV: String!
    var ultimosCasosV: String!
    var ultimosAnosV: String!
    var casoPorKMV: String!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.barraTermometro.alpha = 0
        UIView.animateWithDuration(1.5) {
            self.barraTermometro.alpha = 1
        }
        mudarLabels()
        
    }
    
    func mudarLabels(){
        bairroCidade.text = bairroCidadeV
        ultimosCasos.text = ultimosCasosV + " CASOS NOS ÚLTIMOS 30 DIAS"
        ultimosAnos.text = ultimosAnosV + " CASOS DESDE 2014"
        casoPorKM.text = "CERCA DE " + casoPorKMV + " CASOS POR KM²"
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}