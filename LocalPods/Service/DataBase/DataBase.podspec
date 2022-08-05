Pod::Spec.new do |s|
  s.platform = :ios
  s.ios.deployment_target = '13.0'
  s.name = "DataBase"
  s.summary = "DataBase service"
  s.requires_arc = true
  s.version = "1.0.0"
  s.author = { "Author" => "https://www.author.ru" }
  s.homepage = "https://www.author.ru"
  s.source = { :git => "", :tag => "#{s.version}"}
  s.framework = "UIKit"
  s.source_files = "DataBase/**/*.swift"
end
