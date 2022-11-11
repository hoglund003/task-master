class StatsController < ApplicationController
  def index
    records = TaskRecord.all.order(:done_at => :DESC).first(60)
    tasks = Task.all
    users = User.all

    # Show number of tasks node each date
    @tasks_per_day = {}
    records.each do |record|
      record_date = record.done_at.midnight.to_date
      @tasks_per_day[record_date] = TaskRecord.all.where(done_at: record_date).count
    end

    @busiest_days = {}
    Date::DAYNAMES[1..-2].each_with_index do |dayname, index| # Loop Monday to Friday
      all_records_wday = TaskRecord.all.select{|record| record.done_at.wday == index}.count # all records that was none on this weekday
      all_wdays_recorded = TaskRecord.all.pluck(:done_at).uniq.select{|date| date.wday == index}.count
      # binding.pry
      @busiest_days[dayname] = all_records_wday/ [all_wdays_recorded, 1].max
    end
  end
end
