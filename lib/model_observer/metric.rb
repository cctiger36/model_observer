module ModelObserver
  class Metric
    attr_accessor :model_class, :model_id, :started_at, :ended_at

    def initialize(model, started_at, ended_at)
      @model_class = model.class
      @model_id = model.__send__(model.class.primary_key) if model.class.primary_key
      @started_at = started_at
      @ended_at = ended_at
    end

    def duration
      ((ended_at.to_f - started_at.to_f) * 1000).round(1)
    end
  end
end
