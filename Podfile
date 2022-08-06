platform :ios, '13.0'

def working_pods
use_frameworks!
  # Удалить
  pod 'SnapKit', :inhibit_warnings => true
  pod 'Swinject', :inhibit_warnings => true
  pod 'EANBarcodeGenerator', :inhibit_warnings => true

  pod 'OverlayContainer', :inhibit_warnings => true

  # Перенести локально
  pod 'YZNumPad', :git => 'https://github.com/YarZav/YZNumPad.git', :tag => '1.1.0'
  pod 'YZBarChart', :git => 'https://github.com/YarZav/YZBarChart.git', :tag => '1.2.0'
  pod 'YZNotificationView', :git => 'https://github.com/YarZav/YZNotificationView.git', :tag => '1.1.0'
  pod 'YZPinCodeViewController', :git => 'https://github.com/YarZav/YZPinCodeViewController.git', :tag => '1.1.0'
  
  pod 'DataBase', :path => 'LocalPods/Service/DataBase'
  pod 'Business', :path => 'LocalPods/Service/Business'
  pod 'Extension', :path => 'LocalPods/Common/Extension'
  pod 'DesignSystem', :path => 'LocalPods/Common/DesignSystem'

  pod 'DI', :path => 'LocalPods/DI'

  pod 'Cash', :path => 'LocalPods/UserStory/Cash'
  pod 'TabBar', :path => 'LocalPods/UserStory/TabBar'
end

target 'MoneyKeeper' do
  working_pods
end

