# Uncomment the next line to define a global platform for your project
platform :ios, '13.5'

def testing_pods
  pod 'Quick'
  pod 'Nimble'
  pod "Cuckoo"
  pod 'RealmSwift'
end

target 'TMDB' do
  use_frameworks!
  pod 'RealmSwift'
  pod 'SDWebImage'

  target 'TMDBTests' do
    inherit! :search_paths
    testing_pods
  end
  
  target 'TMDBUITests' do
      inherit! :search_paths
      testing_pods
      pod 'SDWebImage'
  end

end
