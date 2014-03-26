require 'fileutils'

class Processor

  attr_accessor :file, :token

  ICON_FILE_SIZES = {"152x152\>" => "AppIcon76x76@2x.png",
                     "144x144\>" => "AppIcon72x72@2x.png",
                     "120x120\>" => "AppIcon60x60@2x.png",
                     "114x114\>" => "AppIcon57x57@2x.png",
                     "100x100\>" => "AppIcon50x50@2x.png",
                     "80x80\>"   => "AppIcon40x40@2x.png",
                     "76x76\>"   => "AppIcon76x76.png",
                     "72x72\>"   => "AppIcon72x72.png",
                     "58x58\>"   => "AppIcon29x29@2x.png",
                     "57x57\>"  => "AppIcon57x57.png",
                     "50x50\>"   => "AppIcon50x50.png",
                     "40x40\>"   => "AppIcon40x40.png",
                     "29x29\>"   => "AppIcon29x29.png"}
  
#   LAUNCH_FILE_SIZES = {"640x1136" => ,
#                          "640x960" => ,
#                          "1536x2048" => , 
#                          "2048x1536" => , 
#                          "768x1024" => , 
#                          "1024x768" => } 
# iPad Landscape iOS6 no status bar.png
# iPad Landscape iOS6 no status bar@2x-1.png
# iPad Landscape iOS7.png
# iPad Landscape iOS7@2x.png
# iPad Portrait iOS6 no status bar.png
# iPad Portrait iOS6 no status bar@2x.png
# iPad Portrait iOS7.png
# iPad Portrait iOS7@2x.png
# iPhone Portrait iOS7 R4.png
# iPhone Portrait iOS7@2x.png
#   }

  def initialize(file, token, type)
    @file = file
    @token = token
    @type = type
  end

  def self.create(file, token, type)
    processor = new(file, token, type)
    processor.process
    processor
  end

  def path
    "public/uploads/#{token}/"
  end

  def zip
    "public/uploads/#{token}.zip"
  end

  def process
    case type
    when :icon
      create_icons
    when :launch
      create_launch
    end
  end

  def create_icons
    image = MiniMagick::Image.read(file)
    FileUtils.mkdir_p(path)
    FILE_SIZES.each do |size, file_name|
      image.combine_options do |i|
        i.resize size
        i.extent size
        i.gravity 'center'
      end
      image.format 'png'
      image.write path+file_name
    end
  end
  
  def create_launch
  end

  def zipped
    Zip::File.open(zip, Zip::File::CREATE) do |zipfile|
      Dir[File.join(path, '**', '**')].each do |file|
        zipfile.add(file.sub(path, ''), file)
      end
    end
    FileUtils.rm_rf path
    FileUtils.chmod 0644, zip
    zip
  end

end