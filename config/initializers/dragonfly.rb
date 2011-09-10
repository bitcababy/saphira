require 'dragonfly/rails/images'

app = Dragonfly[:images]
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