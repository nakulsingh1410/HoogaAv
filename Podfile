# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Hooga' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Hooga

  pod 'Alamofire', '~> 4.5'
  pod 'SwiftyJSON’,’~>3.1.4’
  pod 'Kingfisher’,’~>4.0.1’
  pod 'ObjectMapper’, ‘2.2.8’
  pod 'IQKeyboardManagerSwift'


 target 'HoogaTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'HoogaUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |configuration|
            # these libs work now only with Swift3.2 in Xcode9
            if ['ObjectMapper'].include? target.name
                configuration.build_settings['SWIFT_VERSION'] = "3.2"
            end
        end
    end
end
