class IconUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # App
  # [57,57]   => AppIcon57x57.png
  # [114,114] => AppIcon57x57@2x.png
  # [120,120] => AppIcon60x60@2x.png
  # [72,72]   => AppIcon72x72.png
  # [144,144] => AppIcon72x72@2x.png
  # [76,76]   => AppIcon76x76.png
  # [152,152] => AppIcon76x76@2x.png


  # Spotlight
  # [29,29]   => AppIcon29x29.png
  # [58,58]   => AppIcon29x29@2x.png
  # [50,50]   => AppIcon50x50.png
  # [100,100] => AppIcon50x50@2x.png
  # [40,40]   => AppIcon40x40.png
  # [80,80]   => AppIcon40x40@2x.png


end