Pod::Spec.new do |s|
  s.platform = :ios
  s.ios.deployment_target = '13.0'
  s.name = "TabBar"
  s.summary = "TabBar module"
  s.requires_arc = true
  s.version = "1.0.0"
  s.author = { "Author" => "https://www.author.ru" }
  s.homepage = "https://www.author.ru"
  s.source = { :git => "", :tag => "#{s.version}"}
  s.framework = "UIKit"
  s.dependency 'Swinject'
  s.dependency 'DesignSystem'
  s.dependency 'Cash' # Надо бы избавиться от этой зависимости
  s.source_files = "TabBar/**/*.swift"
  s.resources = 'TabBar/Resources/**/*.{xcassets,strings}'
end
