
import UIKit
import Alamofire



class ViewController: UIViewController {

    var bags = [BagCatalog]()
    
    override func loadView() {
        super.loadView()
        view = HomeView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        fetchData()
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
           
            }
    }
        

}



