require 'dragonfly/rails/images'

DRAGONFLY_APP = Dragonfly[:images]

app = DRAGONFLY_APP
app.datastore.root_path = ::Rails.root.join('system/files', ::Rails.env).to_s
MiniMagick.processor = :gm
app.configure_with(:minimagick)

app.configure do |c|
  c.convert_command = "/opt/local/bin/convert"          # defaults to "convert"
  c.identify_command = "/opt/local/bin/convert"         # defaults to "convert"
#  c.log_commands = true                                 # defaults to false
end

app.job :thumb_square do |size|
  process :thumb, "#{size}x#{size}#"
end

# execute manipulation string
app.job :manipulate do |manipulations|
  p manipulations
  manipulations.split(' ').each do |manipulation|
    p manipulation
    process :thumb, manipulation
  end
end
