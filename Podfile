# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'AppStore' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for AppStore
  pod 'Alamofire'
  pod 'SDWebImage'
  pod 'RxSwift', '~> 4.0'
  pod 'RxCocoa', '~> 4.0'
  pod 'Cosmos', '~> 16.0'
  
  post_install do |installer|
      installer.pods_project.build_configurations.each do |config|
          config.build_settings.delete('CODE_SIGNING_ALLOWED')
          config.build_settings.delete('CODE_SIGNING_REQUIRED')
      end
  end
  
  target 'AppStoreTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'AppStoreUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
