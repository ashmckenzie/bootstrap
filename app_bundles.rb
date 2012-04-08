[
  { 'Dropbox.app' => 'http://cdn.dropbox.com/Dropbox%201.2.49.dmg' },
  { 'Google Chrome.app' => 'https://dl-ssl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg' },
  { 'Skitch.app' => 'http://get.skitch.com/skitch.zip' },
  { 'Skype.app' => 'http://download.skype.com/macosx/Skype_2.8.0.851.dmg' },
  { 'Transmit.app' => 'http://www.panic.com/transmit/d/Transmit 4.1.7.zip' },
  { 'Postbox.app' => 'http://download.getpostbox.com.s3.amazonaws.com/installers/3.0.3/1_8065a9cd330b254ee35833e92a319ef3a4b20d1e/postbox-3.0.3-mac64.dmg' },
  { 'Twitterrific.app' => 'http://iconfactory.com/assets/software/twitterrific/Twitterrific-4.4.8.zip' },
  { 'Sublime Text.app' => 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202%20Build%202190.dmg' },
  { 'iTerm.app' => 'http://iterm2.googlecode.com/files/iTerm2_v1_0_0.zip' },
  { '1Password.app' => 'https://d13itkw33a7sus.cloudfront.net/dist/1P/mac/1Password-3.8.18.zip' },
  { 'Alfred.app' => 'http://rwc.cachefly.net/alfred_1.1_189.dmg' },
  { 'Evernote.app' => 'http://www.evernote.com/about/download/get.php?file=EvernoteMac' },
  { 'Pixelmator.app' => 'http://pixelmator.s3.amazonaws.com/Pixelmator167.zip' },
  { 'TotalFinder.app' => 'http://downloads.binaryage.com/TotalFinder-1.3.2.dmg' },
  { 'SourceTree.app' => 'http://downloads.atlassian.com/software/sourcetree/SourceTree_1.3.3.dmg' },
  { 'iStat Menus.app' => 'http://s3.amazonaws.com/bjango/files/istatmenus3/istatmenus3.21.zip' }

].each do |app|

  dep app.keys.first do
    source app.values.first
  end

end