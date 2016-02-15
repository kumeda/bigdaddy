json.array!(@reports) do |report|
  json.extract! report, :id, :title, :content, :photo_url
  json.url report_url(report, format: :json)
end
