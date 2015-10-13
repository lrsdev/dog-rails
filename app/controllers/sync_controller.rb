class SyncController < ApplicationController

  def index
    if params[:from]
      @timestamp = params[:from]
      @sync = Sync.new()

      # Goto database once for each model
      @locations = Location.where("updated_at >= ?", @timestamp).order(id: :asc)
      @animals = Animal.where("updated_at >= ?", @timestamp).order(id: :asc)

      # Get active locations from active record relation, and records which are inactive, but
      # were created before the timestamp (should be present in users local database)
      @sync.locations= @locations.where("active = ?", true)
      @sync.deleted_location_ids= @locations.where("active = ? and created_at < ?", false, @timestamp).ids

      # Repeat for animals
      @sync.animals= @animals.where("active = ?", true)
      @sync.deleted_animal_ids= @animals.where("active = ? and created_at < ?", false, @timestamp).ids

      @sync.sync_elapsed= Time.now - @sync.synced_at
    end
    render json: @sync, serializer: SyncSerializer
  end
end
