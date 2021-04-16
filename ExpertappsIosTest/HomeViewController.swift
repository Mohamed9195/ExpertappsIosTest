//
//  ViewController.swift
//  ExpertappsIosTest
//
//  Created by mohamed hashem on 15/04/2021.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {

    @IBOutlet weak var expertTableView: UITableView!

    private var startTableCellAnimation = true
    private var viewModel = HomePostViewModel()
    private var currentProductIs: CurrentProductModel?
    private let disposed = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.homeDelegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel.getProductByDelegation()
        //viewModel.getProductByReactiveX()
        //observingViewModelProperty()

        expertTableView.reloadData()
    }

    private func observingViewModelProperty() {
        viewModel.homeIsLoading
            .asObserver()
            .subscribe { [weak self] result in
                guard let self = self else { return }

                self.startTableCellAnimation = result
                self.expertTableView.reloadData()

            } onError: { error in
                print(error.localizedDescription)
            }.disposed(by: disposed)

        viewModel.product
            .asObserver()
            .subscribe { [weak self] product in
                guard let self = self else { return }

                self.currentProductIs = product
                self.expertTableView.reloadData()

            } onError: { error in
                print(error.localizedDescription)
            }.disposed(by: disposed)
    }
}

//MARK:- viewModel Delegation
extension HomeViewController: HomeViewModelOutput {
    func present(homeIsLoading: Bool) {
        startTableCellAnimation = homeIsLoading
        expertTableView.reloadData()
    }

    func present(error: Error) {
        PopUpAlert.init(title: "Error",
                        message: error.localizedDescription,
                        type: .alert)
            .addCancelAction()
            .show(in: self)
    }

    func present(product: CurrentProductModel) {
        currentProductIs = product
        expertTableView.reloadData()
    }

    func present(productCached: Bool) {
        PKHUDIndicator.hidProgressView()
    }
}

//MARK:- table View
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if startTableCellAnimation {
            return 4
        } else {
            return currentProductIs?.product != nil ? currentProductIs!.product.count : 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch startTableCellAnimation {
        case true:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SkeltonCell") as? SkeltonTableViewCell else {
                fatalError("no cell kitchenTableViewCell")
            }
            return cell

        case false:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "kitchenTableCell") as? kitchenTableViewCell else {
                fatalError("no cell kitchenTableViewCell")
            }

            if let product = currentProductIs?.product[indexPath.row] {
                cell.productName.text = product.productName
            }
            
            cell.addCartClosure = { [weak self] in
                guard let self = self else { return }

                PKHUDIndicator.showProgressView()
                if let newProduct = self.currentProductIs?.product[indexPath.row] {
                    self.viewModel.cacheProduct(product: newProduct)
                }
                PopUpAlert.showSuccessToastWith(message: "your Product has added")
            }

            return cell
        }
    }
}
