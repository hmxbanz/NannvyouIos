platform :ios, '9.0'

target 'nannvyou' do

pod 'RongCloudIM/IMLib', '~> 2.8.23'
pod 'RongCloudIM/IMKit', '~> 2.8.23'
pod 'Alamofire', '~> 4.4.0'
pod 'RealmSwift', '~> 2.8.0'
pod "ObjectMapper+Realm"
pod 'PKHUD', '~> 4.2.3'
pod 'Kingfisher', '~> 3.10.1'  
pod "ESPullToRefresh"
pod 'JPush', '~> 3.0.6'
pod 'SnapKit', '~> 3.2.0'

use_frameworks!

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
 
end
