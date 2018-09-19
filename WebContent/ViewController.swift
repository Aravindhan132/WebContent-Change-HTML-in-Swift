import UIKit
import WebKit
import Foundation

class ViewController: UIViewController , WKUIDelegate {
    
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var webview: WKWebView!
    let file = "index.html"
    let htmlFile2 = Bundle.main.path(forResource: "sample", ofType: "html")
    
    override func viewDidLoad() {
        print("Blockquote present")
        let htmlString2 = try? String(contentsOfFile: htmlFile2!, encoding: String.Encoding.utf8)

        if htmlString2?.contains("blockquote") ?? false    {
            print("Before Added" , htmlString2 ?? "no content available")
            let name : String = stringFromHTML(string: htmlString2)
           
            let new2 = htmlString2?.replacingOccurrences(of: "</div>\n", with: " </div> <script> var coll = document.getElementsByClassName(\"collapsible\"); var i; for (i = 0; i < coll.length; i++) { coll[i].addEventListener(\"click\", function() { this.classList.toggle(\"active\"); var content = this.nextElementSibling; if (content.style.maxHeight){ content.style.maxHeight = null; } else { content.style.maxHeight = content.scrollHeight + \"px\"; } } ); } </script>")
            let result =  new2?.replacingOccurrences(of: "<divclass=\"content\">", with: "<div class=\"content\">")
            let final = result?.replacingOccurrences(of:"<buttonclass=\"collapsible\">...</button>" , with: "<button class=\"collapsible\">...</button>")
            webview.loadHTMLString(final ?? "Not load" , baseURL: nil)
            text.text = name
            print("after added" , final ?? "Not load")
            
        } else {
            print("Not present")
            
            text.text = "Not present"
         }
        super.viewDidLoad()
      }
    
    func stringFromHTML( string: String?) -> String
    {
        do{
            let str = try NSAttributedString(data:string!.data(using: String.Encoding.utf8, allowLossyConversion: false
                )!, options:[.documentType: NSAttributedString.DocumentType.html , .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            return str.string
        }  catch
        
        {
            print("html error\n",error)
        }
        return ""
    }
    
    
}

 
