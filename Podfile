platform :ios, '8.0'
use_frameworks!

def common_pods
  pod 'SnapKit', '0.22.0'
  pod 'CryptoSwift', '0.5.2'
  pod 'SDWebImage', '3.8'
end

target 'WMobileKit' do
  common_pods
end

target 'WMobileKitTests' do
  common_pods
  pod 'Quick', '0.9.3'
  pod 'Nimble', '4.1.0'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '2.3'
        end
    end
end
