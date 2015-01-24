#
# Be sure to run `pod lib lint LXBoardGameGeek.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = "LXBoardGameGeek"
s.version          = "0.1.0"
s.summary          = "API wrapper for www.boardgamegeek.com's XMLAPI 2"
# s.description      = <<-DESC
#                     An optional longer description of LXBoardGameGeek
#
#                      * Markdown format.
#                      * Don't worry about the indent, we strip it!
#                      DESC
s.homepage         = "https://github.com/awnton/LXBoardGameGeek"
# s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
s.license          = 'MIT'
s.author           = { "Anton" => "anton@lyxit.se" }
s.source           = { :git => "https://github.com/awnton/LXBoardGameGeek.git", :tag => s.version.to_s }
s.social_media_url = 'https://twitter.com/awnton'

s.platform     = :ios, '7.0'
s.requires_arc = true

s.source_files = 'Pod/Classes/**/*.{h,m}'
s.resource_bundles = {
'LXBoardGameGeek' => ['Pod/Assets/*.png']
}

# s.public_header_files = 'Pod/Classes/*/*.h'
s.private_header_files = "Pod/Classes/Private/*.h"
# s.frameworks = 'UIKit', 'MapKit'
s.dependency 'XMLDictionary', '~> 1.4'
end
