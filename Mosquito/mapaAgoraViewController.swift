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
        
        regions = ["CIDADE UNIVERSITARIA","SOLEDADE","ENGENHO DO MEIO","CACOTE","COHAB","VARZEA","TORROES","IPUTINGA","CURADO","SAN MARTIN","IPSEP","PASSARINHO","DOIS IRMAOS","JAQUEIRA","JARDIM SAO PAULO","AREIAS","SANCHO","BARRO","ESTANCIA","SANTANA","TEJIPIO","ZUMBI","CORDEIRO","COQUEIRAL","TOTO","CAXANGA","SITIO DOS PINTOS","PAU FERRO","DERBY","FUNDAO","ROSARINHO","CAMPINA DO BARRETO","PORTO DA MADEIRA","CAJUEIRO","BEBERIBE","BOMBA DO HEMETERIO","MANGABEIRA","DOIS UNIDOS","LINHA DO TIRO","TORREAO","TAMARINEIRA","MANGUEIRA","ILHA DO LEITE","JORDAO","SANTO AMARO","POCO","CASA FORTE","PARNAMIRIM","PEIXINHOS","ARRUDA","BOA VISTA","PRADO","CABANGA","PINA","BREJO DA GUABIRABA","ILHA DO RETIRO","PAISSANDU","ILHA JOANA BEZERRA","IBURA","ALTO JOSE BONIFACIO","ALTO DO MANDU","MORRO DA CONCEICAO","CASA AMARELA","PONTO DE PARADA","ENCRUZILHADA","ESPINHEIRO","AFLITOS","SANTO ANTONIO","RECIFE","BRASILIA TEIMOSA","VASCO DA GAMA","BONGI","BOA VIAGEM","MUSTARDINHA","SAO JOSE","ALTO JOSE DO PINHO","ALTO SANTA TEREZINHA","MACAXEIRA","BREJO DE BEBERIBE","NOVA DESCOBERTA","MONTEIRO","CAMPO GRANDE","TORRE","MADALENA","AGUA FRIA","COELHOS","HIPODROMO","GRACAS","IMBIRIBEIRA","JIQUIA","AFOGADOS","APIPUCOS","GUABIRABA","CORREGO DO JENIPAPO"]
        latitudes = [-8.05297136895392,-8.05661100717756,-8.056615855613627,-8.100337867005571,-8.124068026387661,-8.045978278922082,-8.060743530957094,-8.0358712573466,-8.071202073060295,-8.069084290955912,-8.109788961335802,-7.9767888776081595,-8.007822272842018,-8.037959158815195,-8.082184206140077,-8.094726088469882,-8.084762485103827,-8.099196007498435,-8.08518431994301,-8.040246016811743,-8.090190525234323,-8.05277393133287,-8.05083704818886,-8.088348073613403,-8.082738463854739,-8.02802932297753,-8.012544599314797,-7.967969166049729,-8.057198570479951,-8.013834426943681,-8.032509562709748,-8.016726432585664,-8.00737303851091,-8.01123861536905,-8.005719487931184,-8.021105528379731,-8.023792833019689,-7.997318623689262,-8.00889918938054,-8.04014088907979,-8.031522796100607,-8.07638811838089,-8.065437585708125,-8.136257636988685,-8.048037738045155,-8.035338515876361,-8.033753436363465,-8.033864004875646,-8.019505524423229,-8.023903253199705,-8.055803625674512,-8.060746497307289,-8.079945924111435,-8.095194058127003,-7.9927902910168775,-8.064529775490305,-8.063367745858367,-8.070685897578002,-8.118373211397653,-8.013219829610374,-8.021896393797725,-8.02011627988466,-8.026045742975402,-8.02964214388825,-8.03506224296929,-8.044330230333175,-8.040325763425308,-8.062963377201886,-8.052586636715679,-8.079392335554516,-8.011941470640057,-8.06565249290254,-8.127051123028771,-8.071403272318456,-8.07311016294727,-8.0220488170614,-8.015611861687855,-8.011944637260104,-7.997968555089615,-8.007450526814814,-8.026619246416267,-8.030123754267311,-8.042907579014546,-8.054405997857796,-8.015801232488803,-8.067483517394534,-8.032009895908523,-8.044812321664672,-8.107392972997655,-8.084974750090993,-8.076409274097768,-8.01680919455335,-7.964488553063459,-8.00229837735142]
        longitudes = [-34.95085731364932,-34.88961534393413,-34.94232521858363,-34.93133939674564,-34.953359751397436,-34.980196575346795,-34.93726596903592,-34.93556985309474,-34.96050508749455,-34.930389753837346,-34.921889046966086,-34.92203318036806,-34.950216676372726,-34.90590482129392,-34.944216156860435,-34.93117359307939,-34.96170343870214,-34.94968853209684,-34.93020330653343,-34.91503196461137,-34.95612965800896,-34.91777215200857,-34.92842851338767,-34.96860409104535,-34.968605921847775,-34.95589110106769,-34.95719520349019,-34.981438262134134,-34.90019917040313,-34.8906324155605,-34.89732409972106,-34.88238791362066,-34.889679377558025,-34.88492311021673,-34.896178620268614,-34.90251465272512,-34.90284712251971,-34.91116713013445,-34.90546227057751,-34.882774152488125,-34.901781021770994,-34.920545452371925,-34.89361811657493,-34.93259802873345,-34.87944992984574,-34.922738029747265,-34.918813051603905,-34.91112741284259,-34.876557281437826,-34.88942750702171,-34.88885544256944,-34.91735893654314,-34.89499301450539,-34.893625956328634,-34.93289769467729,-34.90490071723546,-34.89748021953304,-34.89744352494539,-34.932299538520496,-34.91326943327796,-34.928534909501685,-34.9143676999618,-34.916353803451265,-34.89235360297881,-34.8906938767869,-34.890783027486236,-34.89590659128545,-34.87993622159556,-34.8670341468479,-34.87753522935317,-34.918834919080886,-34.91798914480958,-34.90030941731433,-34.9191983810894,-34.88807626020228,-34.907550252254914,-34.90787676128838,-34.930530557746536,-34.920474445252935,-34.92904932296698,-34.928870587835405,-34.88029687694558,-34.91054230526017,-34.90847165929574,-34.89520138262746,-34.889416859481756,-34.88754085256947,-34.899379003214705,-34.91209270629225,-34.92565148689435,-34.91306961223532,-34.9362840299031,-34.95978027762468,-34.936372649890814]
        areas = [0.00021156062696126254,0.00005398361295500456,0.00011415310567814763,0.00006301349910462546,0.0006244551691371062,0.004044823193695565,0.000250391234754551,0.0005547687535080075,0.001469918107568921,0.0003045830192449138,0.0002279626672124553,0.0010202657719860309,0.0007923386729577212,0.00007117784266425916,0.00031336601964351444,0.0004532148385689086,0.00007054724343520303,0.0007004910781383194,0.00015093887270519295,0.00006236876057558459,0.00022378921714898587,0.00006657574062864235,0.0005584906079050878,0.00012994696487175734,0.000025716523725734204,0.0004716253135545577,0.00023379393479943216,0.0003677638155413289,0.00007548019788216496,0.00011070267021899957,0.000051340755883342416,0.00007410496772143511,0.00007291809493000744,0.00008467704215720018,0.00007520740077443934,0.0000877523128024469,0.00004135864150378694,0.000507932216101235,0.0001486057950409559,0.000039375861789800364,0.00014883449527517968,0.00004472424445309715,0.00003923040688228978,0.0004120203603806302,0.0005062269911742231,0.00013028924592308578,0.00008228538599873576,0.00008569069497047777,0.00004416469366207281,0.00017368110138356194,0.00037164505303626444,0.00017726576099562187,0.00011400890295905026,0.0009221173812740264,0.0001071661933694158,0.00006442203443986603,0.00006100292490494195,0.00018460868058036445,0.0016810955190618888,0.00008106988535002107,0.00004308720744321616,0.000054704036337180115,0.0002706850881089531,0.000021299309791572986,0.00015972542297931763,0.00014277355552369316,0.00004680473319505244,0.00011551160870510039,0.0005946630436749002,0.0003705203843352141,0.0002449021847066287,0.00009853271701598684,0.001996269111145433,0.00007783820669846388,0.0004956024751309049,0.0000618386845091054,0.000043600207019052314,0.00016683101365598296,0.0003892085751220804,0.00039909207569751437,0.00011029251413828333,0.00039029006503097795,0.00016153684533528337,0.0002454245327934902,0.0003633188564314633,0.00006718454519007242,0.000044006704901003363,0.00019520898674170692,0.0011203570555798556,0.0003618599541596557,0.0006116262735125071,0.00028338048294058034,0.0076457478648554004,0.00009596162611494281]
        weights = [7,5,14,24,278,131,20,94,24,117,79,20,6,2,168,133,12,51,42,3,29,4,66,41,13,10,8,0,0,17,5,37,6,9,18,21,7,44,15,0,7,42,2,104,38,0,11,2,1,27,69,15,5,49,17,18,1,13,293,22,16,63,49,0,1,1,3,2,4,15,121,95,102,35,20,35,1,96,6,200,1,49,28,22,77,13,1,8,95,34,216,7,56,47];
        
       
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
        self.performSegueWithIdentifier("verDetalhes", sender: ["bairroCidadeV" : String(regions[ind]) + ",RECIFE, PE", "ultimosCasosV" : String(Int(weights[ind])), "ultimosAnosV" : String(Int(weights[ind])), "casoPorKMV" : String(Int(weights[ind]/areas[ind]))])
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