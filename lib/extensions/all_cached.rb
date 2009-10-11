# This extension enables user to quickly add caching functionality to any AR model
# Just include this module in any of your models, i.e.
# class Post < ActiveRecord::Base
# include AllCached
# end
# to have "all_cached" method available

module AllCached

  def self.included(base) #:nodoc:
    base.class_eval do
      send :extend, ClassMethods
      send :include, InstanceMethods
      after_save :update_cache
      after_destroy :update_cache
    end
  end

  module InstanceMethods
    private

    # Clears cached set of records, so during next call to "all_cached" cache will be regenerated
    def update_cache
      Rails.cache.delete("All#{self.class.name.to_s}")
    end
  end

  module ClassMethods
    # Return cached set of records instead of fetching them from database
    def all_cached
      Rails.cache.fetch("All#{self.name.to_s}"){ all }
    end
  end

end