//
//  AutoQueryViewController.swift
//  AutoQueryViewer
//
//  Created by Demis Bellot on 2/15/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import UIKit

struct ViewerStyles {
    static let maxFieldWidth:CGFloat = 250
    
    static let cellPadding:CGFloat = 12
    
    static let rowHeaderHeight:CGFloat = 36

    static let rowBodyHeight:CGFloat = 28
    
    static let cellFontSize:CGFloat = 17
}

class AutoQueryViewController: UIViewController, UITextFieldDelegate, MDSpreadViewDataSource, MDSpreadViewDelegate {
    
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var txtSearchField: UITextField!
    @IBOutlet weak var txtSearchType: UITextField!
    @IBOutlet weak var txtSearchText: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnViewCsv: UIButton!
    
    var selectedOperation:AutoQueryOperation!
    var response:AutoQueryMetadataResponse!
    var config:AutoQueryViewerConfig {
        return response.config!
    }
    
    var txtSearchFieldPicker:TextPickerDelegate!
    var txtSearchTypePicker:TextPickerDelegate!
    
    var mdView:MDSpreadView!
    
    var offset:Int = 0
    var total:Int = 0
    var results:NSArray = NSArray()
    var opType:MetadataType!
    var resultType:MetadataType!
    var resultProperties = [MetadataPropertyType]()
    var messageColor:UIColor = UIColor.black
    var errorMessageColor = UIColor.red
    var columnWidths = [CGFloat]()
    var searchUrl:String?
    
    @IBAction func search() {
        if txtSearchField.text!.trim().count == 0 || txtSearchType.text!.trim().count == 0 || txtSearchText.text!.trim().count == 0 {
            return
        }
        
        let client = JsonServiceClient(baseUrl: config.serviceBaseUrl!)
        
        let field = createAutoQueryParam(txtSearchField.text!, txtSearchType.text!)
        if field == nil {
            return
        }
        
        searchUrl = "/json/reply/\(selectedOperation.request!)"
                + "?\(field!.urlEncode()!)=\(txtSearchText.text!.trim().urlEncode()!)"

        setMessage(nil)
        spinner.startAnimating()
        txtSearchText.resignFirstResponder()
        txtSearchText.clearsOnBeginEditing = false
        
        client.getDataAsync(searchUrl!)
            .then { (r:Data) -> Any in
                self.spinner.stopAnimating()

                let json = r.toUtf8String()!
                if let map = parseJson(json) as? NSDictionary {
                    if let offset = map.getItem("Offset") as? NSInteger {
                        self.offset = offset
                    }
                    if let total = map.getItem("Total") as? NSInteger {
                        self.total = total
                    }
                    self.updateResults(map.getItem("Results") as? NSArray ?? NSArray())
                }
                return r
            }
            .catch { e in
                self.spinner.stopAnimating()
                self.setErrorMessage(e.responseStatus.message)
                self.results = NSArray()
            }
    }
    
    @IBAction func viewCsv() {
        if searchUrl != nil {
            if let absoluteUrl = URL(string:config.serviceBaseUrl!.combinePath(searchUrl!) + "&format=csv") {
                UIApplication.shared.openURL(absoluteUrl)
            }
        }
    }
    
    func updateResults(_ results:NSArray) {
        
        calculateColumnWidths(results)
        self.results = results
        
        switch results.count {
        case 0:
            setMessage("this search returned no results")
            mdView.isHidden = true
            btnViewCsv.isHidden = true
        case 1:
            mdView.isHidden = false
            mdView.reloadData()
            setMessage("showing 1 result:")
        default:
            mdView.isHidden = false
            mdView.reloadData()
            if results.count == total {
                setMessage("showing \(results.count) results:")
            }
            else {
                setMessage("showing \(offset+1) - \(offset+results.count) of \(total) results:")
            }
            saveDefaultSetting("searchText", value: txtSearchText.text!)
        }
    }
    
