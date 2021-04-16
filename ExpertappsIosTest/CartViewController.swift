//
//  CartViewController.swift
//  ExpertappsIosTest
//
//  Created by mohamed hashem on 16/04/2021.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var cartTableView: UITableView!

    private var currentCart: CurrentProductModel?
    private var viewModel = CartViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.cartDelegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel.getMyCart(withRemoveOldFrom: 3)
    }

    @IBAction func touchUpToDismissView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

//MARK:- viewModel Delegation
extension CartViewController: CartViewModelOutput {
    func present(error: Error) { }

    func present(cart: CurrentProductModel) {
        currentCart = cart
        cartTableView.reloadData()
    }
}

//MARK:- table View
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentCart != nil ? currentCart!.product.count : 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell")  else {
            fatalError("no cell kitchenTableViewCell")
        }

        if let product = currentCart?.product[indexPath.row] {
            cell.textLabel?.text = product.productName
            cell.detailTextLabel?.text = Date(timeIntervalSince1970: product.initDate ?? 0.0).description
        }
        
        return cell
    }
}
