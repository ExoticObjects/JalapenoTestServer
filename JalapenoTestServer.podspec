# To package with cocoapods-packager, cd to podspec dir then use this command:
# pod package JalapenoTestServer.podspec --spec-sources='https://github.com/ExoticObjects/eo-attributed-markdown-podspec.git','https://github.com/ExoticObjects/JalapenoTestServer.git','https://github.com/ExoticObjects/fmdb.git','https://github.com/ExoticObjects/JalapenoSocketIOClient.git','https://github.com/CocoaPods/Specs.git' --embedded --force
#
# To lint:
# pod spec lint --verbose --allow-warnings --sources='https://github.com/ExoticObjects/eo-attributed-markdown-podspec.git','https://github.com/ExoticObjects/JalapenoTestServer.git','https://github.com/ExoticObjects/fmdb.git','https://github.com/ExoticObjects/JalapenoSocketIOClient.git','https://github.com/CocoaPods/Specs.git'

Pod::Spec.new do |s|
  s.name             = "JalapenoTestServer"
  s.module_name      = "JalapenoTestServer"
  s.version          = "0.1.8"
  s.summary          = "Some kind of description." 
  s.description      = "A meaningless description"
  s.homepage         = "https://github.com/ExoticObjects/JalapenoTestServer"
  s.license          = 'MIT'
  s.author           = { "Exotic Objects" => "jim@exoticobjects.com" }
  s.source           = { :git => "https://github.com/ExoticObjects/JalapenoTestServer.git" }
  s.platform     = :ios, '9.0'
  s.requires_arc = true
  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'JalapenoTestServer' => ['Pod/Assets/*.png']
  }
  s.dependency 'Swifter', '1.0.6'
end
