

import UIKit
import SnapKit
import Alamofire


class HomeView: UIView {

    var bags = [BagCatalog]()
    var arrayToDisplay: [BagCatalog] = []
    var carouselArray = ["bags1", "bags2"]
    var isLoading = false

    
    let menuButton: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(named: "button"), for: .normal)
        return b
    }()
    
    let titleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        l.text = "bagzz"
        return l
    }()
    
    let photoImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "photo")
        return iv
    }()

    lazy var carouselCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let cellWidth = 351
        let cellHeight = 195
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)

        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10

        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    
    let leftButton: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(named: "arrowLeft"), for: .normal)
        b.backgroundColor = .black
        b.addTarget(self, action: #selector(leftAction), for: .touchUpInside)
        return b
    }()
    
    let rightButton: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(named: "arrowRight"), for: .normal)
        b.addTarget(self, action: #selector(rightAction), for: .touchUpInside)
        b.backgroundColor = .black
        return b
    }()
    
    lazy var catalogCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let cellWidth = 170
        let cellHeight = 210
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)

        layout.minimumInteritemSpacing = 13
        layout.minimumLineSpacing = 24

        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    

    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
        addSubview(menuButton)
        addSubview(titleLabel)
        addSubview(photoImage)
        addSubview(carouselCollectionView)
        addSubview(leftButton)
        addSubview(rightButton)
        addSubview(catalogCollectionView)

        elementConstraints()
        
        carouselCollectionView.delegate = self
        carouselCollectionView.dataSource = self
        
        catalogCollectionView.delegate = self
        catalogCollectionView.dataSource = self
        
        carouselCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        catalogCollectionView.register(CollectionViewCell2.self, forCellWithReuseIdentifier: "cell2")
        
        carouselCollectionView.backgroundColor = .white
        catalogCollectionView.backgroundColor = .white
        
        fetchData()

    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

  
    func elementConstraints() {
        menuButton.snp.makeConstraints { (m) in
            m.top.equalTo(safeAreaLayoutGuide.snp.top).inset(19)
            m.left.equalToSuperview().inset(12)
            m.height.equalTo(14)
            m.width.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { (m) in
            m.top.equalTo(safeAreaLayoutGuide.snp.top).inset(9)
            m.left.equalTo(menuButton.snp.right).inset(-18)
            m.height.equalTo(29)
        }
        
        photoImage.snp.makeConstraints { (m) in
            m.top.equalTo(safeAreaLayoutGuide.snp.top).inset(10)
            m.right.equalToSuperview().inset(12)
            m.height.width.equalTo(32)
            m.bottom.equalTo(carouselCollectionView.snp.top).inset(-24)
        }
        
        carouselCollectionView.snp.makeConstraints { (m) in
            m.centerX.equalToSuperview()
            m.width.equalTo(351)
            m.height.equalTo(195)
        }
        
        leftButton.snp.makeConstraints { (m) in
            m.top.equalTo(safeAreaLayoutGuide.snp.top).inset(220)
            m.left.equalToSuperview().inset(250)
            m.height.width.equalTo(51)
        }
        
        rightButton.snp.makeConstraints { (m) in
            m.top.equalTo(safeAreaLayoutGuide.snp.top).inset(220)
            m.left.equalToSuperview().inset(302)
            m.height.width.equalTo(51)
        }
        
        catalogCollectionView.snp.makeConstraints { (m) in
            m.top.equalTo(carouselCollectionView.snp.bottom).inset(-40)
            m.centerX.equalToSuperview()
            m.width.equalTo(354)
            m.bottom.equalToSuperview()
        }

    }
    
    
    @objc func leftAction() {
        let visibleItems: NSArray = carouselCollectionView.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(item: currentItem.item - 1, section: 0)
        if nextItem.row < carouselArray.count && nextItem.row >= 0 {
            carouselCollectionView.scrollToItem(at: nextItem, at: .right, animated: true)
        }
    }
    
    @objc func rightAction() {
        let visibleItems: NSArray = carouselCollectionView.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(item: currentItem.item + 1, section: 0)
        if nextItem.row < carouselArray.count {
               carouselCollectionView.scrollToItem(at: nextItem, at: .left, animated: true)
        }
    }
    

    func fetchData() {

        AF.request("https://jsonplaceholder.typicode.com/photos", method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                for item in value as! [[String: AnyObject]] {
                    let bagsData = BagCatalog(title: item["title"] as! String, thumbnailUrl: item["thumbnailUrl"] as! String)
                    self.bags.append(bagsData)
                }
            case .failure(_):
                print("error")
            }
            self.arrayToDisplay = Array(self.bags[0..<20])
            self.catalogCollectionView.reloadData()
        }
    }
    
}



extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == carouselCollectionView {
            return carouselArray.count
        }

//        return  bags.count
        return arrayToDisplay.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == catalogCollectionView {
            let cell2 = catalogCollectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! CollectionViewCell2
            
            cell2.backgroundColor = UIColor(named: "color")
            
//            cell2.image.downloaded(from: bags[indexPath.item].thumbnailUrl)
//            cell2.titleLabel.text = bags[indexPath.item].title
            cell2.image.downloaded(from: arrayToDisplay[indexPath.item].thumbnailUrl)
            cell2.titleLabel.text = arrayToDisplay[indexPath.item].title
       
            return cell2
        }
        
        let cell = carouselCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.image.image = UIImage(named: carouselArray[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        if indexPath.row == arrayToDisplay.count - 2 && !self.isLoading {
        
            if !self.isLoading {
                self.isLoading = true
                let start = arrayToDisplay.count
                let end = start + 20
                DispatchQueue.global().async {
                    for i in start...end {
                            self.arrayToDisplay.append(self.bags[i])
                    }
                    DispatchQueue.main.async {
                        self.catalogCollectionView.reloadData()
                        self.isLoading = false
                    }
                }
            }
        }
    }
    

}


