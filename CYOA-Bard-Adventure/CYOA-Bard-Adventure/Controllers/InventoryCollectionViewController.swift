//
import UIKit

class InventoryCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UserDecisionModel.shared.inventoryItems.count
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as? CollectionViewCell else {fatalError("Cell failed to populate.(CollectionViewController cell deque")}
//        cell.imageView?.image = images[indexPath.item]
//        return cell
//    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? InventoryCollectionViewCellController else {fatalError("Could not DQ cell.")}
        cell.inventoryItemImage.image = UserDecisionModel.shared.inventoryItems[indexPath.row].image
        cell.inventoryItemName.text = UserDecisionModel.shared.inventoryItems[indexPath.row].name
        cell.inventoryItemQuantity.text = "Quantity: \(UserDecisionModel.shared.inventoryItems[indexPath.row].quantity)"
        
    
        // Configure the cell
        return cell
    }

}
