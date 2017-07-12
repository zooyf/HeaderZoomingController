
    Pod::Spec.new do |s|  
      
      s.name         = "WHAddVC"  
      s.version      = "1.0.3"  
      s.summary      = "Simple one line code."  
      s.homepage     = "https://github.com/remember17/WHAddVC"  
      s.license      = "MIT"  
      s.author       = { "wuhao" => "503007958@qq.com" }  
      s.platform     = :ios, "7.0"  
      s.source       = { :git => "https://github.com/remember17/WHAddVC.git", :tag => s.version }  
      s.source_files  = "WHAddVC", "WHAddVC/*.{h,m}"  
      s.framework  = "UIKit"  
      s.requires_arc = true   
      s.dependency 'Masonry'
      
    end  