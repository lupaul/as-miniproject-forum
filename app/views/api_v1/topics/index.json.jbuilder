# json.data do
#   json.array! @topics do |topic|
#     json.partial! topic
#   end
# end
#等同於
json.data do
  json.array! @topics, partial: 'api_v1/topics/topic', as: :topic
end
