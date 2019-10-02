//
//  ShowBarViewController.swift
//  BestNYCBars
//
//  Created by Andrés Montelpare on 22/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

import UIKit
import MapKit

protocol ShowBarDisplayLogic: class {
    func displayMap(viewModel: ShowBar.ShowMap.ViewModel)
    func displayDetails(viewModel: ShowBar.ShowDetails.ViewModel)
}

class ShowBarViewController: UIViewController, ShowBarDisplayLogic {
    var interactor: ShowBarBusinessLogic?
    var router: (NSObjectProtocol & ShowBarRoutingLogic & ShowBarDataPassing)?

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
        let interactor = ShowBarInteractor()
        let presenter = ShowBarPresenter()
        let router = ShowBarRouter()
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
  
    func displayMap(viewModel: ShowBar.ShowMap.ViewModel) {
        let displayedBar = viewModel.displayedBar
        let clLocation = CLLocationCoordinate2D(latitude: displayedBar.latitude, longitude: displayedBar.longitude)

        setRegion(clLocation: clLocation)
        addAnotation(clLocation: clLocation, name: displayedBar.name)
    }
    
    // Show details
    
    @IBOutlet weak var cuisines: UILabel!
    @IBOutlet weak var timings: UILabel!
    
    func showDetails() {
        interactor?.showDetails()
    }
    
    func displayDetails(viewModel: ShowBar.ShowDetails.ViewModel) {
        cuisines.text = viewModel.displayedBar.cuisines
        timings.text = viewModel.displayedBar.timings
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
