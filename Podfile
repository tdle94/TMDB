# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

def testing_pods
  pod 'Quick'
  pod 'Nimble'
  pod "Cuckoo"
  pod 'RealmSwift'
  pod 'SDWebImage'
  pod 'Cosmos'
  pod 'Toast-Swift'
end

target 'TMDB' do
  use_frameworks!
  pod 'RealmSwift'
  pod 'SDWebImage'
  pod 'Cosmos'
  pod 'Toast-Swift'
  pod 'Swinject'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxSwiftExt'
  pod 'RxSwiftUtilities'
  pod 'RxDataSources'

  target 'TMDBTests' do
    inherit! :search_paths
    testing_pods
  end

end
