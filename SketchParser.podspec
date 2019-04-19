#
#  Be sure to run `pod spec lint SketchParser.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "SketchParser"
  s.version      = "0.0.1"
  s.author       = { "Ayal Spitz" => "aspitz@blackgecko.com" }
  s.license      = { :type => "MIT" }
  s.homepage     = "https://www.blackgecko.com"
  s.summary      = "Code to read the Sketch file format"

  s.ios.deployment_target = "12.0"

  s.source       = { :git => "https://bitbucket.org/aspitz/sketchparser.git", :tag => '0.0.1' }
  s.source_files = "SketchParser/SketchParser/**/*.swift", "SketchParser/Sketch Document/**/*.swift"

  s.swift_version = '5.0'
end
