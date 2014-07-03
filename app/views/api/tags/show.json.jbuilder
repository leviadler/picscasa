json.(@tag, :name, :id)
json.photos @photos, partial: 'api/photos/photo', as: :photo