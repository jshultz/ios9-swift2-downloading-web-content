//
//  ViewController.swift
//  Downloading Web Content
//
//  Created by Jason Shultz on 10/5/15.
//  Copyright © 2015 HashRocket. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = NSURL(string: "https://www.stackoverflow.com")!
        
        // The following line will load the whole website including styles, but we can't do anything with it.
//        webView.loadRequest(NSURLRequest(URL: url))
        
        
        
        // This is more powerful, it allows us to download the content and then manipulate the data afterwards. However, it does require a bit more work to make it more pretty if we want to show the content.
        
        // data: the data returned from the site
        // response: the http response code
        // error: if there is a problem, error will know about it
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            // Will happen when task is completed
            if let urlContent = data {
                
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding) // converts encoded data into UTF8 so it's human readable
//                print(webContent)
                
                
                // this allows the page to load before getting displayed so the code doesn't blow up.
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    // self refers to the View Controller we are in. we use self to refer to something that is outside of the closure that we are currently in right now.
                    self.webView.loadHTMLString(String(webContent!), baseURL: nil)
                })
               
            } else {
                // show error message
            }
        } // end let task
        
        task.resume() // this will fire the task, otherwise none of that above code will work (minus webView.loadRequest of course, which is commented out anyway)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

