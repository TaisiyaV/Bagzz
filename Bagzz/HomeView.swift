

import UIKit
import SnapKit


class HomeView: UIView {

    var carouselArray = ["bags1", "bags2"]
//    var catalogArray = ["image1", "image2", "image3", "image4"]
    
    
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

    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func elementConstraints() {
        menuButton.snp.makeConstraints { (m) in
            m.top.equalToSuperview().inset(63.0)
            m.left.equalToSuperview().inset(12.0)
            m.height.equalTo(14.0)
            m.width.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { (m) in
            m.top.equalToSuperview().inset(53.0)
            m.left.equalTo(menuButton.snp.right).inset(-18.0)
            m.height.equalTo(29.0)
        }
        
        photoImage.snp.makeConstraints { (m) in
            m.top.equalToSuperview().inset(54.0)
            m.right.equalToSuperview().inset(12.0)
            m.height.width.equalTo(32.0)
        }
        
        carouselCollectionView.snp.makeConstraints { (m) in
            m.top.equalToSuperview().inset(110.0)
            m.left.right.equalToSuperview().inset(12.0)
            m.width.equalTo(351.0)
            m.height.equalTo(195.0)
        }
        
        leftButton.snp.makeConstraints { (m) in
            m.top.equalToSuperview().inset(264.0)
            m.left.equalToSuperview().inset(249.5)
            m.height.width.equalTo(51.0)
        }
        
        rightButton.snp.makeConstraints { (m) in
            m.top.equalToSuperview().inset(264.0)
            m.right.equalToSuperview().inset(22.0)
            m.height.width.equalTo(51.0)
        }
        leftButton.snp.makeConstraints { (m) in
            m.top.equalToSuperview().inset(264.0)
            m.left.equalToSuperview().inset(249.5)
            m.height.width.equalTo(51.0)
        }
        
        catalogCollectionView.snp.makeConstraints { (m) in
            m.top.equalToSuperview().inset(345.0)
            m.left.right.equalToSuperview().inset(12.0)
            m.width.equalToSuperview().inset(11.0)
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
    
}

extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == carouselCollectionView {
            return carouselArray.count
        }

//        return  ViewController().bags.count
        return 10

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == catalogCollectionView {
            let cell2 = catalogCollectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! CollectionViewCell2
            
            cell2.backgroundColor = UIColor(named: "color")
            
//            cell2.image.image = UIImage(named: catalogArray[indexPath.item])
//            cell2.titleLabel.text = ViewController().bags[indexPath.item].title
       
            return cell2
        }
        
        let cell = carouselCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.image.image = UIImage(named: carouselArray[indexPath.item])
        
        return cell
    }

}



