class WelcomeController < ApplicationController

   

  def index



        @calls_overview_data = []

        @calls_overview_labels = []

      end_of_today = Time.now.end_of_day

      daysToSee = 30

      daysToSee.times do

        beginning_of_today = (end_of_today - 1.day)

      numcalls = Call.where(created_at: beginning_of_today..end_of_today).length

        datetime_unix = ((beginning_of_today + 6.hours).to_i )

        datetime = Time.at(datetime_unix)

      @calls_overview_data.push numcalls
      @calls_overview_labels.push datetime.strftime("%b %d")

      end_of_today = end_of_today - 1.day

     end

     @calls_overview_data = @calls_overview_data.reverse
      @calls_overview_labels = @calls_overview_labels.reverse

  end
end
