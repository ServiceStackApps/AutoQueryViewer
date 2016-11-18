//
//  AutoQueryServiceViewController.swift
//  AutoQueryViewer
//
//  Created by Demis Bellot on 2/17/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import UIKit


class AutoQueryServiceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var lblError: UILabel!
    
    var service:AutoQueryService?
    var response:AutoQueryMetadataResponse?
    var operations = [AutoQueryOperation]()

    var selectedOperation:AutoQueryOperation?

    override func viewDidLoad() {
        NSLog("viewDidLoad")
        if let r = response {
            self.loadAutoQueryMetadataResponse(r)
        }
        else if service != nil {
            
            self.loadConfig(service!.toAutoQueryViewerConfig())
            
            let client = JsonServiceClient(baseUrl: service!.serviceBaseUrl!)
            client.getAsync(AutoQueryMetadata())
                .then { r  -> AnyObject in
                    self.loadAutoQueryMetadataResponse(r)
                    return r
                }
                .catch { e in
                    self.spinner.stopAnimating()
                    self.lblError.text = "host is unavailable"
                }
        }
    }
    
    func loadAutoQueryMetadataResponse(_ response:AutoQueryMetadataResponse) {
        self.tblView.isHidden = false
        self.spinner.stopAnimating()

        self.loadConfig(response.config!)

        self.response = response
        self.operations = response.operations
        self.tblView.reloadData()
    }
    
    func loadConfig(_ config:AutoQueryViewerConfig)
    {
        lblTitle.text = config.serviceName
        txtDescription.text = config.serviceDescription

        if let textColor = config.textColor {
            lblTitle.textColor = UIColor(rgba: textColor)
            txtDescription.textColor = UIColor(rgba: textColor)
            spinner.color = UIColor(rgba: textColor)
        }
        if let linkColor = config.linkColor {
            btnBack.setTitleColor(UIColor(rgba: linkColor), for: UIControlState())
        }
        if let backgroundColor = config.backgroundColor {
            view.backgroundColor = UIColor(rgba: backgroundColor)
        }
        
        if var brandImageUrl = config.brandImageUrl {
            if brandImageUrl.hasPrefix("/") {
                brandImageUrl = config.serviceBaseUrl!.combinePath(brandImageUrl)
            }
            self.addBrandImage(brandImageUrl, action: #selector(AutoQueryServiceViewController.btnBrandGo(_:)))
        }
        
        if var backgroundImageUrl = config.backgroundImageUrl {
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
        let brandUrl = response?.config?.brandUrl
        if brandUrl != nil {
            if let nsUrl = URL(string: brandUrl!) {
                UIApplication.shared.openURL(nsUrl)
            }
        }
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return operations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "cellService")
            ?? UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cellService")
        
        if let config = response?.config {
            if let bgColor = config.backgroundColor {
                cell.backgroundColor = UIColor(rgba: bgColor)
            }
            if let textColor = config.textColor {
                cell.textLabel?.textColor = UIColor(rgba: textColor)
                cell.detailTextLabel?.textColor = UIColor(rgba: textColor)
            }
        }

        let op = operations[indexPath.row]
        let opType = response?.getType(op.request)
        
        cell.textLabel?.text = opType?.getViewerAttrProperty("Title")?.value ?? op.request
        cell.detailTextLabel?.text = opType?.getViewerAttrProperty("Description")?.value
        
        cell.imageView!.image = self.appData.imageCache["clearIcon"]
        if let iconUrl = opType?.getViewerAttrProperty("IconUrl")?.value {
            let fullIconUrl = response?.config?.serviceBaseUrl?.combinePath(iconUrl)
            cell.imageView!.loadAsync(fullIconUrl, defaultImage:"clearIcon", withSize: CGSize(width: 50, height: 50))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    @IBAction func prepareForUnwind(_ segue: UIStoryboardSegue) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedIndex = tblView.indexPathForSelectedRow {
            tblView.deselectRow(at: selectedIndex, animated: false)

            if let autoQueryVC = segue.destination as? AutoQueryViewController {
                autoQueryVC.selectedOperation = operations[selectedIndex.row]
                autoQueryVC.response = response!
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let autoQueryVC = self.storyboard?.instantiateViewController(withIdentifier: "AutoQueryViewController") as! AutoQueryViewController
        self.addChildViewController(autoQueryVC)
        self.performSegue(withIdentifier: "autoquerySegue", sender:self)
    }
}
