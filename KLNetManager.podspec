Pod::Spec.new do |s|
s.name         = "KLNetManager"
s.version      = "0.0.1"
s.summary      = "一个简易的网络请求，结合了MJExtension，请求与解析数据"

s.homepage     = "https://github.com/KingLight/KLNetManager.git"
s.license      = "MIT"

s.author             = { "King" => "dreamhut417@163.com" }
s.platform     = :ios
s.platform     = :ios, "9.0"

s.source       = { :git => "https://github.com/KingLight/KLNetManager.git", :tag => "#{s.version}" }
s.source_files  = "KLNetManager/KLNetManager/*.{h,m}"
s.framework  = "Foundation"

s.requires_arc = true
s.dependency "AFNetworking", "~> 3.2.1"
s.dependency "MJExtension", "~> 3.0.15"

end
