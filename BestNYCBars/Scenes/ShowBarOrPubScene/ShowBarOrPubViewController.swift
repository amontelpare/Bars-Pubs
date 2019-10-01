//
//  ShowBarOrPubViewController.swift
//  Bars&Pubs
//
//  Created by Andrés Montelpare on 22/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

import UIKit
import MapKit

protocol ShowBarOrPubDisplayLogic: class {
    func displayMap(viewModel: ShowBarOrPub.ShowMap.ViewModel)
    func displayDetails(viewModel: ShowBarOrPub.ShowDetails.ViewModel)
}

class ShowBarOrPubViewController: UIViewController, ShowBarOrPubDisplayLogic {
    var interactor: ShowBarOrPubBusinessLogic?
    var router: (NSObjectProtocol & ShowBarOrPubRoutingLogic & ShowBarOrPubDataPassing)?

    // MARK: Object lifecycle
  
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
  
    // MARK: Setup
  
    private func setup() {
        let viewController = self
        let interactor = ShowBarOrPubInteractor()
        let presenter = ShowBarOrPubPresenter()
        let router = ShowBarOrPubRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
  
    // MARK: Routing
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
  
    // MARK: View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        showMap()
        showDetails()
    }
  
    // MARK: Show map
  
    @IBOutlet weak var mapView: MKMapView!
  
    func showMap() {
        interactor?.showMap()
    }
  
    func displayMap(viewModel: ShowBarOrPub.ShowMap.ViewModel) {
        let displayedBarOrPub = viewModel.displayedBarOrPub
        let clLocation = CLLocationCoordinate2D(latitude: displayedBarOrPub.latitude, longitude: displayedBarOrPub.longitude)

        setRegion(clLocation: clLocation)
        addAnotation(clLocation: clLocation, name: displayedBarOrPub.name)
    }
    
    // Show details
    
    @IBOutlet weak var cuisines: UILabel!
    @IBOutlet weak var timings: UILabel!
    
    func showDetails() {
        interactor?.showDetails()
    }
    
    func displayDetails(viewModel: ShowBarOrPub.ShowDetails.ViewModel) {
        cuisines.text = viewModel.displayedBarOrPub.cuisines
        timings.text = viewModel.displayedBarOrPub.timings
    }
    
    // MARK: Private methods
    
    private func setRegion(clLocation: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: clLocation, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    private func addAnotation(clLocation: CLLocationCoordinate2D, name: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = clLocation
        annotation.title = name
        mapView.addAnnotation(annotation)
    }
}
