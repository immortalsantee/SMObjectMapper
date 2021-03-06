Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '8.0'
s.name = "SMObjectMapper"
s.summary = "SMObjectMapper lets a uer create module object from Json file"
s.requires_arc = true

s.version = "0.1.0"
s.license = { :type => "MIT", :file => "LICENSE" }
s.author = { "Santosh Maharjan" => "immortalsantee@me.com" }

s.homepage = "https://github.com/immortalsantee/SMObjectMapper"
s.source = { :git => "https://github.com/immortalsantee/SMObjectMapper.git", :tag => "#{s.version}"}

# s.framework = "UIKit"
s.source_files = "SMObjectMapper/**/*.{swift}"
# s.resources = "SMObjectMapper/**/*.{png,jpeg,jpg,storyboard,xib}"

end