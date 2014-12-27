#
# Be sure to run `pod lib lint iTunesApi.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "iTunesApi"
  s.version          = "0.1.0"
  s.summary          = "iTunesApi, asynchronous API controller for the iTunes Search API and iTunes Feeds."
  s.description      = "iTunesApi is a simple, asynchronous API controller and object for searching the iTunes Search API and iTunes Feeds."
  s.homepage         = "https://github.com/ericpinet/iTunesApi"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Eric Pinet" => "pineri01@gmail.com" }
  s.source           = { :git => "https://github.com/ericpinet/iTunesApi.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'iTunesApi' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AFNetworking', '~> 1.3.4'
  s.dependency 'RestKit', '~> 0.23.1'
end
