class WelcomeController < ApplicationController

  skip_before_filter :require_login

  def index



        @calls_overview_data = []

        @calls_overview_labels = []

      today= Time.now.end_of_day
      daysToSee = 30

      daysToSee.times do

      numcalls = Call.where(created_at: (today - 1.day)..today).length

        today = today - 1.day

        datetime_unix = ((today - 12.hours).to_i )

        datetime = Time.at(datetime_unix)

      @calls_overview_data.push numcalls
      @calls_overview_labels.push datetime.strftime("%b %d")

     end

     @calls_overview_data = @calls_overview_data.reverse
      @calls_overview_labels = @calls_overview_labels.reverse

  end
end
