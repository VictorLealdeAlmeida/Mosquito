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

    
    /*class Informacoes:  NSObject {
        var bairroCidade: String?
        var ultimosCasos: String?
        var ultimosAnos: String?
        var casoPorKM: String?

        init(bairroCidade:String , ultimosCasos:String, ultimosAnos:String , casoPorKM:String) {
            self.bairroCidade = bairroCidade
            self.ultimosCasos = ultimosCasos
            self.ultimosAnos = ultimosAnos
            self.ultimosCasos = casoPorKM

        } }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.barraTermometro.alpha = 0
        UIView.animateWithDuration(1) {
            self.barraTermometro.alpha = 1
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}