class FriendsAnalyzerJob < ActiveJob::Base
  queue_as :default

  def perform(id)
    analyzer = FriendsAnalyzer.new(id)
    analyzer.process
  end
end
