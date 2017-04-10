# json.內容 do
#   json.id @topic.id
#   json.name @topic.name
#   json.data do
#     json.time @topic.created_at
#     json.update @topic.updated_at
#   end
# end

#等同於
# json.partial!  @topic

#等同於
json.partial! 'topic', topic: @topic
