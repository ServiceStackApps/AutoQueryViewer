//
//  FindAutoQueryServiceViewController.swift
//  AutoQueryViewer
//
//  Created by Demis Bellot on 2/14/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import UIKit

class FindAutoQueryServiceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var txtUrl: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var viewFooter: UIView!
    @IBOutlet weak var imgBackground: UIImageView!
    
    var autoQueryClient = JsonServiceClient(baseUrl: "http://autoqueryviewer.servicestack.net")
    var response:GetAutoQueryServicesResponse?
    var services:[AutoQueryService] = []
    var selectedService:AutoQueryService?
    var selectedResponse:AutoQueryMetadataResponse?
    
    override func viewWillAppear(animated: Bool) {
        if response != nil {
            reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.stopAnimating()
        tblView.hidden = true
        txtUrl.delegate = self

        txtUrl.text = getDefaultSetting("customUrl")
        reloadData()
    }
    
    func reloadData() {
        selectedService = nil
        selectedResponse = nil
        
        spinner.startAnimating()
        self.lblError.text = ""
        
        autoQueryClient.getAsync(GetAutoQueryServices())
            .then { (r:GetAutoQueryServicesResponse) -> AnyObject in
                self.spinner.stopAnimating()
                self.tblView.hidden = false
                
                self.response = r
                self.services = r.results
                self.tblView.reloadData()
                return r
            }
            .error { (e:NSError) -> Void in
                self.spinner.stopAnimating()
                self.lblError.text = "Service Registry is unavailable"
            }
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCellWithIdentifier("cellServices")
            ?? UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cellServices")
        
        cell.backgroundColor = UIColor.clearColor()
        let op = services[indexPath.row]
        
        cell.textLabel?.text = op.serviceName
        cell.detailTextLabel?.text = op.serviceDescription
        
        var iconUrl = op.serviceIconUrl
        if iconUrl != nil && iconUrl!.hasPrefix("/") {
            iconUrl = op.serviceBaseUrl!.combinePath(iconUrl!)
        }
        
        cell.imageView?.loadAsync(iconUrl, defaultImage: "database", withSize: CGSize(width: 50, height: 50))
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let selectedIndex = tblView.indexPathForSelectedRow {
            tblView.deselectRowAtIndexPath(selectedIndex, animated: false)
        }
        
        if let autoQueryVC = segue.destinationViewController as? AutoQueryServiceViewController {
            autoQueryVC.service = selectedService
            autoQueryVC.response = selectedResponse
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedService = services[indexPath.row]
        self.selectedResponse = nil
        self.openAutoQueryServiceViewController()
    }
    
    func openAutoQueryServiceViewController() {
        let autoQueryVC = self.storyboard?.instantiateViewControllerWithIdentifier("AutoQueryServiceViewController") as! AutoQueryServiceViewController
        self.addChildViewController(autoQueryVC)
        self.performSegueWithIdentifier("servicesSegue", sender:self)
    }
    
    /* Custom Url */
    
    func textFieldShouldReturn(textField:UITextField) -> Bool {
        connect()
        return true
    }
    
    @IBAction func connect() {
        
        txtUrl.resignFirstResponder()
        
        if txtUrl.text!.count >= 2 && !txtUrl.text!.hasPrefix("http") {
            txtUrl.text = "http://\(txtUrl.text)"
        }
        
        let url = NSURL(string: txtUrl.text!)
        if url?.host != nil {
            
            let client = JsonServiceClient(baseUrl: txtUrl.text!)
            client.getAsync(AutoQueryMetadata())
                .then { (r:AutoQueryMetadataResponse) -> AnyObject in
                    self.spinner.stopAnimating()
                    self.tblView.hidden = false
                    
                    if r.config != nil && r.config?.serviceBaseUrl != nil {
                        saveDefaultSetting("customUrl", value: self.txtUrl.text!)
                        self.selectedResponse = r
                        self.selectedService = nil
                        self.openAutoQueryServiceViewController()
                        
                        if r.config!.isPublic == true {
                            let request = RegisterAutoQueryService()
                            request.baseUrl = r.config!.serviceBaseUrl
                            self.autoQueryClient.postAsync(request)
                        }
                    }
                    else {
                        self.lblError.text = "AutoQuery is unavailable"
                    }
                    
                    return r
                }
                .error { (e:NSError) -> Void in
                    self.spinner.stopAnimating()
                    self.lblError.text = "Host is unavailable"
                }
        }
        else {
            lblError.text = "Invalid Url"
        }
    }
}

