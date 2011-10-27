require 'dragonfly/rails/images'
require 'dragonfly-rmagick'

DRAGONFLY_APP = Dragonfly[:images]
DRAGONFLY_APP.configure_with(:rmagick)

app = DRAGONFLY_APP
app.datastore.root_path = ::Rails.root.join('system/files', ::Rails.env).to_s
app.job :thumb_square do |size|
  process :thumb, "#{size}x#{size}#"
end

# execute manipulation string
app.job :manipulate do |manipulations|
  manipulations.split(' ').each do |manipulation|
    process :thumb, manipulation
  end
end