for i in 0..4
  LightLog.create!(event: true, light_id: 1)
  LightLog.create!(event: false, light_id: 1)
end

tdlogs = LightLog.all
crday = Date.today
cnt = 2

tdlogs.each do |lelog|
  lelog.update_attribute :created_at, ( crday + cnt.hours )
  cnt = cnt + 2
end
