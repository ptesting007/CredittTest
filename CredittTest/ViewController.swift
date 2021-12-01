//
//  ViewController.swift
//  CredittTest
//
//  Created by Piyush Kaklotar on 01/12/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblLanguage: UITableView!
    var objLanguage : LanguageModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let path = UIBezierPath(roundedRect:tblLanguage.bounds, byRoundingCorners:[.topLeft, .topRight], cornerRadii: CGSize(width: 30, height: 30))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        tblLanguage.layer.mask = maskLayer
        callAPI_GetLanguage()
    }
    
    //MARK: - UITableView Data Source and Delegate Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (objLanguage != nil && objLanguage.data != nil) {
            return objLanguage.data.count
        }
        else {
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : LanguageCell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath) as! LanguageCell

        cell.selectionStyle = .none
        let objLang : Languages = self.objLanguage.data[indexPath.row]
        cell.imgShortName.image = UIImage.init(named: objLang.shortName)
        cell.lblLanguageName.text = objLang.languageName
        if (objLang.isSelected) {
            cell.imgSelection.image = UIImage.init(named: "check")
        }
        else {
            cell.imgSelection.image = UIImage.init(named: "uncheck")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.objLanguage.data[indexPath.row].isSelected = !self.objLanguage.data[indexPath.row].isSelected
        self.tblLanguage.reloadData()
    }
    
    // MARK: - API call
    func callAPI_GetLanguage() {
        CommonMethod.callAPI(url: SER_LANGUAGE, parameter: nil, loaderString: "", httpMethod: .get) { (resp,result,isSuccess,error) in
            
            if isSuccess {
                if resp?.statusCode == 200
                {
                    if let res_Dict : [String : AnyObject] = result as? Dictionary {
                        let isRespSucess : Bool = (res_Dict["success"] != nil)
                        if isRespSucess {
                            self.objLanguage = LanguageModel.init(fromDictionary: res_Dict)
                            self.tblLanguage.reloadData()
                        }
                    }
                    
                } else if resp?.statusCode == 204 {
                }
            }
            else {
                self.handleError(errorResponse: resp!, response: result as! [String : Any])
            }
        }
    }
}



class LanguageCell : UITableViewCell {
    @IBOutlet var imgShortName: UIImageView!
    @IBOutlet var lblLanguageName: UILabel!
    @IBOutlet var imgSelection: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
