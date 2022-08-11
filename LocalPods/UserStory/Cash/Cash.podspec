Pod::Spec.new do |s|
  s.platform = :ios
  s.ios.deployment_target = '13.0'
  s.name = "Cash"
  s.summary = "Cash module"
  s.requires_arc = true
  s.version = "1.0.0"
  s.author = { "Author" => "https://www.author.ru" }
  s.homepage = "https://www.author.ru"
  s.source = { :git => "", :tag => "#{s.version}"}
  s.framework = "UIKit"
  s.dependency 'YZNumPad'
  s.dependency 'Business'
  s.dependency 'Extension'
  s.dependency 'DesignSystem'
  s.dependency 'Swinject'
  s.dependency 'DI'
  s.dependency 'OverlayContainer'
  s.dependency 'YZBarChart'
  s.source_files = "Cash/**/*.swift"
  s.resources = 'Cash/Resources/**/*.{xcassets,strings}'
end
