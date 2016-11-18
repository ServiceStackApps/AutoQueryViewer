//
//  ExampleMDSpreadViewController.swift
//  AutoQueryViewer
//
//  Created by Demis Bellot on 2/15/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import UIKit


func fromA(_ asciiCode:Int) -> String {
    let s = "\(UnicodeScalar(asciiCode + 97))"
    return s
}

class ExampleMDSpreadViewController: UIViewController, MDSpreadViewDataSource, MDSpreadViewDelegate {
    
    var data:NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for a in 0 ..< 2 {
            let rowSections = NSMutableArray()
            
            for b in 0 ..< 2 {
                let columnSections = NSMutableArray()
                
                for c in 0 ..< 20 {
                    let row = NSMutableDictionary()
                    
                    for d in 0 ..< 5 {
                        let string = NSMutableString(capacity: 10)
                        
                        for _ in 0 ..< 2 {
                            string.append("\(fromA(Int(arc4random_uniform(26))))")
                        }
                        
                        row["column\(fromA(a))\(fromA(b))\(fromA(d))"] = string
                    }
                    
                    row["header\(fromA(a))\(fromA(b))"] = "\(c + 1)"
                    
                    columnSections.add(row)
                }
                
                rowSections.add(columnSections)
            }
            
            data.add(rowSections)
        }
        
        let mdView = MDSpreadView(frame: CGRect(x: 20, y: 20, width: self.view.frame.width - 40, height: self.view.frame.height - 40))
        mdView.dataSource = self
        mdView.delegate = self
        self.view.addSubview(mdView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
        return 20
    }
    
    func spreadView(_ aSpreadView:MDSpreadView, numberOfColumnsInSection:NSInteger) -> NSInteger
    {
        return 5
    }
    
    func spreadView(_ aSpreadView:MDSpreadView, objectValueForRowAt rowPath:MDIndexPath, forColumnAt columnPath:MDIndexPath) -> Any
    {
        print("spreadView \(rowPath.section) \(columnPath.section)")
        
        let o = data.object(at: rowPath.section) as! NSMutableArray
        let c = o.object(at: columnPath.section) as! NSMutableArray
        let d = c.object(at: rowPath.row) as! NSMutableDictionary
        
        let key = "column\(fromA(rowPath.section))\(fromA(columnPath.section))\(fromA(columnPath.column))"
        return d.object(forKey: key)! as AnyObject
    }
    
    func spreadView(_ aSpreadView:MDSpreadView, titleForHeaderInColumnSection section:NSInteger, forRowAt rowPath:MDIndexPath)  -> Any
    {
        print("spreadView titleForHeader \(rowPath.section) \(section)")
        
        let o = data.object(at: rowPath.section) as! NSMutableArray
        let c = o.object(at: section) as! NSMutableArray
        let d = c.object(at: rowPath.row) as! NSMutableDictionary
        
        let key = "header\(fromA(rowPath.section))\(fromA(section))"
        return d.object(forKey: key)! as AnyObject
    }
    
    func spreadView( _ aSpreadView:MDSpreadView, titleForHeaderInRowSection section:NSInteger, forColumnAt columnPath:MDIndexPath) -> Any
    {
        return "Column \(columnPath.column+1)" as AnyObject
    }
    
    func spreadView(_ aSpreadView:MDSpreadView, titleForHeaderInRowSection rowSection:NSInteger, forColumnSection columnSection:NSInteger) -> Any
    {
        return "•" as AnyObject
    }
    
    /* Display Customization */
    func spreadView(_ aSpreadView:MDSpreadView, heightForRowAt indexPath:MDIndexPath) -> CGFloat
    {
        return 20
    }
    
    func spreadView(_ aSpreadView:MDSpreadView, heightForRowHeaderInSection rowSection:NSInteger) -> CGFloat
    {
        return 20
    }
    
    func spreadView(_ aSpreadView:MDSpreadView, heightForRowFooterInSection rowSection:NSInteger) -> CGFloat
    {
        return 0
    }
    
    func spreadView(_ aSpreadView:MDSpreadView, widthForColumnAt indexPath:MDIndexPath) -> CGFloat
    {
        return 20
    }
    
    func spreadView(_ aSpreadView:MDSpreadView, widthForColumnHeaderInSection columnSection:NSInteger) -> CGFloat
    {
        return 20
    }
    
    func spreadView(_ aSpreadView:MDSpreadView, widthForColumnFooterInSection columnSection:NSInteger) -> CGFloat
    {
        return 0
    }
    

    
    //#pragma mark - Sorting
    //
    //- (MDSortDescriptor *)spreadView:(MDSpreadView *)aSpreadView sortDescriptorPrototypeForHeaderInRowSection:(NSInteger)rowSection forColumnSection:(NSInteger)columnSection
    //{
    //    return [MDSortDescriptor sortDescriptorWithKey:[NSString stringWithFormat:@"header%c%c", (unichar)rowSection + 'a', (unichar)columnSection + 'a'] ascending:YES selector:@selector(localizedStandardCompare:) selectsWholeSpreadView:NO];
    //    }
    //
    //    - (MDSortDescriptor *)spreadView:(MDSpreadView *)aSpreadView sortDescriptorPrototypeForHeaderInRowSection:(NSInteger)section forColumnAtIndexPath:(MDIndexPath *)columnPath
    //{
    //    return [MDSortDescriptor sortDescriptorWithKey:[NSString stringWithFormat:@"column%c%c%c", (unichar)section + 'a', (unichar)columnPath.section + 'a', (unichar)columnPath.column + 'a'] ascending:YES selectsWholeSpreadView:NO];
    //    }
    //
    //    - (MDSortDescriptor *)spreadView:(MDSpreadView *)aSpreadView sortDescriptorPrototypeForHeaderInColumnSection:(NSInteger)section forRowAtIndexPath:(MDIndexPath *)rowPath
    //{
    //    return nil;
    //    }
    //
    //    //- (MDSortDescriptor *)spreadView:(MDSpreadView *)aSpreadView sortDescriptorPrototypeForHeaderInRowSection:(NSInteger)rowSection forColumnFooterSection:(NSInteger)columnSection;
    //    //- (MDSortDescriptor *)spreadView:(MDSpreadView *)aSpreadView sortDescriptorPrototypeForHeaderInColumnSection:(NSInteger)columnSection forRowFooterSection:(NSInteger)rowSection;
    //    //
    //    //- (MDSortDescriptor *)spreadView:(MDSpreadView *)aSpreadView sortDescriptorPrototypeForFooterInRowSection:(NSInteger)rowSection forColumnSection:(NSInteger)columnSection;
    //    //- (MDSortDescriptor *)spreadView:(MDSpreadView *)aSpreadView sortDescriptorPrototypeForFooterInRowSection:(NSInteger)section forColumnAtIndexPath:(MDIndexPath *)columnPath;
    //    //- (MDSortDescriptor *)spreadView:(MDSpreadView *)aSpreadView sortDescriptorPrototypeForFooterInColumnSection:(NSInteger)section forRowAtIndexPath:(MDIndexPath *)rowPath;
    //
    //    - (void)spreadView:(MDSpreadView *)aSpreadView sortDescriptorsDidChange:(NSArray *)oldDescriptors
    //{
    //    MDSortDescriptor *firstDescriptor = aSpreadView.sortDescriptors.firstObject;
    //    [(NSMutableArray *)[[data objectAtIndex:firstDescriptor.rowSection] objectAtIndex:firstDescriptor.columnSection] sortUsingDescriptors:aSpreadView.sortDescriptors];
    //    [aSpreadView reloadData];
    //}
    //
    
}