    func calculateColumnWidths(_ results:NSArray) {
        columnWidths = resultProperties.map {
            ($0.name! as NSString).size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: ViewerStyles.cellFontSize)]).width
        }
        for row in 0 ..< results.count {
            if let result = results[row] as? NSDictionary {
                for column in 0 ..< resultProperties.count {
                    let property = resultProperties[column]
                    if let value:Any = result.getItem(property.name!) {
                        let string = "\(value)"
                        let font = UIFont.systemFont(ofSize: ViewerStyles.cellFontSize)
                        let stringSize = (string as NSString).size(attributes: [NSFontAttributeName: font])
                        
                        let columnWidth = columnWidths[column]
                        if stringSize.width > columnWidth {
                            columnWidths[column] = stringSize.width
                        }
                    }
                }
            }
        }
    }
    
    func setMessage(_ message:String?) {
        let hasMessage = (message ?? "").characters.count > 0
        
        lblMessage.textColor = messageColor
        lblMessage.text = hasMessage
            ? (opType.getViewerAttrProperty("Title")?.value ?? opType.name!) + " - " + message!
            : message
        
        btnViewCsv.isHidden = !hasMessage
    }
    
    func setErrorMessage(_ message:String?) {
        lblMessage.textColor = errorMessageColor
        lblMessage.text = message
    }
    
    func createAutoQueryParam(_ field:String, _ operand:String) -> String? {
        if let template = response.getQueryTypeTemplate(operand) {
            let mergedField = template.replace("%", withString:field)
            return mergedField
        }
        return nil
    }

    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        if textField == txtSearchText {
            search()
            return true
        }
        return false
    }
    
    func textFieldShouldBeginEditing(_ textField:UITextField) -> Bool {
        return textField == txtSearchText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.stopAnimating()
        txtSearchText.delegate = self
        
        mdView = MDSpreadView(frame: CGRect(x: 0, y: 80, width: self.view.frame.width, height: self.view.frame.height - 80))
        mdView.backgroundColor = UIColor.clear
        mdView.dataSource = self
        mdView.delegate = self
        mdView.isHidden = true
        self.view.addSubview(mdView)
        
        opType = response.getType(selectedOperation.request)!
        resultType = response.getType(selectedOperation.to)!
        resultProperties = response.getProperties(resultType.name)
        loadStyle()
        
        let from = response.getType(selectedOperation.from)
        let fromFields = response.getProperties(from?.name).map { $0.name ?? "" }

        txtSearchFieldPicker = TextPickerDelegate(textField:txtSearchField, options:fromFields)
        txtSearchFieldPicker.onSelected = { self.txtSearchType.becomeFirstResponder() }
        txtSearchField.inputView = txtSearchFieldPicker.pickerFields

        let conventionNames = response.config?.implicitConventions.map { $0.name ?? "" } ?? [String]()
        txtSearchTypePicker = TextPickerDelegate(textField:txtSearchType, options:conventionNames)
        txtSearchTypePicker.onSelected = { self.txtSearchText.becomeFirstResponder() }
        txtSearchType.inputView = txtSearchTypePicker.pickerFields

        txtSearchField.text = opType.getViewerAttrProperty("DefaultSearchField")?.value
        txtSearchType.text = opType.getViewerAttrProperty("DefaultSearchType")?.value
        txtSearchText.text = opType.getViewerAttrProperty("DefaultSearchText")?.value ?? getDefaultSetting("searchText")
        
        search()

        txtSearchText.clearsOnBeginEditing = true
    }
    
    func loadStyle() {
        if let bgColor = opType.getViewerAttrProperty("BackgroundColor")?.value ?? config.backgroundColor {
            view.backgroundColor = UIColor(rgba: bgColor)
        }
        if let textColor = opType.getViewerAttrProperty("TextColor")?.value ?? config.textColor {
            messageColor = UIColor(rgba: textColor)
            spinner.color = messageColor
        }
        if let linkColor = opType.getViewerAttrProperty("LinkColor")?.value ?? config.linkColor {
            btnBack.setTitleColor(UIColor(rgba: linkColor), for: UIControlState())
            btnSearch.setTitleColor(UIColor(rgba: linkColor), for: UIControlState())
            btnViewCsv.setTitleColor(UIColor(rgba: linkColor), for: UIControlState())
        }
        if var brandImageUrl = opType.getViewerAttrProperty("BrandImageUrl")?.value ?? config.brandImageUrl {
            if brandImageUrl.hasPrefix("/") {
                brandImageUrl = config.serviceBaseUrl!.combinePath(brandImageUrl)
            }
            self.addBrandImage(brandImageUrl, action: #selector(AutoQueryViewController.btnBrandGo(_:)))
        }
        
        if var backgroundImageUrl = opType.getViewerAttrProperty("BackgroundImageUrl")?.value ?? config.backgroundImageUrl {
            if backgroundImageUrl.hasPrefix("/") {
                backgroundImageUrl = config.serviceBaseUrl!.combinePath(backgroundImageUrl)
            }
            self.imgBackground.loadAsync(backgroundImageUrl, defaultImage:"bg-alpha")
        }
        else {
            self.imgBackground.image = self.appData.imageCache["bg-alpha"]
        }
    }
    
    func btnBrandGo(_ sender:UIButton!) {
        let brandUrl = opType.getViewerAttrProperty("brandUrl")?.value ?? config.brandUrl
        if brandUrl != nil {
            if let nsUrl = URL(string: brandUrl!) {
                UIApplication.shared.openURL(nsUrl)
            }
        }
    }
    
    @IBAction func unwindSegue(_ unwindSegue: UIStoryboardSegue) {
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    /* MDSpreadView */
    func numberOfRowSections(in aSpreadView:MDSpreadView) -> NSInteger
    {
        return 1
    }
    
    func numberOfColumnSections(in aSpreadView:MDSpreadView) -> NSInteger
    {
        return 1
    }
    
    func spreadView(_ aSpreadView:MDSpreadView, numberOfRowsInSection:NSInteger) -> NSInteger
    {
        return results.count
    }
    
    func spreadView(_ aSpreadView:MDSpreadView, numberOfColumnsInSection:NSInteger) -> NSInteger
    {
        return resultProperties.count
    }
    
    func spreadView(_ aSpreadView:MDSpreadView, objectValueForRowAt rowPath:MDIndexPath, forColumnAt columnPath:MDIndexPath) -> Any
    {
        if let result = results[rowPath.row] as? NSDictionary {
            let property = resultProperties[columnPath.column]
            if let value = result.getItem(property.name!) {
                
                if let str = value as? String {
                    if str.hasPrefix("/Date(") {
                        if let date = Date.fromString(str) {
                            return date.dateAndTimeString
                        }
                    }
                }
                if let array = value as? NSArray {
                    let str = array.componentsJoined(by: ", ")
                    return str as AnyObject
                }
                if let map = value as? NSDictionary {
                    var jsonData: Data?
                    do {
                        jsonData = try JSONSerialization.data(withJSONObject: map, options: [])
                    } catch {}
                    var json = jsonData?.toUtf8String()
                    json = json?.replace("\"", withString: "").replace("{", withString: "").replace("}", withString: "")
                    return json ?? ""
                }
                
                return value
            }
        }
        
        return "" as AnyObject
    }
    
    func spreadView(_ aSpreadView:MDSpreadView, titleForHeaderInColumnSection section:NSInteger, forRowAt rowPath:MDIndexPath)  -> Any
    {
        return "\(rowPath.row + 1)" as AnyObject
    }
    
    func spreadView( _ aSpreadView:MDSpreadView, titleForHeaderInRowSection section:NSInteger, forColumnAt columnPath:MDIndexPath) -> Any
    {
        let property = resultProperties[columnPath.column]
        return property.name as AnyObject? ?? "" as AnyObject
    }
    
    func spreadView(_ aSpreadView:MDSpreadView, titleForHeaderInRowSection rowSection:NSInteger, forColumnSection columnSection:NSInteger) -> Any
    {
        return "" as AnyObject
    }
    
    /* Display Customization */
    func spreadView(_ aSpreadView:MDSpreadView, heightForRowHeaderInSection rowSection:NSInteger) -> CGFloat
    {
        return ViewerStyles.rowHeaderHeight
    }
    
    func spreadView(_ aSpreadView:MDSpreadView, heightForRowAt indexPath:MDIndexPath) -> CGFloat
    {
        return ViewerStyles.rowBodyHeight
    }
    
    func spreadView(_ aSpreadView:MDSpreadView, heightForRowFooterInSection rowSection:NSInteger) -> CGFloat
    {
        return 0
    }
    
    func spreadView(_ aSpreadView:MDSpreadView, widthForColumnHeaderInSection columnSection:NSInteger) -> CGFloat
    {
        return 50
    }
    
    func spreadView(_ aSpreadView:MDSpreadView, widthForColumnAt indexPath:MDIndexPath) -> CGFloat
    {
        if columnWidths.count == 0 {
            return ViewerStyles.maxFieldWidth
        }
        let columnWidth = columnWidths[indexPath.column] + (ViewerStyles.cellPadding * 2)
        return columnWidth < ViewerStyles.maxFieldWidth ? columnWidth : ViewerStyles.maxFieldWidth
    }
    
    func spreadView(_ aSpreadView:MDSpreadView, widthForColumnFooterInSection columnSection:NSInteger) -> CGFloat
    {
        return 0
    }
}

class TextPickerDelegate : NSObject, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var options:[String]
    var textField:UITextField
    var pickerFields:UIPickerView
    var onSelected:(() -> Any)?
    
    init(textField:UITextField, options:[String]) {
        self.textField = textField
        self.options = options
        pickerFields = UIPickerView()

        super.init()
        
        textField.text = options.first ?? ""
        textField.delegate = self
        pickerFields.delegate = self
        pickerFields.dataSource = self
    }
    
    func textFieldShouldEndEditing(_ textField:UITextField) -> Bool {
        return options.filter { $0 == textField.text }.count > 0 || textField.text == ""
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = options[row]
        textField.resignFirstResponder()
        
        if let fn = onSelected {
            fn()
        }
    }
}
